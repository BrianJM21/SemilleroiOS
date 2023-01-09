//
//  AddViewController.swift
//  CoreDataLab1
//
//  Created by Brian Jiménez Moedano on 08/01/23.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let birthDateL: UILabel = {
        
        let birthDateL = UILabel()
        birthDateL.text = "Birth Date:"
        birthDateL.translatesAutoresizingMaskIntoConstraints = false
        
        return birthDateL
    }()
    
    lazy var birthDateTF: UITextField = {
        
        let birthDateTF = UITextField()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDateTF.text = formatter.string(from: Date.now)
        birthDateTF.borderStyle = .roundedRect
        birthDateTF.translatesAutoresizingMaskIntoConstraints = false
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(birthDatePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        birthDateTF.inputView = datePicker
        
        return birthDateTF
    }()
    
    let buyDateL: UILabel = {
        
        let buyDateL = UILabel()
        buyDateL.text = "Buy Date:"
        buyDateL.translatesAutoresizingMaskIntoConstraints = false
        
        return buyDateL
    }()
    
    lazy var buyDateTF: UITextField = {
        
        let buyDateTF = UITextField()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        buyDateTF.text = formatter.string(from: Date.now)
        buyDateTF.borderStyle = .roundedRect
        buyDateTF.translatesAutoresizingMaskIntoConstraints = false
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(buyDatePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        buyDateTF.inputView = datePicker
        
        return buyDateTF
    }()
    
    let nameL: UILabel = {
        
        let nameL = UILabel()
        nameL.text = "Name:"
        nameL.translatesAutoresizingMaskIntoConstraints = false
        
        return nameL
    }()
    
    let nameTF: UITextField = {
        
        let nameTF = UITextField()
        nameTF.placeholder = "Ej. Pedro Soto"
        nameTF.borderStyle = .roundedRect
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTF
    }()
    
    let ageL: UILabel = {
        
        let ageL = UILabel()
        ageL.text = "Age:"
        ageL.translatesAutoresizingMaskIntoConstraints = false
        
        return ageL
    }()
    
    let ageTF: UITextField = {
        
        let ageTF = UITextField()
        ageTF.placeholder = "Ej. 31"
        ageTF.borderStyle = .roundedRect
        ageTF.translatesAutoresizingMaskIntoConstraints = false
        
        return ageTF
    }()
    
    let genderL: UILabel = {
        
        let genderL = UILabel()
        genderL.text = "Gender:"
        genderL.translatesAutoresizingMaskIntoConstraints = false
        
        return genderL
    }()
    
    let genderTF: UITextField = {
        
        let genderTF = UITextField()
        genderTF.placeholder = "Ej. Masculine"
        genderTF.borderStyle = .roundedRect
        genderTF.translatesAutoresizingMaskIntoConstraints = false
        
        return genderTF
    }()
    
    let brandL: UILabel = {
        
        let brandL = UILabel()
        brandL.text = "Brand:"
        brandL.translatesAutoresizingMaskIntoConstraints = false
        
        return brandL
    }()
    
    let brandTF: UITextField = {
        
        let brandTF = UITextField()
        brandTF.placeholder = "Ej. Chevrolet"
        brandTF.borderStyle = .roundedRect
        brandTF.translatesAutoresizingMaskIntoConstraints = false
        
        return brandTF
    }()
    
    let modelL: UILabel = {
        
        let modelL = UILabel()
        modelL.text = "Model:"
        modelL.translatesAutoresizingMaskIntoConstraints = false
        
        return modelL
    }()
    
    let modelTF: UITextField = {
        
        let modelTF = UITextField()
        modelTF.placeholder = "Ej. Spark"
        modelTF.borderStyle = .roundedRect
        modelTF.translatesAutoresizingMaskIntoConstraints = false
        
        return modelTF
    }()
    
    let yearL: UILabel = {
        
        let yearL = UILabel()
        yearL.text = "Year:"
        yearL.translatesAutoresizingMaskIntoConstraints = false
        
        return yearL
    }()
    
    let yearTF: UITextField = {
        
        let yearTF = UITextField()
        yearTF.placeholder = "Ej. 2010"
        yearTF.borderStyle = .roundedRect
        yearTF.translatesAutoresizingMaskIntoConstraints = false
        
        return yearTF
    }()
    
    let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "car.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    lazy var buttonView: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Selecciona Imagen"
        configuration.titleAlignment = .center
        
        let buttonView = UIButton(type: .system, primaryAction: UIAction(handler: {
            _ in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        }))
        buttonView.configuration = configuration
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    lazy var addButtonView: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Add Profile"
        configuration.titleAlignment = .center
        
        let addButtonView = UIButton(type: .system, primaryAction: UIAction(handler: { [self]
            _ in
            
            let context = ViewController.shared.persistentContainer.viewContext
            
            let profile = ProfileEntity(context: context)
            let car = CarEntity(context: context)
            
            profile.id = Int32(ViewController.shared.profiles.count + 1)
            profile.name = nameTF.text
            profile.age = Int32(ageTF.text ?? "0") ?? 0
            profile.gender = genderTF.text
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            profile.birthDate = formatter.date(from: birthDateTF.text ?? "01/01/2023")
            
            car.brand = brandTF.text
            car.model = modelTF.text
            car.year = Int32(yearTF.text ?? "0") ?? 0
            car.buyDate = formatter.date(from: buyDateTF.text ?? "01/01/2023")
            
            if let imageData = imageView.image?.pngData() {
                car.photo = imageData
            }
            
            car.profile = profile
            
            do {
                try context.save()
                
                ViewController.shared.loadModel()
                
                print("se guardo el profile")
            } catch {
                context.rollback()
                print("error!!!")
            }
            
            navigationController?.popViewController(animated: true)
        }))
        addButtonView.configuration = configuration
        addButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        return addButtonView
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func birthDatePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDateTF.text = formatter.string(from: sender.date)
    }
    
    @objc func buyDatePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        buyDateTF.text = formatter.string(from: sender.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        view.addSubview(nameL)
        view.addSubview(nameTF)
        view.addSubview(ageL)
        view.addSubview(ageTF)
        view.addSubview(genderL)
        view.addSubview(genderTF)
        view.addSubview(birthDateL)
        view.addSubview(birthDateTF)
        view.addSubview(imageView)
        view.addSubview(buttonView)
        view.addSubview(brandL)
        view.addSubview(brandTF)
        view.addSubview(modelL)
        view.addSubview(modelTF)
        view.addSubview(yearL)
        view.addSubview(yearTF)
        view.addSubview(buyDateL)
        view.addSubview(buyDateTF)
        view.addSubview(addButtonView)
        
        NSLayoutConstraint.activate([
            nameL.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            nameL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            nameL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            nameTF.leftAnchor.constraint(equalTo: nameL.rightAnchor, constant: 5),
            nameTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            nameTF.centerYAnchor.constraint(equalTo: nameL.centerYAnchor),
            nameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            ageL.topAnchor.constraint(equalTo: nameL.layoutMarginsGuide.bottomAnchor, constant: 30),
            ageL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            ageL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            ageTF.leftAnchor.constraint(equalTo: ageL.rightAnchor, constant: 5),
            ageTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            ageTF.centerYAnchor.constraint(equalTo: ageL.centerYAnchor),
            ageTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            genderL.topAnchor.constraint(equalTo: ageL.layoutMarginsGuide.bottomAnchor, constant: 30),
            genderL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            genderL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            genderTF.leftAnchor.constraint(equalTo: genderL.rightAnchor, constant: 5),
            genderTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            genderTF.centerYAnchor.constraint(equalTo: genderL.centerYAnchor),
            genderTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            birthDateL.topAnchor.constraint(equalTo: genderL.layoutMarginsGuide.bottomAnchor, constant: 30),
            birthDateL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            birthDateL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            birthDateTF.leftAnchor.constraint(equalTo: birthDateL.rightAnchor, constant: 5),
            birthDateTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            birthDateTF.centerYAnchor.constraint(equalTo: birthDateL.centerYAnchor),
            birthDateTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),

            imageView.topAnchor.constraint(equalTo: birthDateTF.centerYAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                                          
            buttonView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            brandL.topAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 30),
            brandL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            brandL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            brandTF.leftAnchor.constraint(equalTo: brandL.rightAnchor, constant: 5),
            brandTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            brandTF.centerYAnchor.constraint(equalTo: brandL.centerYAnchor),
            brandTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            modelL.topAnchor.constraint(equalTo: brandL.bottomAnchor, constant: 30),
            modelL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            modelL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            modelTF.leftAnchor.constraint(equalTo: modelL.rightAnchor, constant: 5),
            modelTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            modelTF.centerYAnchor.constraint(equalTo: modelL.centerYAnchor),
            modelTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            yearL.topAnchor.constraint(equalTo: modelL.bottomAnchor, constant: 30),
            yearL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            yearL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            yearTF.leftAnchor.constraint(equalTo: yearL.rightAnchor, constant: 5),
            yearTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            yearTF.centerYAnchor.constraint(equalTo: yearL.centerYAnchor),
            yearTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            buyDateL.topAnchor.constraint(equalTo: yearL.bottomAnchor, constant: 30),
            buyDateL.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            buyDateL.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            buyDateTF.leftAnchor.constraint(equalTo: buyDateL.rightAnchor, constant: 5),
            buyDateTF.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            buyDateTF.centerYAnchor.constraint(equalTo: buyDateL.centerYAnchor),
            buyDateTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            addButtonView.topAnchor.constraint(equalTo: buyDateL.centerYAnchor, constant: 30),
            addButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }


}


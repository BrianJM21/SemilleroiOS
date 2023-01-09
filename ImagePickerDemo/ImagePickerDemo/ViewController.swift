//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Brian Jiménez Moedano on 08/01/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
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

        view.addSubview(imageView)
        view.addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
                                          
            buttonView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }


}


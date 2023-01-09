//
//  DetailsViewController.swift
//  CoreDataLab1
//
//  Created by Brian Jiménez Moedano on 08/01/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var idL: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var ageL: UILabel!
    
    @IBOutlet weak var genderL: UILabel!
    
    @IBOutlet weak var birthDateL: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var brandL: UILabel!
    
    @IBOutlet weak var modelL: UILabel!
    
    @IBOutlet weak var yearL: UILabel!
    
    @IBOutlet weak var buyDateL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idL.text = String(ViewController.shared.profileSeleccionado.id)
        nameL.text = ViewController.shared.profileSeleccionado.name
        ageL.text = String(ViewController.shared.profileSeleccionado.age)
        genderL.text = ViewController.shared.profileSeleccionado.gender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDateL.text = formatter.string(from: ViewController.shared.profileSeleccionado.birthDate ?? Date.now)
        /*
        var index = 0
        let cars = ViewController.shared.cars.filter {
            car in
            index += 1
            return car.profile == ViewController.shared.profileSeleccionado
        }
        
        brandL.text = cars[index].brand
        modelL.text = cars[index].model
        yearL.text = String(cars[index].year)
        */
    }
    

}

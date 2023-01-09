//
//  ViewController.swift
//  CoreDataLab1
//
//  Created by Brian Jiménez Moedano on 08/01/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    static let shared = ViewController()
    
    var profiles: [ProfileEntity] = []
    var cars: [CarEntity] = []
    var profileSeleccionado = ProfileEntity()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DemoModel")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor... \(error)")
            }
        }
        
        return container
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadModel()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func loadModel() {
        
        let context = self.persistentContainer.viewContext
        
        let requestProfile = ProfileEntity.fetchRequest()
        
        let requestCar = CarEntity.fetchRequest()
        
        if let profiles = try? context.fetch(requestProfile) {
            
            self.profiles = profiles
        }
        
        if let cars = try? context.fetch(requestCar) {
            
            self.cars = cars
        }
        
        myTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profiles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "List of Active Profiles"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let profile = self.profiles[indexPath.row]
                
        var configure = cell.defaultContentConfiguration()
        configure.text = profile.name
        cell.contentConfiguration = configure
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        profileSeleccionado = profiles[indexPath.row]
        self.performSegue(withIdentifier: "toDetailSegue", sender: nil)
    }
}

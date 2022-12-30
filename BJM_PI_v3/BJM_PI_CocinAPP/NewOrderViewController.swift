//
//  NewOrderViewController.swift
//  BJM_PI_v1
//
//  Created by User on 28/12/22.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    @IBOutlet weak var currentOrderLabelView: UILabel!
    
    @IBOutlet weak var currentOrderTableView: UITableView!
    
    @IBAction func createOrderActionButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentOrderLabelView.text = "Orden # \(OrderManager.shared.getLastNumberOfOrder())"
        currentOrderTableView.dataSource = self
        currentOrderTableView.delegate = self
    }
    
    @IBAction func addDishToOrder(_ sender: Any) {
        
        performSegue(withIdentifier: "ToAddDishInOrder", sender: nil)
        currentOrderTableView.reloadData()
    }
    
}

extension NewOrderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Platillos Ordenados"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.shared.getDishesCountForCurrentOrder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newOrderDishCell")!
        
        let intIndex = OrderManager.shared.getDishesCountForCurrentOrder() // where intIndex < myDictionary.count
        let index = OrderManager.shared.currentOrder.dishesInOrder.index(OrderManager.shared.currentOrder.dishesInOrder.startIndex, offsetBy: intIndex)
        //myDictionary.keys[index]
        var config = cell.defaultContentConfiguration()
        config.text = OrderManager.shared.currentOrder.dishesInOrder.keys[index]
            
        cell.contentConfiguration = config
        
        
        /*for dishName in OrderManager.shared.currentOrder.dishesInOrder {
            var config = cell.defaultContentConfiguration()
            config.text = "X\(dishName.value) \(dishName.key)"
                
            cell.contentConfiguration = config
        }*/
        
        return cell
    }
    
}

extension NewOrderViewController: UITableViewDelegate {
    
}

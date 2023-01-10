//
//  HomeViewController.swift
//  BJM_PI_v4
//
//  Created by User on 28/12/22.
//

import UIKit

//Se definen dos objetos: Platillo y Orden, que van a representar los modelo del proyecto
struct Dish {
    
    let nombre: String
}

struct Order {
    
    var idOrder: Int = 0
    var dishesInOrder = [(platillo: Dish, veces: Int)]()
}

// Desde la clase HomeViewController conectamos los subViews de la Vista e indicamos que dicha vista es el dataSource y el Delegate de la TableView que despliega las ordenes creadas
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersTableView.dataSource = self
        ordersTableView.delegate = self

    }
// Refrescamos la TableView cada vez que nos situamos en la HomeView
    override func viewWillAppear(_ animated: Bool) {
        ordersTableView.reloadData()
    }
    
    @IBAction func createNewOrder(_ sender: Any) {
        performSegue(withIdentifier: "ToAddOrder", sender: nil)
    }
    
    @IBAction func createDish(_ sender: Any) {
        performSegue(withIdentifier: "ToAddNewDish", sender: nil)
    }
    
    
    @IBOutlet weak var ordersTableView: UITableView!
    
}
// Definimos la clase que se encargará de operar el modelo de Ordenes
class OrderManager {
    // Hacemos una instancia global de la clase para poder operar sobre el modelo Ordenes a través de la aplicación
    static let shared = OrderManager()
    
    var orders: [Order] = []
    var currentOrder = Order()
    
    func getLastNumberOfOrder() -> Int {
        OrderManager.shared.currentOrder.idOrder = OrderManager.shared.orders.count + 1
        return OrderManager.shared.orders.count + 1
    }
    
    func addDishToCurrentOrder(_ dishName: Dish) {
        
        var dishExistsInOrder = false
        var index = 0
        
        for dish in OrderManager.shared.currentOrder.dishesInOrder{
            if dishName.nombre == dish.platillo.nombre {
                dishExistsInOrder = true
                break
            }
            index += 1
        }
        
        if dishExistsInOrder {
            OrderManager.shared.currentOrder.dishesInOrder[index].1 += 1
        } else {
            OrderManager.shared.currentOrder.dishesInOrder.append((dishName, 1))
        }
    }
    
    func getDishesCountForCurrentOrder() -> Int {
        return OrderManager.shared.currentOrder.dishesInOrder.count
    }
    
    func getDishForCurrentOrder(index: Int) -> (platillo: Dish, veces: Int)? {
        if index >= 0 && index < OrderManager.shared.currentOrder.dishesInOrder.count {
            return OrderManager.shared.currentOrder.dishesInOrder[index]
        } else {
            return nil
        }
    }
    
    func addNewOrder(_ newOrder: Order) {
        OrderManager.shared.orders.append(newOrder)
    }
}
// Definimos la calse que se encargará de operar el modelo de Platillos
class AvailableDish {
    // Hacemos una instancia global de la clase para poder operar sobre el modelo Platillo a través de la aplicación
    static let shared = AvailableDish()
    
    var availableDishes: [Dish] = [
        Dish(nombre: "Enchiladas Verdes"),
        Dish(nombre: "Enchiladas Rojas"),
        Dish(nombre: "Enchiladas Suizas"),
        Dish(nombre: "Enchiladas Potosinas")
    ]
    
    func addNewDish(_ newDish: Dish) {
        AvailableDish.shared.availableDishes.append(newDish)
    }
    
    func getDishesCount() -> Int {
        return AvailableDish.shared.availableDishes.count
    }
    
    func getDish(index: Int) -> Dish? {
        if index >= 0 && index < AvailableDish.shared.availableDishes.count {
            return AvailableDish.shared.availableDishes[index]
        } else {
            return nil
        }
    }
}
// Implementamos las funcionalidad del UITableViewDataSource en la clase HomeViewController
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderManager.shared.orders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Orden #\(OrderManager.shared.orders[section].idOrder)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.shared.orders[section].dishesInOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDishCell")!
        
        if OrderManager.shared.orders.count > 0 {
            var config = cell.defaultContentConfiguration()
            config.text = OrderManager.shared.orders[indexPath.section].dishesInOrder[indexPath.row].platillo.nombre
            config.secondaryText = "x \(OrderManager.shared.orders[indexPath.section].dishesInOrder[indexPath.row].veces)"
            
            cell.contentConfiguration = config
        }
        
        return cell
    }
    
}
// Implementamos las funcionalidad del UITableViewDelegate en la clase HomeViewController
extension HomeViewController: UITableViewDelegate {
    
}

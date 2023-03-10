//
//  ViewController.swift
//  4201_TableView
//
//  Created by User on 27/12/22.
//

import UIKit

///
///Un ´UITableView´es un control capaz de mostrar una lista de celdas en secciones
///
///El ´UITableView´por defecto no muestra ninguna sección y tampoco ninguna celda
///
///Para poder mostrar celdas necesitamos configurar una fuente de datos llamada *UITableViewDataSource*
///
///El protocolo ´UITableViewDataSource´ le dirá a la tabla, cuántas secciones deseamos,
///cuántas filas deseamos, cuántas filas por cada sección, el nombre de cada sección
///y la celda que será usada.
///
///Generalmente recuperamos esa celda desde la celda prototipada en el ´UITableView´
///
///Los protocolos se implementan en clases de larga vida como podría ser el
///´ViewController´el cual va a existir mientras el usuario mantenga la aplicación.
///
///Entonces debemos implementar el protocolo ´UITableViewDataSource´sobre el
///´ViewController´para que el ´ViewController´le explique al ´UITableView´como
///serán los datos a mostrar
///
///Esto se hace generalmente mediante extensiones
///

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// **DEBEMOS ENLAZAR LA IMPLEMENTACIÓN DEL ´UITableViewDataSource´**
        /// a nuestro ´myTableView´
        ///
        
        //Significa: Tu dataSource soy yo (la clase ViewController)
        myTableView.dataSource = self
        myTableView.delegate = self
    }
}
///El ´ViewController´implementa la funcionalidad de la tabla
///Este es responsable de explicarle como sera construida y bajo que datos
///Aqui se configura cada celda para cada sección
///
extension ViewController: UITableViewDataSource {
    
    ///Explica cuántas secciones tendrá la tabla. generalmente cada sección proviene de una lista
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    ///Explica cuál es el título para cada sección
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Sección A"
        } else if section == 1 {
            return "Sección B"
        } else {
            return "Sección C"
        }
    }
    
    ///Explica cuántas filas tiene en cada sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        } else {
            return 3
        }
    }
    
    ///Explica cuál es la celda para cada sección y para cada fila (para cada ´indexPath´)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Paso 1. Recuperar la celda que diseñamos sobre la tabla
        ///El ´UITableView´es capaz de regresarnos una celda diseñada bajo su identificador de la celda
        ///**Nota:** La celda no puede ser opcional, usamos ´!´para forzar la no-opcionalidad
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell")!
        
        //Paso 2. Configurar la celda según su clase asociada
        if let cell = cell as? CustomTableViewCell {
            cell.titleLabel.text = "Soy la fila \(indexPath.row)"
            cell.subtitleLabel.text = "En la sección \(indexPath.section)"
            
            if indexPath.section == 1 && indexPath.row == 1 {
                if let url = URL(string: "https://media.kasperskydaily.com/wp-content/uploads/sites/87/2021/04/27103205/Windows_7.jpg") {
                    let session = URLSession.shared.dataTask(with: url) {
                        data, response, error in
                        if let error = error {
                            print("No se pudo descargar la imagen. Error: \(error)")
                            return
                        }
                        
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.mainImageView.image = UIImage(data: data)
                            }
                        }
                    }
                    
                    session.resume()
                }
            }
        }
        
        //Paso 3. Devolvemos la celda ya configurada
        return cell
    }
    
}

///
///El ´ViewController´también puede implementar el delegado de la tabla, para poder
///reaccionar a los eventos que surjan dentro de esta.
///
///Por ejemplo, cuando el usuario seleccione una sección y una fila, nosotros podríamos responder.
///
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Sección: \(indexPath.section)")
        print("Fila: \(indexPath.row)")
    }
}

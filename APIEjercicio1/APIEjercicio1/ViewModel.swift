//
//  ViewModel.swift
//  APIEjercicio1
//
//  Created by User on 03/01/23.
//

import Foundation

final class ViewModel {
    
    func executeAPI() {
        
        let urlSession = URLSession.shared
        
        //let url = URL(string: "https://es.wikipedia.org/wiki/JSON")
        let url = URL(string: "https://itunes.apple.com/search/media-music&identity=song&term-avicii")
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data: \(String(describing: data))")
            print("Response: \(String(describing: response))")
            print("Error: \(String(describing: error))")
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                print(String(describing: json))
            }
        }.resume()
    }
    
}

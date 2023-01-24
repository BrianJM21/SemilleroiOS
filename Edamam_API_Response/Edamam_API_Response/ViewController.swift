//
//  ViewController.swift
//  Edamam_API_Response
//
//  Created by Brian Jiménez Moedano on 24/01/23.
//

import UIKit

//Api Recipe Model
struct RecipeEntity: Decodable {
    
    let label: String
    let image: String
    let calories: Double
    let totalWeight: Double
    
}

struct ApiRecipes: Decodable {
    
    let recipe: RecipeEntity
}

struct ApiRecipeResponse: Decodable {
    
    let hits: [ApiRecipes]
}

//Api Food Model
struct NutrientsEntity: Decodable {
    
    let calories: Double
    let proteins: Double
    let fats: Double
    let carbs: Double
    let fiber: Double
    
    enum CodingKeys: String, CodingKey {
        
        case calories = "ENERC_KCAL"
        case proteins = "PROCNT"
        case fats = "FAT"
        case carbs = "CHOCDF"
        case fiber = "FIBTG"
    }
}

struct FoodEntity: Decodable {
    
    let foodId: String
    let label: String
    let knownAs: String
    let nutrients: NutrientsEntity
    let image: String
}

struct ApiFood: Decodable {
    
    let food: FoodEntity
}

struct ApiFoodResponse: Decodable {
    
    let parsed: [ApiFood]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var apiResponseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    

    func apiRecipeResponse() async -> ApiRecipeResponse {
        
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=coffe&app_id=385cc01c&app_key=48e1da111987e1bd6e3fc7f0c17fedea")!
        
        let (data, _) = try! await URLSession.shared.data(from: url)
        
        return try! JSONDecoder().decode(ApiRecipeResponse.self, from: data)
    }
    
    func apiFoodResponse() async -> ApiFoodResponse {
        
        let url = URL(string: "https://api.edamam.com/api/food-database/v2/parser?app_id=c0a433e7&app_key=a7316b7e37baa4ce5c7b5c0dd62a0298&ingr=milk&nutrition-type=cooking")!
        
        let (data, _) = try! await URLSession.shared.data(from: url)
        
        return try! JSONDecoder().decode(ApiFoodResponse.self, from: data)
    }
    
    @IBAction func apiFoodRequestAction(_ sender: Any) {
        
        Task {
            
            let apiFoodResponse = await self.apiFoodResponse()
            print(apiFoodResponse)
        }
    }
    
    @IBAction func apiRecipeRequestAction(_ sender: Any) {
        
        Task {
            
            let apiRecipeResponse = await self.apiRecipeResponse()
            print(apiRecipeResponse)
        }
    }
    
    

}


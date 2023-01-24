//
//  UserDietEntity.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation


struct UserRecipeEntity: Decodable {
    
    let label: String
    let image: String
    let calories: Double
    let totalWeight: Double
    
}

struct ApiRecipes: Decodable {
    
    let recipe: UserRecipeEntity
}

struct apiResponse: Decodable {
    
    let hits: [ApiRecipes]
}

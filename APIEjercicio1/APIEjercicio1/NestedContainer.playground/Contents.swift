import UIKit

let data = """
    {
        "name_of_user": "Brian",
        "age": 30,
        "address": {
            "city": "Mexico City",
            "zip": "07440",
            "street": "Fray Pedro de Gante"
        }
    }
    """.data(using: .utf8)!

struct User: Decodable {
    
    let name: String
    let age: Int
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name_of_user"
        case age
        case address
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        
        let address = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .address)
        self.city = try address.decode(String.self, forKey: .city)
    }
}

let user = try JSONDecoder().decode(User.self, from: data)
user.city

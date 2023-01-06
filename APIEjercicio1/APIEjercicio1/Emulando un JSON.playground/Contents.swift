import UIKit

struct User: Decodable {
    
    let name: String
    let age: Int
}

let data = """
    {
        "name": "Brian",
        "age": 30
    }
    """.data(using: .utf8)!

let user = try? JSONDecoder().decode(User.self, from: data)
user?.name

let data2 = """
    {
        "identifier": "1234566789",
        "user": {
            "name": "Brian",
            "age": 30
        },
        "job": {
            "name": "iOS Developer",
            "description": "iOS Developer at Grupo Salinas"
        }
    }
    """.data(using: .utf8)!

struct Job: Decodable {
     
    let name: String
    let description: String
}

struct Curriculum: Decodable {
    
    var identifier: String
    var user: User
    var job: Job
}

let curriculum = try? JSONDecoder().decode(Curriculum.self, from: data2)
curriculum?.job.name

let data3 = """
    {
        "name_of_user": "Denise",
        "age": 31
    }
    """.data(using: .utf8)!

struct User2: Decodable{
    
    let name: String
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name_of_user"
        case age
    }
}

let user2 = try? JSONDecoder().decode(User2.self, from: data3)
user2?.name

//En caso de que por alguna razón el JSON no devuelva una "key
//se puede establecer las propiedades del objeto que va a
//"cachar" los datos como de "?" opcional, y así evitamos
//que se crashee el programa

let data4 = """
    {
        "name": "Brian"
    }
    """.data(using: .utf8)!

struct User3: Decodable{
//    Justo aqui
    let name: String
    let age: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case age
    }
}

let user3 = try JSONDecoder().decode(User3.self, from: data4)
user3.age

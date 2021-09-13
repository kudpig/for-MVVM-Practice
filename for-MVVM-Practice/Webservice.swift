//
//  Webservice.swift
//  for-MVVM-Practice
//
//  Created by Shinichiro Kudo on 2021/09/12.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

final class Webservice {
    
    static let shared = Webservice()
    private init() {}
    
    func get(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        guard let resource = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: resource) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let userModels = try? JSONDecoder().decode([User].self, from: data)
            if let userModels = userModels {
                DispatchQueue.main.async {
                    completion(.success(userModels))
                }
            }
            else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    
    }
    
}

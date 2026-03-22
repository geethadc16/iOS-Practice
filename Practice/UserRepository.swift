//
//  UserRepository.swift
//  Practice
//
//  Created by Geetha DC on 19/03/26.
//
import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping ([User]) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(users)
                        }
                        
                    }catch {
                        print("Decoding error:", error)
                    }
                }
                
            }.resume()
        }
    }


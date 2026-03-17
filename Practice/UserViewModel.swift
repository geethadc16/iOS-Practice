//
//  UserViewModel.swift
//  Practice
//
//  Created by Geetha DC on 15/03/26.
//

import Foundation

class UserViewModel {
    
    var users: [User] = []
    
    // Closure to notify ViewController
    var onUsersUpdated: (() -> Void)?
    
    func fetchUsers() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                    
                    self.users = decodedUsers
                    
                    DispatchQueue.main.async {
                        self.onUsersUpdated?()
                    }
                    
                } catch {
                    print("Decoding error:", error)
                }
            }
            
        }.resume()
    }
    
    func updateUser(_ updatedUser: User) {
        
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
        }
        
        onUsersUpdated?()
    }
}

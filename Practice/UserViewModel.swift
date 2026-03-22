//
//  UserViewModel.swift
//  Practice
//
//  Created by Geetha DC on 15/03/26.
//

import Foundation

class UserViewModel {
    //New: Repository added
    private let repository: UserRepositoryProtocol
    
    //Dependency injection
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    // didset for automatic ui updates
    var users: [User] = [] {
        didSet {
            onUsersUpdated?()
        }
    }
    
    // Closure to notify ViewController
    var onUsersUpdated: (() -> Void)?
    
    func fetchUsers() {
        repository.fetchUsers { [weak self] users in
            self?.users = users
        }
    }
    
    
    
    func updateUser(_ updatedUser: User) {
        
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
        }
    }
    
    // new view friendly data
    func userDisplayText(at index: Int) -> String {
        let user = users[index]
        return "ID: \(user.id) | Name: \(user.name) | Email: \(user.email)"
    }
    
    
    func getUser(at index: Int) -> User {
        return users[index]
    }
}

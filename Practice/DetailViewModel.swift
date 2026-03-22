//
//  DetailViewModel.swift
//  Practice
//
//  Created by Geetha DC on 19/03/26.
//

import Foundation

class DetailViewModel {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    func getuser() -> User {
        return user
    }
    
    func updateUser(name: String, email: String) -> User {
        user.name = name
        user.email = email
        return user
    }
}

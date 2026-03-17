//
//  ViewController.swift
//  Practice
//
//  Created by Geetha DC on 01/03/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        // Listen for data updates
        viewModel.onUsersUpdated = {
            self.tableView.reloadData()
        }
        
        // Fetch users from API
        viewModel.fetchUsers()
    }
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let user = viewModel.users[indexPath.row]
        
        cell.textLabel?.text = "ID: \(user.id) | Name: \(user.name) | Email: \(user.email)"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    // MARK: - Row Selection
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedUser = viewModel.users[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.user = selectedUser
        
        detailVC.onSave = { updatedUser in
            
            self.viewModel.updateUser(updatedUser)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

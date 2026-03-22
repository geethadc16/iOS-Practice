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
            
            // ✅ Binding
            viewModel.onUsersUpdated = { [weak self] in
                self?.tableView.reloadData()
            }
            
            viewModel.fetchUsers()
        }
        
        // MARK: - TableView DataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.users.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            // ✅ Using ViewModel instead of direct model
            cell.textLabel?.text = viewModel.userDisplayText(at: indexPath.row)
            cell.textLabel?.numberOfLines = 0
            
            return cell
        }
        
        // MARK: - Row Selection
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let selectedUser = viewModel.getUser(at: indexPath.row)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            // ✅ Passing ViewModel instead of model
            detailVC.viewModel = DetailViewModel(user: selectedUser)
            
            detailVC.onSave = { [weak self] updatedUser in
                self?.viewModel.updateUser(updatedUser)
            }
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

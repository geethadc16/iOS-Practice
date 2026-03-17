//
//  DetailViewController.swift
//  Practice
//
//  Created by Geetha DC on 07/03/26.
//

import UIKit

class DetailViewController: UIViewController {
    var user: User?
    
    var onSave: ((User) -> Void)?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = "ID: \(user?.id ?? 0)"
        nameTextField.text = user?.name
        emailTextField.text = user?.email
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        guard var updatedUser = user else { return }
        
        updatedUser.name = nameTextField.text ?? ""
        updatedUser.email = emailTextField.text ?? ""
        
        onSave?(updatedUser)
        
        showSuccessAlert()
    }
    
    func showSuccessAlert() {
        
        let alert = UIAlertController(
            title: "Success",
            message: "User details saved successfully",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

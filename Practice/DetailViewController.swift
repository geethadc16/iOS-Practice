//
//  DetailViewController.swift
//  Practice
//
//  Created by Geetha DC on 07/03/26.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel!
    
    var onSave: ((User) -> Void)?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = viewModel.getuser()
        
        idLabel.text = "ID: \(user.id)"
        nameTextField.text = user.name
        emailTextField.text = user.email
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let updatedUser = viewModel.updateUser(
                    name: nameTextField.text ?? "",
                    email: emailTextField.text ?? ""
                )
        
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

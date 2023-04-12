//
//  SignUpViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 31/03/23.
//

import UIKit

class SignUpViewController: UIViewController {

  @IBOutlet weak var confirmPasswordTextField: InputTextField!
  @IBOutlet weak var passwordTextField: InputTextField!
  @IBOutlet weak var emailTextField: InputTextField!
  @IBOutlet weak var nameTextField: InputTextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if let index = navigationController?.viewControllers.firstIndex(where: { $0 is
      LoginViewController
    }) {
      navigationController?.viewControllers.remove(at: index)
    }
  }

  func signUp() {
    let name = nameTextField.text ?? ""
    let email = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""

    let user = User(name: name, email: email, password: password)
    ApiService.shared.signUp(user: user) { [weak self](error) in
      if let error = error {
        print(error.localizedDescription)
      } else {
        self?.performSegue(withIdentifier: "showLogin", sender: nil)
      }
    }
  }

  func validateInput() -> Bool {
    let showAlert: (String) -> Void = { (message) in
      let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alert, animated: true)
    }
    guard let name = nameTextField.text, name.count > 2 else {
      showAlert("Name must be 3 or more characters")
      return false
    }

    guard let email = emailTextField.text, email.isEmail else {
      showAlert("Email is not valid")
      return false
    }

    guard let password = passwordTextField.text, password.count >= 4 else {
      return false
    }

    guard confirmPasswordTextField.text == passwordTextField.text else {
      showAlert("Confirm password is not equal with password")
      return false
    }

    return true
  }
  
  @IBAction func signUpButtonTapped(_ sender: Any) {
    if validateInput() {
      signUp()
    }
  }
}

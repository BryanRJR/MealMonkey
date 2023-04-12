//
//  LoginViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 30/03/23.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var passwordTextField: InputTextField!
  @IBOutlet weak var emailTextField: InputTextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if let index = navigationController?.viewControllers.firstIndex(where: { $0 is
      SignUpViewController
    }) {
      navigationController?.viewControllers.remove(at: index)
    }
  }

  func login() {
    let email = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""

    showLoadingView(message: "Login...")
    ApiService.shared.login(email: email, password: password) { [weak self] (result) in
      switch result {
      case .success(let accessToken):
        UserDefaults.standard.saveAccessToken(accessToken)
        
//        self?.showLoadingView(message: "Load profile..")
        self?.getProfile(accessToken: accessToken.accessToken)
      case .failure(let error):
        self?.hideLoadingView()
        print(error.localizedDescription)
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self?.present(alert, animated: true)
      }
    }
  }

  func getProfile(accessToken: String) {
    ApiService.shared.getProfile(accessToken: accessToken) { (result) in
      self.hideLoadingView()
      switch result {
      case .success(let user):
        UserDefaults.standard.saveUser(user)

        print("\(user.id): \(user.name)")
      case .failure(let error):
        print(error.localizedDescription)
      }
      self.goToMain()
    }
  }

  func validateInput() -> Bool {
    func showAlert(_ message: String) -> Void {
    // let showAlert: (String) -> Void = { (message) in <--- same like func showAlert()
      let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alert, animated: true)
    }
    guard let email = emailTextField.text, email.count > 0 else {
      showAlert("Email cannot be empty")
      return false
    }

    guard let password = passwordTextField.text, password.count > 0 else {
      showAlert("Password cannot be empty")
      return false
    }

    return true
  }

  @IBAction func loginButtonTapped(_ sender: Any) {
    if validateInput() {
      login()
    }
  }

}

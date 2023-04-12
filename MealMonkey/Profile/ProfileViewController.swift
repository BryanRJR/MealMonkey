//
//  ProfileViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 06/04/23.
//

import UIKit

class ProfileViewController: UIViewController {
  @IBOutlet weak var profileImageView: UIImageView!
  var profileImage: UIImage? {
    didSet {
      profileImageView.image = profileImage
    }
  }

  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var nameLabel: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()

    let user = UserDefaults.standard.user
    nameLabel.text = "Hi \(user?.name ?? "")"
    nameTextField.text = user?.name
    emailTextField.text = user?.email

    }


  @IBAction func signOutButtonTapped(_ sender: Any) {
    UserDefaults.standard.deleteToken()
    UserDefaults.standard.deleteUser()
    goToAuth()
  }

  @IBAction func addressButtonTapped(_ sender: Any) {
    showAddressViewController { _, address in
      self.addressTextField.text = address
    }
  }

  @IBAction func saveButtomTapped(_ sender: Any) {

  }

  @IBAction func cameraButtomTapped(_ sender: Any) {
    pickImage()
  }

  func pickImage() {
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
      self.showImagePicker(source: .camera)
    }))
    actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
      self.showImagePicker(source: .photoLibrary)
    }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default))
    present(actionSheet, animated: true)
  }

  func showImagePicker(source: UIImagePickerController.SourceType) {
    let viewController = UIImagePickerController()
    viewController.sourceType = source
    viewController.delegate = self

    present(viewController, animated: true)
  }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    profileImage = image
    dismiss(animated: true)
  }
}

//
//  ViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 30/03/23.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
  weak var middleButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    setupMiddleButton()
    delegate = self

    middleButtonTapped(middleButton)

    viewControllers?.forEach({ viewController in
      viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0)
    })
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBar.items?.forEach({ item in
      item.image = item.image?.withRenderingMode(.alwaysOriginal)
      item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
    })
    tabBar.tintColor = UIColor(named: "Main")
  }

  func setupMiddleButton() {
          let middleButton = UIButton(type: .system)
          middleButton.setImage(UIImage(named: "tab_home")?.withRenderingMode(.alwaysOriginal), for: .normal)
          middleButton.setImage(UIImage(named: "tab_home_selected")?.withRenderingMode(.alwaysOriginal), for: .disabled)

          // add to the tabbar and add click event
          tabBar.addSubview(middleButton)
          self.middleButton = middleButton
          tabBar.bringSubviewToFront(middleButton)
          middleButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
              middleButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0)
          ])

          middleButton.addTarget(self, action: #selector(self.middleButtonTapped), for: .touchUpInside)
          view.layoutIfNeeded()
      }

      @objc func middleButtonTapped(_ sender: UIButton) {
          sender.isEnabled = false
          selectedIndex = 2
      }

      func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

          if (viewController as? UINavigationController)?.viewControllers.first is HomeViewController {
              middleButton.isEnabled = false
          } else {
              middleButton.isEnabled = true
          }
          return true
      }

}


//
//  SplashViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 30/03/23.
//

import UIKit

class SplashViewController: UIViewController {
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let isLogedIn = UserDefaults.standard.getAccessToken != nil

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      if isLogedIn {
        self.goToMain()
      } else {
        self.goToAuth()
      }
    }
  }

}

extension UIWindow {
  func setRootViewController(_ viewController: UIViewController) {
    self.rootViewController = viewController

    let _: UIView.AnimationOptions = .transitionCrossDissolve
    let duration: TimeInterval = 0.3
    UIView.transition(with: self, duration: duration, animations: { }, completion: { completed in

    })
  }
}

extension UIApplication {
  var window: UIWindow {
    if #available(iOS 13.0, *) {
      let scenes = UIApplication.shared.connectedScenes
      let windowScene = scenes.first as! UIWindowScene
      return windowScene.windows.first!
    } else {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return appDelegate.window!
    }
  }
}

extension UIViewController {
  func goToMain() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "Main")

    let window: UIWindow = UIApplication.shared.window
    window.setRootViewController(viewController)
  }

  func goToAuth() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "AuthViewController")

    let window: UIWindow = UIApplication.shared.window
    window.setRootViewController(viewController)
  }
}

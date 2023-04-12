//
//  LoadingViewController.swift
//  MealMonkey
//
//  Created by Bayu Yasaputro on 31/03/23.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var activitiIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: String? = nil {
        didSet {
            if isViewLoaded {
                updateMessage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activitiIndicatorView.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activitiIndicatorView.stopAnimating()
    }
    
    private func updateMessage() {
        messageLabel.text = message ?? NSLocalizedString("Please wait..", comment: "")
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

extension UIViewController {
    public func showLoadingView(message: String? = nil) {
        if let viewController = children.compactMap({ $0 as? LoadingViewController }).first {
            viewController.message = message
        } else {
            let viewController = LoadingViewController(nibName: "LoadingViewController", bundle: nil)
            viewController.message = message
            viewController.view.alpha = 0
            viewController.view.isHidden = true
            
            addChild(viewController)
            view.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            viewController.didMove(toParent: self)
            
            view.bringSubviewToFront(viewController.view)
            UIView.animate(withDuration: 0.25) {
                viewController.view.isHidden = false
                viewController.view.alpha = 1
            }
        }
    }
    
    public func hideLoadingView() {
        if let viewController = children.first(where: { $0 is LoadingViewController }) {
            UIView.animate(withDuration: 0.25, animations: {
                viewController.view.alpha = 0
            }) { _ in
                viewController.view.removeFromSuperview()
                viewController.removeFromParent()
                viewController.didMove(toParent: nil)
            }
        }
    }
}

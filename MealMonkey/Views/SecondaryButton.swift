//
//  SecondaryButton.swift
//  MealMonkey
//
//  Created by MacBook Pro on 30/03/23.
//

import UIKit
@IBDesignable
class SecondaryButton: PrimaryButton {

  override func setup() {
    super.setup()

    backgroundColor = .clear
    tintColor = UIColor(named: "Main", in: Bundle(for: self.classForCoder), compatibleWith: nil)
    layer.borderWidth = 1
    layer.borderColor = tintColor.cgColor
  }

}

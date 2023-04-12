//
//  PrimaryButton.swift
//  MealMonkey
//
//  Created by MacBook Pro on 30/03/23.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat = 28 {
    didSet { update() }
  }

  @IBInspectable var color: UIColor? {
    didSet { update() }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
  }

  convenience init() {
    self.init(type: .system)
    setup()
  }

  func setup() {
    // backgroundColor = UIColor(named: "Main", in: Bundle(for: PrimaryButton.Self) <= or u can do like this hehe..
    backgroundColor = color ?? UIColor(named: "Main", in: Bundle(for: self.classForCoder), compatibleWith: nil)
    titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    tintColor = .white

    update()
  }

  func update() {
    layer.cornerRadius = self.cornerRadius
    layer.masksToBounds = true
  }
}

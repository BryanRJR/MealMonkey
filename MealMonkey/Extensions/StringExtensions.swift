//
//  StringExtensions.swift
//  MealMonkey
//
//  Created by MacBook Pro on 03/04/23.
//

import Foundation

extension String {
  var isEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return predicate.evaluate(with: self)
  }
}

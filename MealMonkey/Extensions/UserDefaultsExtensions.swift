//
//  UserDefaultsExtensions.swift
//  MealMonkey
//
//  Created by MacBook Pro on 03/04/23.
//

import Foundation

extension UserDefaults {
  func saveAccessToken(_ accessToken: AccessToken) {
    let data = try? JSONEncoder().encode(accessToken)
    set(data, forKey: "kAccessTokenKey")

  }

  var getAccessToken: AccessToken? {
    if let data = self.object(forKey: "kAccessTokenKey") as? Data {
      let accessToken = try? JSONDecoder().decode(AccessToken.self, from: data)
      return accessToken
    } else {
      return nil
    }
  }

  func deleteToken() {
    set(nil, forKey: "kAccessTokenKey")
  }

  func deleteUser() {
    set(nil, forKey: "kUserKey")
  }

  func saveUser(_ user: User) {
    let data = try? JSONEncoder().encode(user)
    set(data, forKey: "kUserKey")
  }

  var user: User? {
    if let data = self.object(forKey: "kUserKey") as? Data {
      let user = try? JSONDecoder().decode(User.self, from: data)
      return user
    } else {
      return nil
    }
  }
}

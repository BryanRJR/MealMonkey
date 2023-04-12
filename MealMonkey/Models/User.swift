//
//  User.swift
//  MealMonkey
//
//  Created by MacBook Pro on 31/03/23.
//

import Foundation

struct User: Codable {
  let name: String
  let email: String
  let password: String
  let avatar: String
  let role: String
  let id: Int

  enum CodingKeys: String, CodingKey {
    case name
    case email
    case password
    case avatar
    case role
    case id
  }

  // Object to Data
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.name, forKey: .name)
    try container.encode(self.email, forKey: .email)
    try container.encode(self.password, forKey: .password)
    try container.encode(self.avatar, forKey: .avatar)
    try container.encode(self.role, forKey: .role)
    try container.encode(self.id, forKey: .id)

  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.email = try container.decode(String.self, forKey: .email)
    self.password = try container.decode(String.self, forKey: .password)
    self.avatar = try container.decode(String.self, forKey: .avatar)
    self.role = try container.decode(String.self, forKey: .role)
    self.id = try container.decode(Int.self, forKey: .id)
  }

  init(name: String, email: String, password: String) {
    self.name = name
    self.email = email
    self.password = password

    self.id = 0
    self.role = "customer"
    self.avatar = "https://ui-avatars.com/api/?name=nanda&color=FFFFFF&background=FF8045&size=640&bold=true"
  }
}

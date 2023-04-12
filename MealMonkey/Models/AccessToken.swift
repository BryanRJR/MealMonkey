//
//  AccessToken.swift
//  MealMonkey
//
//  Created by MacBook Pro on 31/03/23.
//

import Foundation

struct AccessToken: Codable {
  let accessToken: String
  let refreshToken: String

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
  }

  // Data to Object
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
    refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken) ?? ""
  }

  // Object to Data
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(accessToken, forKey: .accessToken)
    try container.encode(refreshToken, forKey: .refreshToken)
  }
  
}

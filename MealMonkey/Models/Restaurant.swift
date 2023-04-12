//
//  Restaurant.swift
//  MealMonkey
//
//  Created by MacBook Pro on 10/04/23.
//

import Foundation

struct Restaurant: Decodable {
  let id: Int
  let name: String
  let categoryName: String
  let categoryId: Int
  let imageUrl: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case restaurantCategory = "restaurant_category_id"
    case image
  }

  enum RestaurantCategory: String, CodingKey {
    case id
    case name
  }

  enum Image: String, CodingKey {
    case url

  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""

    let restaurantCategory = try container.nestedContainer(keyedBy: RestaurantCategory.self, forKey: .restaurantCategory)
    categoryId = try restaurantCategory.decodeIfPresent(Int.self, forKey: .id) ?? 0
    categoryName = try restaurantCategory.decodeIfPresent(String.self, forKey: .name) ?? ""

    let image = try container.nestedContainer(keyedBy: Image.self, forKey: .image)
    imageUrl = try image.decodeIfPresent(String.self, forKey: .url) ?? ""
  }
}

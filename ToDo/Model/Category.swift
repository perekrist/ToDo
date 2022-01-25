//
//  Category.swift
//  ToDo
//

import Foundation

struct Category: Identifiable, Codable {
  let name: String
  let id: Int
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    id = try container.decode(Int.self, forKey: .id)
  }
}

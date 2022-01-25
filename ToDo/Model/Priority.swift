//
//  Priority.swift
//  ToDo
//

import Foundation

struct Priority: Identifiable, Codable {
  let name: String
  let id: Int
  let color: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    color = try container.decode(String.self, forKey: .color)
    id = try container.decode(Int.self, forKey: .id)
  }
}

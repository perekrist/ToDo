//
//  AuthResponse.swift
//  ToDo
//

import Foundation

struct AuthResponse: Codable {
  let name: String?
  let email: String?
  let id: Int?
  let api_token: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? nil
    email = try container.decodeIfPresent(String.self, forKey: .email) ?? nil
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? nil
    api_token = try container.decode(String.self, forKey: .api_token)
  }
}

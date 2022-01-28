//
//  TokenResponse.swift
//  ToDo
//

import Foundation

struct TokenResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case token = "apiToken", message
  }
  
  let token: String
  let message: String?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message) ?? nil
    token = try container.decode(String.self, forKey: .token)
  }
}

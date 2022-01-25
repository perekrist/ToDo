//
//  TaskModel.swift
//  ToDo
//

import Foundation

struct TaskModel: Identifiable, Codable {
  let deadline: Int
  let id: Int
  let created: Int
  let title: String
  let category: Category?
  let priority: Priority
  let done: Int
  let description: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    deadline = try container.decode(Int.self, forKey: .deadline)
    created = try container.decode(Int.self, forKey: .created)
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    category = try container.decodeIfPresent(Category.self, forKey: .category)
    priority = try container.decode(Priority.self, forKey: .priority)
    done = try container.decode(Int.self, forKey: .done)
    description = try container.decode(String.self, forKey: .description)
  }
}

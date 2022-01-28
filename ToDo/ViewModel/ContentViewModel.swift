//
//  ContentViewModel.swift
//  ToDo
//

import UIKit

@MainActor
class ContentViewModel: ObservableObject {
  @Published private(set) var tasks = [TaskModel]()
  @Published private(set) var priorities = [Priority]()
  @Published private(set) var categories = [Category]()
  
  private let networkService = NetworkService()
  
  func load() async {
    do {
      try await networkService.login()
      self.priorities = try await networkService.getPriorities()
      self.categories = try await networkService.getCategories()
      self.tasks = try await networkService.getTasks()
    } catch (let error) {
      print(error)
    }
  }
}

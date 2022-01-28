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
  
  private let defaults = UserDefaults.standard
  private let baseURL = "http://practice.mobile.kreosoft.ru/api"
  
  func load() async {
    await login()
    do {
      self.priorities = try await getPriorities()
      self.categories = try await getCategories()
      self.tasks = try await getTasks()
    } catch (let error) {
      print(error.localizedDescription)
    }
  }
}


// TODO: Extract to network service
extension ContentViewModel {
  private func login(email: String = "tester@gmail.com", password: String = "qwerty1111") async {
    guard let url = URL(string: "\(baseURL)/login?email=\(email)&password=\(password)") else { return }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let response = try JSONDecoder().decode(AuthResponse.self, from: data)
      defaults.set(response.api_token, forKey: "api_token")
    } catch (let error) {
      print("error: ", error.localizedDescription)
    }
  }
  
  private func getPriorities() async throws -> [Priority] {
    guard let token = defaults.value(forKey: "api_token") as? String,
          let url = URL(string: "\(baseURL)/priorities?api_token=\(token)") else { throw CustomError.invalidURL }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      return try JSONDecoder().decode([Priority].self, from: data)
    } catch (let error) {
      throw error
    }
  }
  
  private func getCategories() async throws -> [Category] {
    guard let token = defaults.value(forKey: "api_token") as? String,
          let url = URL(string: "\(baseURL)/categories?api_token=\(token)") else { throw CustomError.invalidURL }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      return try JSONDecoder().decode([Category].self, from: data)
    } catch (let error) {
      throw error
    }
  }
  
  private func getTasks() async throws -> [TaskModel] {
    guard let token = defaults.value(forKey: "api_token") as? String,
          let url = URL(string: "\(baseURL)/tasks?api_token=\(token)") else { throw CustomError.invalidURL }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      return try JSONDecoder().decode([TaskModel].self, from: data)
    } catch (let error) {
      throw error
    }
  }
}

enum CustomError: Error {
  case invalidURL
}

//
//  ContentViewModel.swift
//  ToDo
//

import UIKit

class ContentViewModel: ObservableObject {
  @Published var tasks = [TaskModel]()
  @Published var priorities = [Priority]()
  @Published var categories = [Category]()
  
  private let defaults = UserDefaults.standard
  private let baseURL = "http://practice.mobile.kreosoft.ru/api"
  
  func load() async {
    await getPriorities()
    await getCategories()
    await getTasks()
  }
  
  func login(email: String = "tester@gmail.com", password: String = "qwerty1111") async {
    guard let url = URL(string: "\(baseURL)/login?email=\(email)&password=\(password)") else { return }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let response = try JSONDecoder().decode(AuthResponse.self, from: data)
      defaults.set(response.api_token, forKey: "api_token")
    } catch (let error) {
      print("error: ", error.localizedDescription)
    }
  }
  
  private func getPriorities() async {
    guard let token = defaults.value(forKey: "api_token") as? String,
          let url = URL(string: "\(baseURL)/priorities?api_token=\(token)") else { return }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      priorities = try JSONDecoder().decode([Priority].self, from: data)
    } catch (let error) {
      print("error: ", error.localizedDescription)
    }
  }
  
  private func getCategories() async {
    guard let token = defaults.value(forKey: "api_token") as? String,
          let url = URL(string: "\(baseURL)/categories?api_token=\(token)") else { return }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      categories = try JSONDecoder().decode([Category].self, from: data)
    } catch (let error) {
      print("error: ", error.localizedDescription)
    }
  }
  
  private func getTasks() async {
    guard let token = defaults.value(forKey: "api_token") as? String,
          let url = URL(string: "\(baseURL)/tasks?api_token=\(token)") else { return }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      tasks = try JSONDecoder().decode([TaskModel].self, from: data)
    } catch (let error) {
      print("error: ", error.localizedDescription)
    }
  }
}

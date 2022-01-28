//
//  NetworkService.swift
//  ToDo
//

import Foundation

enum CustomError: Error {
  case invalidURL, noToken
}

class NetworkService {
  private let defaults = UserDefaults.standard
  private let baseURL = "http://practice.mobile.kreosoft.ru/api"
  
  func login(email: String = "tester@gmail.com", password: String = "qwerty1111") async throws {
    do {
      let response: TokenResponse = try await baseRequest(urlPath: "/login?email=\(email)&password=\(password)",
                                                          method: "POST")
      defaults.set(response.token, forKey: "api_token")
    } catch (let error) {
      throw error
    }
  }
  
  func getPriorities() async throws -> [Priority] {
    guard let token = defaults.value(forKey: "api_token") as? String else { throw CustomError.noToken }
    return try await baseRequest(urlPath: "/priorities?api_token=\(token)")
  }
  
  func getCategories() async throws -> [Category] {
    guard let token = defaults.value(forKey: "api_token") as? String else { throw CustomError.noToken }
    return try await baseRequest(urlPath: "/categories?api_token=\(token)")
  }
  
  func getTasks() async throws -> [TaskModel] {
    guard let token = defaults.value(forKey: "api_token") as? String else { throw CustomError.noToken }
    return try await baseRequest(urlPath: "/tasks?api_token=\(token)")
  }
}

extension NetworkService {
  private func baseRequest<T: Codable>(urlPath: String, method: String = "GET") async throws -> T {
    guard let url = URL(string: baseURL + urlPath) else { throw CustomError.invalidURL }
    var request = URLRequest(url: url)
    request.httpMethod = method
    do {
      let (data, _) = try await URLSession.shared.data(for: request)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return try decoder.decode(T.self, from: data)
    } catch (let error) {
      print(url.absoluteString)
      throw error
    }
  }
}

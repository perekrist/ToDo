//
//  Observer.swift
//  ToDo
//
//  Created by Перегудова Кристина on 25.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Observer: ObservableObject {
    let defaults = UserDefaults.standard
    let baseURL = "http://practice.mobile.kreosoft.ru/api"
    
    @Published var tasks = [Task]()
    @Published var priorities = [Priority]()
    @Published var categories = [Category]()
        
    func login(email: String, password: String) {
        AF.request("\(baseURL)/login", method: .post, parameters: ["email": email, "password": password]).responseJSON { response in
            let json = try! JSON(data: response.data!)
            let api_token = json["api_token"].stringValue
            self.defaults.set(api_token, forKey: "api_token")
        }
    }
    
    func getPriorities() {
        AF.request("\(baseURL)/priorities", method: .get, parameters: ["api_token": self.defaults.string(forKey: "api_token")]).responseJSON { response in
            let json = try! JSON(data: response.data!)
            for i in json {
                self.priorities.append(Priority(name: i.1["name"].stringValue, id: i.1["id"].intValue, color: i.1["color"].stringValue))
            }
            print(self.priorities)
        }
    }
    
    func getCategories() {
        AF.request("\(baseURL)/categories", method: .get, parameters: ["api_token": self.defaults.string(forKey: "api_token")]).responseJSON { response in
            let json = try! JSON(data: response.data!)
            for i in json {
                self.categories.append(Category(name: i.1["name"].stringValue, id: i.1["id"].intValue))
            }
            print(self.categories)
        }
    }
    
    func getTasks() {
        AF.request("\(baseURL)/tasks", method: .get, parameters: ["api_token": self.defaults.string(forKey: "api_token")]).responseJSON { response in
            let json = try! JSON(data: response.data!)
            for i in json {
                self.tasks.append(Task(deadline: i.1["deadline"].intValue, id: i.1["id"].intValue, created: i.1["created"].intValue, title: i.1["title"].stringValue, category: Category(name: i.1["category"]["name"].stringValue, id: i.1["category"]["id"].intValue), priority: Priority(name: i.1["priority"]["name"].stringValue, id: i.1["category"]["name"].intValue, color: i.1["category"]["color"].stringValue), done: i.1["done"].intValue, description: i.1["description"].stringValue))
            }
            print(self.tasks)
        }
    }
}

//
//  Structs.swift
//  ToDo
//
//  Created by Перегудова Кристина on 25.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import Foundation

struct Priority: Identifiable {
    var name: String
    var id: Int
    var color: String
}

struct Category: Identifiable {
    var name: String
    var id: Int
}

struct Task: Identifiable {
    var deadline: Int
    var id: Int
    var created: Int
    var title: String
    var category: Category
    var priority: Priority
    var done: Int
    var description: String
}

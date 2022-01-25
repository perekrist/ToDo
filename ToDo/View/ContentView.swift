//
//  ContentView.swift
//  ToDo
//

import SwiftUI

struct ContentView: View {
  @ObservedObject private var viewModel = ContentViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.tasks) { task in
          Section(header: Text(task.category?.name ?? "-")) {
            TaskView(task: task)
          }
        }
      }
      .navigationBarTitle("Not Forgot!")
      .task {
        await viewModel.load()
      }
    }
  }
}

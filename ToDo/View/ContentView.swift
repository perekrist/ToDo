//
//  ContentView.swift
//  ToDo
//
//  Created by Перегудова Кристина on 25.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var obs = Observer()
    @State var email: String = ""
    @State var password: String = ""
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(obs.tasks) {i in
                        Section(header: Text(i.category.name)) {
                            TaskView(task: i)
                        }
                    }
                }
            }
            .navigationBarTitle("Not Forgot!")
            .onAppear {
                self.obs.getTasks()
                self.obs.getCategories()
                self.obs.getPriorities()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

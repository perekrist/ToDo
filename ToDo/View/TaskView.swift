//
//  TaskView.swift
//  ToDo
//
//  Created by Перегудова Кристина on 16.03.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    var task: Task
    @State var isChecked: Bool = false
    @State var isSheet: Bool = false

    
    var body: some View {
        HStack {
            HStack {
                Rectangle()
                    .frame(width: 8, height: 64)
                    .foregroundColor(.red)
                VStack {
                    Text(task.title)
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(.black)
                    
                    Text(task.description)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
                Spacer()
            }.background(Color.white)
            .onTapGesture {
                self.isSheet.toggle()
            }
            Button(action: {
                self.isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 18, height: 18)
            }.padding()
        }.background(Color.white)
        .sheet(isPresented: self.$isSheet) {
            Text(self.task.category.name)
        }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(task: .constant(Task(deadline: 0, id: 0, created: 0, title: "task", category: Category(name: "cat_name", id: 0), priority: Priority(name: "prior", id: 0, color: ""), done: 0, description: "desc")))
//
//    }
//}

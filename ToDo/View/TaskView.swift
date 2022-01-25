//
//  TaskView.swift
//  ToDo
//

import SwiftUI

struct TaskView: View {
  var task: TaskModel
  @State private var isChecked: Bool = false
  @State private var isSheet: Bool = false
  
  
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
          isSheet.toggle()
        }
      
      Button(action: {
        isChecked.toggle()
      }) {
        Image(systemName: isChecked ? "checkmark.square" : "square")
          .renderingMode(.original)
          .resizable()
          .frame(width: 18, height: 18)
      }.padding()
      
    }.background(Color.white)
      .sheet(isPresented: self.$isSheet) {
        Text(task.category?.name ?? "-")
      }
  }
}

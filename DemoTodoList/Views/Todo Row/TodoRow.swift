//
//  TodoRow.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import SwiftUI

struct TodoRow: View {
  // MARK: - Properties
  var todo: Todo
  
  
  // MARK: - Body
  var body: some View {
    HStack {
      Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundColor(todo.isCompleted ? .blue : .black)
      Text(todo.title)
      Spacer()
    }
  }
}

// MARK: - Preview
struct TodoRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TodoRow(todo: Todo(title: "Buy groceries"))
      TodoRow(todo: Todo(title: "Buy groceries", isCompleted: true))
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}

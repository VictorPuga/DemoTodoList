//
//  TodoListView.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import SwiftUI

struct TodoListView: View {
  // MARK: - Properties
  @ObservedObject var viewModel = TodoListViewModel()
  
  @State private var isShowingAddNew = false
  
  var addNewButton: some View {
    Button(action: {
      isShowingAddNew.toggle()
    }) {
      Image(systemName: "plus")
    }
  }
  
  var showCompletedButton: some View {
    Button(action: {
      viewModel.showCompleted.toggle()
    }) {
      Image(systemName: viewModel.showCompleted ? "checkmark.circle.fill" : "checkmark.circle")
    }
  }
  
  // MARK: - Body
  var body: some View {
    NavigationView {
      List(viewModel.todos) { todo in
        Button(action: {
          viewModel.toggleIsCompleted(for: todo)
        }) {
          TodoRow(todo: todo)
        }
      }
      .navigationTitle(Text("Todo List"))
      .navigationBarItems(leading: showCompletedButton,trailing: addNewButton)
    }
    .sheet(
      isPresented: $isShowingAddNew,
      onDismiss: {
        viewModel.fetchTodos()
      }) {
      NewTodoView(viewModel: NewTodoViewModel())
    }
    .onAppear {
      viewModel.fetchTodos()
    }
  }
}

// MARK: - Preview
struct TodoListView_Previews: PreviewProvider {
  static var viewModel = TodoListViewModel(dataManager: MockDataManager())
  static var previews: some View {
    TodoListView(viewModel: viewModel)
  }
}

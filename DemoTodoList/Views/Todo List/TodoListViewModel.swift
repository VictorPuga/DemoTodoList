//
//  TodoListViewModel.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import Foundation
import Combine

protocol TodoListViewModelProtocol {
  var todos: [Todo] { get }
  var showCompleted: Bool { get set }
  func fetchTodos()
  func toggleIsCompleted(for todo: Todo)
}

final class TodoListViewModel: ObservableObject {
  @Published var todos = [Todo]()
  @Published var showCompleted = false {
    didSet {
      fetchTodos()
    }
  }
  
  var dataManager: DataManagerProtocol
  
  init(dataManager: DataManagerProtocol = DataManager.shared) {
    self.dataManager = dataManager
    fetchTodos()
  }
}

// MARK: - TodoListViewModelProtocol
extension TodoListViewModel: TodoListViewModelProtocol {
  func fetchTodos() {
    todos = dataManager.fetchTodoList(includingCompleted: showCompleted)
  }
  
  func toggleIsCompleted(for todo: Todo) {
    dataManager.toggleIsCompleted(for: todo)
    fetchTodos()
  }
}

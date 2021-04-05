//
//  NewTodoViewModel.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import Foundation
import Combine

protocol NewTodoViewModelProtocol {
  func addNewTodo(title: String)
}

final class NewTodoViewModel: ObservableObject {
  var dataManager: DataManagerProtocol
  
  init(dataManager: DataManagerProtocol = DataManager.shared) {
    self.dataManager = dataManager
  }
}

// MARK: - NewTodoViewModelProtocol
extension NewTodoViewModel: NewTodoViewModelProtocol {
  func addNewTodo(title: String) {
    dataManager.addTodo(title: title)
  }
}

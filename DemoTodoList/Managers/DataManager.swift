//
//  DataManager.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import Foundation
import DBHelper
import CoreData

protocol DataManagerProtocol {
  func fetchTodoList(includingCompleted: Bool) -> [Todo]
  func addTodo(title: String)
  func toggleIsCompleted(for todo: Todo)
}

extension DataManagerProtocol {
  func fetchTodoList(includingCompleted: Bool = false) -> [Todo] {
    fetchTodoList(includingCompleted: includingCompleted)
  }
}

class DataManager {
  static let shared: DataManagerProtocol = DataManager()
  
  var dbHelper: CoreDataHelper = .shared
  
  // private var todos = [Todo]()
  
  private init() {
    
  }
  
  private func getTofoMO(for todo: Todo) -> TodoMO? {
    let predicate = NSPredicate(format: "uuid = %@", todo.id as CVarArg)
    let result = dbHelper.fetchFirst(TodoMO.self, predicate: predicate)
    switch result {
      case .success(let todoMO):
        return todoMO
      case .failure(_):
        return nil
    }
  }
}

// MARK: - DataMAnagerProtocol
extension DataManager: DataManagerProtocol {
  func fetchTodoList(includingCompleted: Bool) -> [Todo] {
    let predicate = includingCompleted ? nil : NSPredicate(format: "isCompleted = false")
    let result: Result<[TodoMO], Error> = dbHelper.fetch(TodoMO.self, predicate: predicate, limit: nil)
    switch result {
      case .success(let todosMOs):
        return todosMOs.map { $0.convertToTodo() }
      case .failure(let error):
        fatalError(error.localizedDescription)
    }
  }
  func addTodo(title: String) {
    let entity = TodoMO.entity()
    let newTodo = TodoMO(entity: entity, insertInto: dbHelper.context)
    newTodo.uuid = UUID()
    newTodo.title = title
    dbHelper.create(newTodo)
  }
  
  func toggleIsCompleted(for todo: Todo) {
    guard let todoMO = getTofoMO(for: todo) else { return }
    todoMO.isCompleted.toggle()
    dbHelper.update(todoMO)
  }
}

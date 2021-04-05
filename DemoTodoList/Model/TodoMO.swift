//
//  TodoMO.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 05/04/21.
//

import CoreData

@objc(TodoMO)
final class TodoMO: NSManagedObject {
  @NSManaged var uuid: UUID?
  @NSManaged var title: String
  @NSManaged var isCompleted: Bool
}

extension TodoMO {
  func convertToTodo() -> Todo {
    Todo(
      id: uuid ?? UUID(),
      title: title,
      isCompleted: isCompleted
    )
  }
}

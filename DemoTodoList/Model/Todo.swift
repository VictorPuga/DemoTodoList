//
//  Todo.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import Foundation

struct Todo: Identifiable {
  var id = UUID()
  var title: String
  var isCompleted = false
}

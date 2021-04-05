//
//  DemoTodoListApp.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import SwiftUI

@main
struct DemoTodoListApp: App {
  
  var body: some Scene {
    WindowGroup {
      TodoListView()
        .environment(\.managedObjectContext, CoreDataHelper.shared.persistentContainer.viewContext)
        .onReceive(
          NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
        ) { _ in
          CoreDataHelper.shared.saveContext()
        }
    }
  }
}

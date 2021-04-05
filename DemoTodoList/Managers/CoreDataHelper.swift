//
//  CoreDataHelper.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import Foundation
import CoreData
import DBHelper

class CoreDataHelper: DBHelperProtocol {
  typealias ObjectType = NSManagedObject
  typealias PredicateType = NSPredicate
  
  var context: NSManagedObjectContext { persistentContainer.viewContext }
  
  func create(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      fatalError("error saving context while creating an object")
    }
  }
  
  // MARK: -  DBHelper Protocol
  
  func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error> {
    let name = String(describing: objectType)
    let request = NSFetchRequest<T>(entityName: name)
    request.predicate = predicate
    
    if let limit = limit {
      request.fetchLimit = limit
    }
    do {
      let result = try context.fetch(request)
      return .success(result)
    } catch {
      return .failure(error)
    }
  }
  
  func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
    let result = fetch(objectType, predicate: predicate, limit: 1)
    switch result {
      case .success(let todos):
        return .success(todos.first)
      case .failure(let error):
        return .failure(error)
    }
  }
  
  func update(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      fatalError("error saving context while updating an object")
    }
  }
  
  func delete(_ object: NSManagedObject) {
    
  }
  
  // MARK: - Core Data
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "DemoTodoList")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      print(storeDescription)
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

extension CoreDataHelper {
  static let shared = CoreDataHelper()
}

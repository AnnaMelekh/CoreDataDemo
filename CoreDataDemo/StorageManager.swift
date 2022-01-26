//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Anna Melekhina on 26.01.2022.
//

import Foundation
import CoreData

private var taskList: [Task] = []

var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "CoreDataDemo")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

let context = persistentContainer.viewContext

func saveContext () {
    
    if context.hasChanges {
        do {
            try context.save()
        } catch {
           
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    
    func save(_ taskName: String){
        
            
    let task = Task(context: context)
        task.name = taskName
        taskList.append(task)
        
        guard let taskListVC = UIViewController as? TaskListViewController else {return}
                
        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        taskListVC.tableView.insertRows(at: [cellIndex], with: .automatic)
        
        do {
            try context.save()
        } catch {
            
            print(error)
        }
    }

}

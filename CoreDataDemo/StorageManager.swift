//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Anna Melekhina on 26.01.2022.
//

import Foundation
import CoreData


var taskList: [Task] = []

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

func saveContext() {
    
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
        
        let taskListVC = TaskListViewController()
        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        taskListVC.tableView.insertRows(at: [cellIndex], with: .automatic)

//        saveContext()
        do {
            try context.save()
        } catch {

            print(error)
        }
    }
    
    func deleteTask(at indexPath: IndexPath) {
            let task = taskList.remove(at: indexPath.row)
            context.delete(task)
            
        }

}

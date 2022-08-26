//
//  ServiceCoreData.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation
import CoreData

class ServiceCoreData {
    
    var users: [Person] = []
    
    static let shared = ServiceCoreData()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "hw26")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var managedContext = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
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
    
    func save(_ nameUser: String) {
        // Entity name
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: managedContext) else { return }
        // Model
        let user = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! Person
        user.name = nameUser
        
        do {
            try managedContext.save()
            users.append(user)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateUser(_ user: Person, gender: String?, date: Date) {
        if let gender = gender {
            user.gender = gender
            user.data = date
        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
        
    func fetchData() {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            users = try managedContext.fetch(fetchRequest)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func delete(at indexPath: Int) {
        users.remove(at: indexPath)
    }
    
    func deleteUser(_ user: Person, indexPath: IndexPath) {
        managedContext.delete(user)
        
        do {
            try managedContext.save()
            users.remove(at: indexPath.row)
        } catch let error {
            print("Error delete data base: \(error)")
        }
    }
}

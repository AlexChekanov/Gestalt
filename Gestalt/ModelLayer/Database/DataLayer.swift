import Foundation
import CoreData

typealias TasksBlock = ([Task])->Void

protocol DataLayer {
    func loadFromDB(finished: TasksBlock)
    func save(dtos: [TaskDTO], translationLayer: TranslationLayer, finished: @escaping () -> Void)
}

class DataLayerImpl: DataLayer {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save(dtos: [TaskDTO], translationLayer: TranslationLayer, finished: @escaping () -> Void) {
        clearOldResults()
        _ = translationLayer.toUnsavedCoreData(from: dtos, with: mainContext)
        
        try! mainContext.save()
        
        finished()
    }
    
    func loadFromDB(finished: TasksBlock) {
        print("loading data locally")
        let tasks = loadTasksFromDB()
        finished(tasks)
    }
}

extension DataLayerImpl {
    
    fileprivate func loadTasksFromDB() -> [Task] {
        let sortOn = NSSortDescriptor(key: "brief", ascending: true)
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [sortOn]
        
        let tasks = try! persistentContainer.viewContext.fetch(fetchRequest)
        
        return tasks
    }
    
    //MARK: - Helper Methods
    fileprivate func clearOldResults() {
        print("clearing old results")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Task.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try! persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: persistentContainer.viewContext)
        persistentContainer.viewContext.reset()
    }
}

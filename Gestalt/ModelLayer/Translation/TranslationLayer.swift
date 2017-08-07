import Foundation
//import Outlaw
import CoreData

protocol TranslationLayer {
    func createTaskDTOsFromJsonData(_ data: Data) -> [TaskDTO]
    func toUnsavedCoreData(from dtos: [TaskDTO], with context: NSManagedObjectContext) -> [Task]
    func toTaskDTOs(from tasks:[Task]) -> [TaskDTO]
}

class TranslationLayerImpl: TranslationLayer {
    
    fileprivate var taskTranslator: TaskTranslator

    init(taskTranslator: TaskTranslator) {
        self.taskTranslator = taskTranslator
    }

    func createTaskDTOsFromJsonData(_ data: Data) -> [TaskDTO] {
        print("converting json to DTOs")
        
        let tasks: [TaskDTO] = []
        
//        let json:[String: Any] = try! JSON.value(from: data)
//        let tasks: [TaskDTO] = try! json.value(for: "tasks")
        return tasks
    }
    
    func toUnsavedCoreData(from dtos: [TaskDTO], with context: NSManagedObjectContext) -> [Task] {
        print("convering DTOs to Core Data Objects")
        let tasks = dtos.flatMap { dto in taskTranslator.translate(from: dto, with: context) } // keeping it simple by keeping things single threaded
        
        return tasks
    }

    func toTaskDTOs(from tasks:[Task]) -> [TaskDTO] {
        let dtos = tasks.flatMap { taskTranslator.translate(from: $0) }
        
        return dtos
    }
}

import Foundation
import CoreData

protocol TaskTranslator {
    func translate(from task: Task?) -> TaskDTO?
    func translate(from dto: TaskDTO?, with context: NSManagedObjectContext) -> Task?
}

class TaskTranslatorImpl: TaskTranslator {
    
    func translate(from task: Task?) -> TaskDTO? {
        guard let task = task else { return nil }
        
        return TaskDTO(brief: task.brief!,
                        full: task.full!,
                       order: task.order,
                         due: task.due! as Date,
                   suspended: task.suspended)
    }
    
    func translate(from dto: TaskDTO?, with context: NSManagedObjectContext) -> Task? {
        guard let dto = dto else { return nil }
        
        let task = Task(context: context)
        task.brief = dto.brief
        task.full = dto.full
        task.order = dto.order!
        task.due = dto.due! as NSDate
        task.suspended = dto.suspended!
        
        return task
    }
}

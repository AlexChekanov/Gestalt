import Foundation

protocol ActionTableViewCellPresenter {
    var task: TaskDTO! { get }
    
    var full: String { get }
}

class ActionTableViewCellPresenterImpl: ActionTableViewCellPresenter {
    
    var task: TaskDTO!
    
    var full: String { return task.full! }
    
    init(with task: TaskDTO) {
        self.task = task
    }
}

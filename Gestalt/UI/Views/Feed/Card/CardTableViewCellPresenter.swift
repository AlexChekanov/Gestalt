import Foundation

protocol CardTableViewCellPresenter {
    var brief: String { get }
    var full: String { get }
    var due: Date { get }
}

class CardTableViewCellPresenterImpl: CardTableViewCellPresenter {
    
    var task: TaskDTO
    
    var brief: String { return task.brief! }
    var full: String { return task.full! }
    var due: Date { return task.due! }
    
    init(with task: TaskDTO) {
        self.task = task
    }
}

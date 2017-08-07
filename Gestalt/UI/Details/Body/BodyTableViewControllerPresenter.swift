import Foundation

protocol BodyTableViewControllerPresenter {
    var task: TaskDTO! { get }
    
    var title: String { get }
}

class BodyTableViewControllerPresenterImpl: BodyTableViewControllerPresenter {
    
    var task: TaskDTO!
    
    var title: String { return task.brief! }
    
    init(with task: TaskDTO) {
        self.task = task
    }
}

import Foundation

protocol ProcessCollectionViewControllerPresenter {
    var task: TaskDTO! { get }
    
    var title: String { get }
}

class ProcessCollectionViewControllerPresenterImpl: ProcessCollectionViewControllerPresenter {
    
    var task: TaskDTO!
    
    var title: String { return task.brief! }
    
    init(with task: TaskDTO) {
        self.task = task
    }
}

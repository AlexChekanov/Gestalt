import Foundation

protocol DetailViewControllerPresenter {
    var task: TaskDTO! { get }
    
    var title: String { get }
}

class DetailViewControllerPresenterImpl: DetailViewControllerPresenter {
    
    var task: TaskDTO!
    
    var title: String { return task.brief! }

    init(with task: TaskDTO) {
        self.task = task
    }
}

import Foundation

protocol StepCollectionViewCellPresenter {
    var task: TaskDTO! { get }
    
    var brief: String { get }
}

class StepCollectionViewCellPresenterImpl: StepCollectionViewCellPresenter {
    
    var task: TaskDTO!
    
    var brief: String { return task.brief! }
    
    init(with task: TaskDTO) {
        self.task = task
    }
}

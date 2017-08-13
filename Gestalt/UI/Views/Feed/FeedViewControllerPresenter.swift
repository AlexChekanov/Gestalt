import Foundation
import RxSwift
import RxDataSources

typealias BlockWithSource = (DataSource)->Void

struct TaskSection {
    var header: String
    var items: [Item]
}

extension TaskSection: SectionModelType {
    typealias Item = TaskDTO
    
    init(original: TaskSection, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol FeedViewControllerPresenter {
    var sections: Variable<[TaskSection]> { get }
    func loadData(finished: @escaping BlockWithSource)
    func makeSomeDataChange()
}

class FeedViewControllerPresenterImpl: FeedViewControllerPresenter {
    var sections = Variable<[TaskSection]>([])
    
    fileprivate var modelLayer: ModelLayer
    fileprivate var bag = DisposeBag()
    fileprivate var tasks = Variable<[TaskDTO]>([])
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
        setupObservers()
    }
}

//MARK: - Reactive Process
extension FeedViewControllerPresenterImpl {
    func setupObservers() {
        tasks.asObservable().subscribe(onNext: { [weak self] newTasks in
            self?.updateNewSections(with: newTasks)
        }).disposed(by: bag)
    }
    
    func updateNewSections(with newTasks: [TaskDTO]) {
        func mainWork() {
            sections.value = filter(tasks: newTasks)
        }
        
        func filter(tasks: [TaskDTO]) -> [TaskSection] {
            let suspendedTasks = tasks.filter {  $0.suspended! }
            let ongoingTasks   = tasks.filter { !$0.suspended! }
            
            
            return [TaskSection(header: "Suspended Tasks", items: suspendedTasks),
                    TaskSection(header: "Ongoing Tasks", items: ongoingTasks)]
        }
        
        mainWork()
    }
}

//MARK: - Data Methods
extension FeedViewControllerPresenterImpl {
    func makeSomeDataChange() {
        let newTask = TaskDTO(brief: "Short description", full: "Full description", order: 2, due: Date(), suspended: true)
        tasks.value.insert(newTask, at: 0)
    }
    
    func loadData(finished: @escaping BlockWithSource) {
        modelLayer.loadData { [weak self] source, tasks in
            self?.tasks.value = tasks
            finished(source)
        }
    }
}


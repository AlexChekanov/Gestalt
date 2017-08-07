import UIKit
import Swinject
import SwinjectStoryboard

protocol DependencyRegistry {
    var container: Container { get }
    var navigationCoordinator: NavigationCoordinator! { get }
    
    // Feed
    typealias RootNavigationCoordinatorMaker = (UIViewController) -> NavigationCoordinator
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator
    
    typealias CardTableViewCellMaker = (UITableView, IndexPath, TaskDTO) -> CardTableViewCell
    func makeCardTableViewCell(for tableView: UITableView, at indexPath: IndexPath, with task: TaskDTO) -> CardTableViewCell
    
    // Details
    typealias DetailViewControllerMaker = (TaskDTO) -> DetailViewController
    func makeDetailViewController(with task: TaskDTO) -> DetailViewController

    typealias ProcessCollectionViewControllerMaker = (TaskDTO)  -> ProcessCollectionViewController
    func makeProcessCollectionViewController(with task: TaskDTO) -> ProcessCollectionViewController
    
    typealias StepCollectionViewCellMaker = (TaskDTO) -> StepCollectionViewCell
    func makeStepCollectionViewCell(for collectionView: UICollectionView, at indexPath: IndexPath, with task: TaskDTO) -> StepCollectionViewCell
    
    typealias BodyTableViewControllerMaker = (TaskDTO)  -> BodyTableViewController
    func makeBodyTableViewController(with task: TaskDTO) -> BodyTableViewController
    
    
    typealias ActionTableViewCellMaker = (TaskDTO) -> ActionTableViewCell
    func makeActionTableViewCell(for tableView: UITableView, at indexPath: IndexPath, with task: TaskDTO) -> ActionTableViewCell

    
}

class DependencyRegistryImpl: DependencyRegistry {
    
    var container: Container
    var navigationCoordinator: NavigationCoordinator!
    
    
    init(container: Container) {
        
        Container.loggingFunction = nil
        
        self.container = container
        
        registerDependencies()
        registerPresenters()
        registerViewControllers()
    }
    
    func registerDependencies() {
        
        container.register(NavigationCoordinator.self) { (r, rootViewController: UIViewController) in
            return RootNavigationCoordinatorImpl(with: rootViewController, registry: self)
            }.inObjectScope(.container)
        
        container.register(NetworkLayer.self    ) { _ in NetworkLayerImpl()  }.inObjectScope(.container)
        container.register(DataLayer.self       ) { _ in DataLayerImpl()     }.inObjectScope(.container)
        container.register(TaskTranslator.self  ) { _ in TaskTranslatorImpl()}.inObjectScope(.container)
        
        container.register(TranslationLayer.self) { r in
            TranslationLayerImpl(taskTranslator: r.resolve(TaskTranslator.self)!)
            }.inObjectScope(.container)
        
        container.register(ModelLayer.self){ r in
            ModelLayerImpl(networkLayer:     r.resolve(NetworkLayer.self)!,
                           dataLayer:        r.resolve(DataLayer.self)!,
                           translationLayer: r.resolve(TranslationLayer.self)!)
            }.inObjectScope(.container)
    }
    
    func registerPresenters() {
        container.register(FeedViewControllerPresenter.self             ) { r in FeedViewControllerPresenterImpl(modelLayer: r.resolve(ModelLayer.self)!) }
        container.register(CardTableViewCellPresenter.self              ) { (r, task: TaskDTO) in CardTableViewCellPresenterImpl(with: task) }
        container.register(DetailViewControllerPresenter.self           ) { (r, task: TaskDTO)  in DetailViewControllerPresenterImpl(with: task) }
        container.register(ProcessCollectionViewControllerPresenter.self) { (r, task: TaskDTO) in ProcessCollectionViewControllerPresenterImpl(with: task) }
        container.register(StepCollectionViewCellPresenter.self         ) { (r, task: TaskDTO) in StepCollectionViewCellPresenterImpl(with: task) }
        container.register(BodyTableViewControllerPresenter.self        ) { (r, task: TaskDTO) in BodyTableViewControllerPresenterImpl(with: task) }
        container.register(ActionTableViewCellPresenter.self            ) { (r, task: TaskDTO) in ActionTableViewCellPresenterImpl(with: task) }
    }
    
    
    
    func registerViewControllers() {
        
        container.register(DetailViewController.self) { (r, task:TaskDTO) in
            let presenter = r.resolve(DetailViewControllerPresenter.self, argument: task)!
            
            //NOTE: We don't have access to the constructor for this VC so we are using method injection
            let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.configure(with: presenter, navigationCoordinator: self.navigationCoordinator)
            return vc
        }
        
        container.register(ProcessCollectionViewController.self) { (r, task: TaskDTO) in
            let presenter = r.resolve(ProcessCollectionViewControllerPresenter.self, argument: task)!
            return ProcessCollectionViewController(with: presenter, navigationCoordinator: self.navigationCoordinator)
        }
    }
    
    //MARK: - Maker Methods
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator {
        navigationCoordinator = container.resolve(NavigationCoordinator.self, argument: rootViewController)!
        return navigationCoordinator
    }
    
    
    func makeCardTableViewCell(for tableView: UITableView, at indexPath: IndexPath, with task: TaskDTO) -> CardTableViewCell {
        let presenter = container.resolve(CardTableViewCellPresenter.self, argument: task)!
        let cell = CardTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    func makeDetailViewController(with task: TaskDTO) -> DetailViewController {
        return container.resolve(DetailViewController.self, argument: task)!
    }
    
    
    func makeProcessCollectionViewController(with task: TaskDTO) -> ProcessCollectionViewController {
        return container.resolve(ProcessCollectionViewController.self, argument: task)!
    }
    
    
    func makeStepCollectionViewCell(for collectionView: UICollectionView, at indexPath: IndexPath, with task: TaskDTO) -> StepCollectionViewCell {
        let presenter = container.resolve(StepCollectionViewCellPresenter.self, argument: task)!
        let cell = StepCollectionViewCell.dequeue(from: collectionView, for: indexPath, with: presenter)
        return cell
    }
    
    func makeBodyTableViewController(with task: TaskDTO) -> BodyTableViewController {
        return container.resolve(BodyTableViewController.self, argument: task)!
    }
    
    func makeActionTableViewCell(for tableView: UITableView, at indexPath: IndexPath, with task: TaskDTO) -> ActionTableViewCell {
        let presenter = container.resolve(ActionTableViewCellPresenter.self, argument: task)!
        let cell = ActionTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    
    
    
}

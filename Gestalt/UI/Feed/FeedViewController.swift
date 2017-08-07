import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class FeedViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    weak var navigationCoordinator: NavigationCoordinator?
    
    fileprivate var presenter: FeedViewControllerPresenter!
    fileprivate var taskCellMaker: DependencyRegistry.CardTableViewCellMaker!
    fileprivate var bag = DisposeBag()
    
    fileprivate var dataSource = RxTableViewSectionedReloadDataSource<TaskSection>()
    
    func configure(with presenter: FeedViewControllerPresenter,
                   navigationCoordinator: NavigationCoordinator,
                   taskCellMaker: @escaping DependencyRegistry.CardTableViewCellMaker)
    {
        self.presenter = presenter
        self.navigationCoordinator = navigationCoordinator
        self.taskCellMaker = taskCellMaker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardTableViewCell.register(with: tableView)
        
        presenter.loadData { [weak self] source in
            self?.newDataReceived(from: source)
        }
        
        initDataSource()
        initTableView()
    }
    
    func newDataReceived(from source: DataSource) {
        //Toast(text: "New Data from \(source)").show()
        tableView.reloadData()
    }
    
    @IBAction func updateData(_ sender: Any) {
        presenter.makeSomeDataChange()
    }
}

//MARK: Reaction Process
extension FeedViewController {
    func initDataSource() {
        dataSource.configureCell = { _, tableView, indexPath, task in
            let cell = self.taskCellMaker(tableView, indexPath, task)
            return cell
        }
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
    }
    
    func initTableView() {
        presenter.sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource[indexPath])
            }.subscribe(onNext: { indexPath, task in
                self.next(with: task)
            }).disposed(by: bag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
}

//MARK: - UITableViewDelegate
extension FeedViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    func next(with task: TaskDTO) {
        let args = ["task": task]
        navigationCoordinator!.next(arguments: args)
    }
}





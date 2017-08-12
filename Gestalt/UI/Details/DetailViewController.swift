import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var theTitle: UILabel!
    
    var presenter: DetailViewControllerPresenter!
    
    fileprivate weak var navigationCoordinator: NavigationCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        clean()
        updateData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParentViewController {
            navigationCoordinator?.movingBack()
        }
    }
    
    func configure(with presenter: DetailViewControllerPresenter,
                   navigationCoordinator: NavigationCoordinator)
    {
        self.presenter = presenter
        self.navigationCoordinator = navigationCoordinator
    }
    
    func setupView() {
        
        self.view.backgroundColor = .orange
        
        //self.navigationController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
    }
    
    func clean() {
        theTitle.text = ""
    }
    
    func updateData () {
        guard presenter != nil else { return }
        
        self.theTitle.text = presenter.title
        self.title = presenter.title

    }
}

//MARK: - Touch Events
extension DetailViewController {
    @IBAction func briefcaseTapped(_ button: UIButton) {
        let args = ["task": presenter.task!]
        navigationCoordinator?.next(arguments: args)
    }
}

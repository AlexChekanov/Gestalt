import UIKit
import Firebase

protocol NavigationCoordinator: class {
    func next(arguments: Dictionary<String, Any>?)
    func movingBack()
}


class RootNavigationCoordinatorImpl: NavigationCoordinator {
    
    var registry: DependencyRegistry
    var rootViewController: UIViewController
    
    enum NavigationState {
        case atFeed
        case atDetails
    }
    
    var navState: NavigationState
    
    init(with rootViewController: UIViewController, registry: DependencyRegistry) {
        FirebaseCrashMessage("RootNavigationCoordinatorImpl Init Error")
        
        self.rootViewController = rootViewController
        self.registry = registry
        self.navState = .atFeed
    }
    
    func movingBack() {
        switch navState {
        case .atFeed: //not possible to move back - do nothing
            break
        case .atDetails:
            navState = .atFeed
        }
    }
    
    func next(arguments: Dictionary<String, Any>?) {
        switch navState {
        case .atFeed:
            showDetails(arguments: arguments)
        case .atDetails: //example - do nothing
            showFeed()
        }
    }
    
    func showDetails(arguments: Dictionary<String, Any>?) {
        guard let task = arguments?["task"] as? TaskDTO else { notifyNilArguments(); return }
        
        FirebaseCrashMessage("RootNavigationCoordinatorImpl.showDetails \(arguments as Any) Error")
        
        let detailViewController = registry.makeDetailViewController(with: task)
        
        // TODO: add Split navigation support
        
//        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
//        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
//        
        
        rootViewController.navigationController?.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
        
//        detailViewController.navigationItem.leftBarButtonItem = rootViewController.splitViewController?.displayModeButtonItem
//        
        navState = .atDetails
    }
    
    func showFeed() {
        
        FirebaseCrashMessage("RootNavigationCoordinatorImpl.showFeed() Error")
        
        rootViewController.navigationController?.popToRootViewController(animated: true)
        navState = .atFeed
    }
    
    func notifyNilArguments() {
        print("notify user of error")
    }
}

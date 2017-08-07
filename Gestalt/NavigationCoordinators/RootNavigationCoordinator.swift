import UIKit

protocol NavigationCoordinator: class {
    func next(arguments: Dictionary<String, Any>?)
    func movingBack()
}

enum NavigationState {
    case atFeed,
    atDetails
}

class RootNavigationCoordinatorImpl: NavigationCoordinator {
    
    var registry: DependencyRegistry
    var rootViewController: UIViewController
    
    var navState: NavigationState = .atFeed
    
    init(with rootViewController: UIViewController, registry: DependencyRegistry) {
        self.rootViewController = rootViewController
        self.registry = registry
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
        
        let detailViewController = registry.makeDetailViewController(with: task)
        
        // TODO: add Split navigation support
        
        rootViewController.navigationController?.pushViewController(detailViewController, animated: true)
        navState = .atDetails
    }
    
    func showFeed() {
        rootViewController.navigationController?.popToRootViewController(animated: true)
        navState = .atFeed
    }
    
    func notifyNilArguments() {
        print("notify user of error")
    }
}

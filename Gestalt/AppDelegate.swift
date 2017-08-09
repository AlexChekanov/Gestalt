import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static var navigationCoordinator: NavigationCoordinator!
    static var dependencyRegistry: DependencyRegistry!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseCrashMessage("Check the Firebase Crash Reporting is installed")
        fatalError()
        
        return true
    }
}


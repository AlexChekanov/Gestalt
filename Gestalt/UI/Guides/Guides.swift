import Foundation
import UIKit

public struct Guides {
    
    func setAppearance (of application: UIApplication) {
        
        application.keyWindow?.backgroundColor = Guides.Color.background
        
        // Status bar
        application.statusBarStyle = .lightContent
        application.isStatusBarHidden = false
        
        // Navigation bar
        UINavigationBar.appearance().barTintColor = Guides.Color.navigationBarTint
        UINavigationBar.appearance().tintColor = Guides.Color.navigationElementsTint
        
        let navigationFont = Guides.Font.navigation
        let navigationFontAttributes = [NSFontAttributeName : navigationFont, NSForegroundColorAttributeName : Guides.Color.navigationText]
        
        UINavigationBar.appearance().titleTextAttributes = navigationFontAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(navigationFontAttributes, for: .normal)
        
        // Search bar
        UISearchBar.appearance().barTintColor = Guides.Color.searchBarTint
        UISearchBar.appearance().backgroundColor = Guides.Color.searchBarBackground
        UISearchBar.appearance().tintColor = Guides.Color.searchField
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Guides.Color.searchFieldCaret
        
        // Toolbar
        UIToolbar.appearance().barStyle = Guides.Color.toolbarStyle
        UIToolbar.appearance().tintColor = Guides.Color.toolbarElementsTint
        UIToolbar.appearance().barTintColor = Guides.Color.toolbarTint
        UIToolbar.appearance().isTranslucent = Guides.Color.toolbarIsTranslucent
        
        // Tabbar
        UITabBar.appearance().barStyle = Guides.Color.tabBarStyle
        UITabBar.appearance().tintColor = Guides.Color.tabBarElementsTint
        UITabBar.appearance().barTintColor = Guides.Color.tabBarTint
        UITabBar.appearance().isTranslucent = Guides.Color.tabBarIsTranslucent
    }
    
}

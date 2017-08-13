import UIKit

extension FeedViewController {
    
    func applyStyle() {
        
        self.view.backgroundColor = Guides.Color.background
        self.tableView.backgroundColor = .clear
        
        let bgView = UIView()
        bgView.backgroundColor = .clear
        self.tableView.backgroundView = bgView
      
        self.tableView.separatorStyle = .none
        
    }
}

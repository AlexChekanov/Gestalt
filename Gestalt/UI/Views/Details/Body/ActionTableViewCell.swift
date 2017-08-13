import UIKit

class ActionTableViewCell: UITableViewCell {
    
    @IBOutlet var theLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//MARK: - Configure
extension ActionTableViewCell {
    func configure(with presenter: ActionTableViewCellPresenter) {
        
        getSomeData { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.set(full: presenter.full)
            
        }
    }
    
    fileprivate func getSomeData(finished: @escaping ()->Void ) {
        
    }
}

//MARK: - Dynamic Sizing font - iOS 10
extension ActionTableViewCell {
    
    func commonInit() {
        
        setAccessibilityProperties()
    }
    
    func setAccessibilityProperties() {
        theLabel.isAccessibilityElement = true
        theLabel.adjustsFontForContentSizeCategory = true
    }
    
    func set(full: String) {
        theLabel.text = full
        theLabel.accessibilityValue = full
    }
    
    func set(due: Date) {
        theLabel.text  = String(describing: due)
    }
}





//MARK: - Helper Methods
extension ActionTableViewCell {
    public static var cellId: String {
        return "ActionCell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: ActionTableViewCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: ActionTableViewCell.cellId, bundle: ActionTableViewCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(ActionTableViewCell.nib, forCellReuseIdentifier: cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> ActionTableViewCell {
        return bundle.loadNibNamed(self.cellId, owner: owner, options: nil)?.first as! ActionTableViewCell
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with ActionCellPresenter: ActionTableViewCellPresenter) -> ActionTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! ActionTableViewCell
        cell.configure(with: ActionCellPresenter)
        return cell
    }
}

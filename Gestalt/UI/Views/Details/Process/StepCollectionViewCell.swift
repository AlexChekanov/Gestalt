import UIKit

class StepCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
//    override var isSelected: Bool {
//        
//    }
    
        // Configure the view for the selected state
    
}


//MARK: - Configure
extension StepCollectionViewCell {
    func configure(with presenter: StepCollectionViewCellPresenter) {
        
        getSomeData { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.set(brief: presenter.brief)
            
        }
    }
    
    fileprivate func getSomeData(finished: @escaping ()->Void ) {
        
    }
}

//MARK: - Dynamic Sizing font - iOS 10
extension StepCollectionViewCell {
    
    func commonInit() {
        
        setAccessibilityProperties()
    }
    
    func setAccessibilityProperties() {
        title.isAccessibilityElement = true
        title.adjustsFontForContentSizeCategory = true
    }
    
    func set(brief: String) {
        title.text = brief
        title.accessibilityValue = brief
    }
    
    func set(due: Date) {
        title.text  = String(describing: due)
    }
}





//MARK: - Helper Methods
extension StepCollectionViewCell {
    
    public static var cellId: String {
        return "StepCell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: StepCollectionViewCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: StepCollectionViewCell.cellId, bundle: StepCollectionViewCell.bundle)
    }
    
    public static func register(with collectionView: UICollectionView) {
        collectionView.register(StepCollectionViewCell.nib, forCellWithReuseIdentifier: cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> ActionTableViewCell {
        return bundle.loadNibNamed(self.cellId, owner: owner, options: nil)?.first as! ActionTableViewCell
    }
    
    public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with StepCollectionViewCellPresenter: StepCollectionViewCellPresenter) -> StepCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! StepCollectionViewCell
        cell.configure(with: StepCollectionViewCellPresenter)
        return cell
    }
}

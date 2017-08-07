import UIKit

class CardTableViewCell: UITableViewCell {

    
    @IBOutlet var briefLabel: UILabel!
    @IBOutlet var dueLabel: UILabel!
    @IBOutlet var imageContainer: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var presenter: CardTableViewCellPresenter!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageContainer.subviews.forEach { $0.removeFromSuperview() }
        briefLabel.text = ""
        dueLabel.text = ""
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: adding images
extension CardTableViewCell {
    func add(imageName: String) {
        let smallImageName = String(format:"%@s", imageName)
        
        guard let image = UIImage(named: smallImageName) else { return }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = image
        
        imageContainer.addSubview(imageView)
    }
}

//MARK: - Configure
extension CardTableViewCell {
    func configure(with presenter: CardTableViewCellPresenter) {
        
        getSomeData { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.set(brief: presenter.brief)
            strongSelf.set(due: presenter.due)
            //strongSelf.add(imageName: presenter.imageName)
        }
    }
    
    fileprivate func getSomeData(finished: @escaping ()->Void ) {
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        //faking some network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            
            finished()
        }
    }
}

//MARK: - Dynamic Sizing font
extension CardTableViewCell {
    
    func commonInit() {
        
        setAccessibilityProperties()
    }
    
    func setAccessibilityProperties() {
        briefLabel.isAccessibilityElement = true
        briefLabel.adjustsFontForContentSizeCategory = true
    }
    
    func set(brief: String) {
        briefLabel.text = brief
        briefLabel.accessibilityValue = brief
    }
    
    func set(due: Date) {
        dueLabel.text  = String(describing: due)
    }
}



//MARK: - Helper Methods
extension CardTableViewCell {
    public static var cellId: String {
        return "CardCell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: CardTableViewCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: CardTableViewCell.cellId, bundle: CardTableViewCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(CardTableViewCell.nib, forCellReuseIdentifier: cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> CardTableViewCell {
        return bundle.loadNibNamed(self.cellId, owner: owner, options: nil)?.first as! CardTableViewCell
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with CardCellPresenter: CardTableViewCellPresenter) -> CardTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! CardTableViewCell
        cell.configure(with: CardCellPresenter)
        return cell
    }
}

import UIKit

class HomeAddButton: UIButton {

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.backgroundColor = Guides.Color.attention
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.shadowColor = self.backgroundColor?.adjust(by: -40)?.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize (width: 0.0, height: 4.0)
        self.layer.shadowRadius = 4
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 128/255, alpha: 0.2).cgColor
        self.imageView?.alpha = 1
        
        let gradientView = DirectionalGradient()
        gradientView.startColor = (self.backgroundColor?.adjust(by: -10))!
        gradientView.endColor = gradientView.startColor.withAlphaComponent(0)
        gradientView.angle = 90
        gradientView.frame = self.bounds
        gradientView.layer.cornerRadius = self.frame.size.width / 2
        gradientView.isUserInteractionEnabled = false
        gradientView.isExclusiveTouch = false
        
        self.clipsToBounds = false
        self.insertSubview(gradientView, at: 0)
    }
}

//
//  SwiftyGardient.swift
//
//
//  Created by Alexey Chekanov on 5/28/17.
//  Copyright © 2017 Alexey Chekanov. All rights reserved.
//

import UIKit

@IBDesignable class DirectionalGradient: UIView {

    /// The startColor for the Gardient
    @IBInspectable var startColor: UIColor = UIColor.clear {
        didSet{
            setupDirectionalGradient()
        }
    }

    /// The endColor for the Gardient
    @IBInspectable var endColor: UIColor = UIColor.blue {
        didSet{
            setupDirectionalGradient()
        }
    }

    // Angle
    @IBInspectable var angle: Double = 0 {
        didSet{
            setupDirectionalGradient()
        }
    }

    
    func setupDirectionalGradient() {
        let colors = [startColor.cgColor, endColor.cgColor]

        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        
        gradientLayer.endPoint = CGPoint(x: CGFloat(cos(angle*Double.pi/180.0)), y: CGFloat(sin(angle*Double.pi/180.0)))
        setNeedsDisplay()
    }

    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }

    override class var layerClass: AnyClass{
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDirectionalGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupDirectionalGradient()
    }
    
}




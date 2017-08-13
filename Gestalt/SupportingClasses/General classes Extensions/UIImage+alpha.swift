//
//  UIImage+alpha.swift
//  Gestalt
//
//  Created by Alexey Chekanov on 6/25/17.
//  Copyright © 2017 Alexey Chekanov. All rights reserved.
//

import UIKit

extension UIImage{
    
    func alpha(_ value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}

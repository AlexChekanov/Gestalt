//
//  Guides.Shadows.swift
//  Guidelines
//
//  Created by Alexey Chekanov on 7/11/17.
//  Copyright © 2017 Alexey Chekanov. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Shadow styles

extension Guides.Shadow {
    static var none: Guides.Shadow {
        return Guides.Shadow(shadowColor: .clear, shadowOffset: CGSize.zero, shadowRadius: 0, shadowOpacity: 0, masksToBound: nil)
    }
    
    static var soft: Guides.Shadow {
        return Guides.Shadow(shadowColor: .black, shadowOffset: CGSize(width: 0.0, height: 6.0), shadowRadius: 8, shadowOpacity: 0.8, masksToBound: false)
    }
    
    static var hard: Guides.Shadow {
        return Guides.Shadow(shadowColor: .black, shadowOffset: CGSize(width: 0.0, height: 6.0), shadowRadius: 4, shadowOpacity: 1, masksToBound: false)
    }
}

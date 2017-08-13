//
//  UISearchBar+fontAndColor.swift
//  Gestalt
//
//  Created by Alexey Chekanov on 5/20/17.
//  Copyright © 2017 Alexey Chekanov. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func change(textFont : UIFont?, textFieldColor : UIColor) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
                textField.backgroundColor = textFieldColor
            }
        }
    }
}

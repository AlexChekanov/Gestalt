//
//  Date+userFriendly.swift
//  Gestalt
//
//  Created by Alexey Chekanov on 6/4/17.
//  Copyright © 2017 Alexey Chekanov. All rights reserved.
//

import Foundation

extension Date {
    
    var  formatter: DateFormatter { return DateFormatter() }
    
    /** Return a user friendly hour */
    func userFriendlyFullDate() -> String {
        // Customize a date formatter
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter.string(from: self )
    }
    
    /** Return a user friendly hour */
    func userFriendlyHours() -> String {
        // Customize a date formatter
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter.string(from: self )
    }
}

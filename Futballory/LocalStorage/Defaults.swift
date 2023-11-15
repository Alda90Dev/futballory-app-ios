//
//  Defaults.swift
//  Futballory
//
//  Created by Aldair Carrillo on 13/11/23.
//

import UIKit

class Defaults {
    private let defaults = UserDefaults.standard
    
    private let datesKey = "dates"
    
    var dates: [String] {
        get {
            return defaults.object(forKey: datesKey) as? [String] ?? []
        }
        
        set {
            defaults.setValue(newValue, forKey: datesKey)
        }
    }
    
    class var shared: Defaults {
        struct Static {
            static let instance = Defaults()
        }
        
        return Static.instance
    }
}

//
//  Category.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 26/06/23.
//

import Foundation

enum Category: String, CaseIterable {
    case fitness = "Fitness"
    case nutrition = "Nutrition"
    case work = "Work"
    case personal = "Personal"
    
    var displayName: String {
        return self.rawValue
    }
}

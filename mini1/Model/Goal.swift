//
//  Goal.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import Foundation

struct Goal: Codable, Identifiable {
    var id: UUID
    var description: String
    var isComplete: Bool
    var category: String
    
    init(id: UUID = UUID(), description: String, isComplete: Bool = false, category: String) {
        self.id = id
        self.description = description
        self.isComplete = isComplete
        self.category = category
    }
}

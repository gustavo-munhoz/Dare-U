//
//  Goal.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import Foundation

struct Challenge: Codable, Identifiable, Equatable {
    var id: UUID
    var description: String
    var isComplete: Bool
    var category: String
    var timesCompletedThisWeek: Int
    var dateOfCreation = Date()
    var lastCompletionDate: Date?
    var imageName: String
    
    init(id: UUID = UUID(), description: String, isComplete: Bool = false, category: String, timesCompletedThisWeek: Int, lastCompletionDate: Date? = nil) {
        self.id = id
        self.description = description
        self.isComplete = isComplete
        self.category = category
        self.timesCompletedThisWeek = timesCompletedThisWeek
        self.lastCompletionDate = lastCompletionDate
        self.imageName = "\(self.category.lowercased())\(Int.random(in: 1...3))"
    }
}

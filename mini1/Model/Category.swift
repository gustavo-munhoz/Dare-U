//
//  Category.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 26/06/23.
//

import Foundation

enum Category: String, CaseIterable {
    case selfcare = "Autocuidado"
    case sport = "Esporte"
    case skill = "Habilidade"
    case cooking = "Culinária"
    case mind = "Mente"
    case tech = "Tecnologia"
    case art = "Arte"
    
    var displayName: String {
        return self.rawValue
    }
}

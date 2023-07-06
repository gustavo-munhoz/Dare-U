//
//  Category.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 26/06/23.
//

import Foundation

enum Category: String, CaseIterable {
    case selfcare = "autocuidado"
    case sport = "esporte"
    case skill = "habilidade"
    case cooking = "culinaria"
    case mind = "mente"
    case tech = "tecnologia"
    case art = "arte"
    
    var displayName: String {
        return self.rawValue
    }
}

//
//  UserData.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 26/06/23.
//

import Foundation

class UserData: ObservableObject {
    @Published var player1Name: String {
        didSet {
            UserDefaults.standard.set(player1Name, forKey: "player1Name")
        }
    }
    
    @Published var player2Name: String {
        didSet {
            UserDefaults.standard.set(player2Name, forKey: "player2Name")
        }
    }

    init() {
        self.player1Name = UserDefaults.standard.object(forKey: "player1Name") as? String ?? "Luisa"
        self.player2Name = UserDefaults.standard.object(forKey: "player2Name") as? String ?? "Ariel"
    }
}

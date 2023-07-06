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

    @Published var challenges: [Challenge] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(challenges) {
                UserDefaults.standard.set(encoded, forKey: "challenges")
            }
        }
    }

    @Published var didShowOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(didShowOnboarding, forKey: "DidShowOnboarding")
        }
    }
    
    init() {
        self.player1Name = UserDefaults.standard.object(forKey: "player1Name") as? String ?? ""
        self.player2Name = UserDefaults.standard.object(forKey: "player2Name") as? String ?? ""
        self.didShowOnboarding = UserDefaults.standard.bool(forKey: "DidShowOnboarding")
        
        if let data = UserDefaults.standard.data(forKey: "challenges") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Challenge].self, from: data) {
                self.challenges = decoded
                return
            }
        }

        self.challenges = []
    }
}

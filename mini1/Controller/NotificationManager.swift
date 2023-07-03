//
//  NotificationManager.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 23/06/23.
//

import SwiftUI


class NotificationManager: ObservableObject {
    @Published var isDiffDay: Bool = false
    
    @objc
    func dayChanged() {
        isDiffDay.toggle()
        //UserDefaults.standard.set("FUNCIONOU?", forKey: "teste-mudança-de-data")
    }
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dayChanged),
            name: UIApplication.significantTimeChangeNotification,
            object: nil)
    }
}

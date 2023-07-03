//
//  StartView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 01/07/23.
//

import SwiftUI

struct StartView: View {
    @StateObject var userData = UserData()
        
    var body: some View {
        NavigationStack {
            if userData.didShowOnboarding {
                ContentView(userData: userData)
            } else {
                OnboardingView(userData: userData)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

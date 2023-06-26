//
//  OnboardingView.swift
//  mini1
//
//  Created by Yana Preisler on 23/06/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bem-vindo")
                .fontWidth(.condensed)
            
            Text("Bem-vindo")
                .fontDesign(.monospaced)
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

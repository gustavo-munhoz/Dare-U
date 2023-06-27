//
//  OnboardingView.swift
//  mini1
//
//  Created by Yana Preisler on 23/06/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
            }
            Image("Logo")
                .padding(44)
            
//            Text("Bem-vindo")
//                .fontWidth(.condensed)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 24)
            
            Text("Bem-vindo")
                .fontDesign(.monospaced)
                .font(.system(size: 34))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
            
            Text("Conecte-se, conquiste e celebre com seus amigos, mesmo à distância - os desafios compartilhados!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing], 24)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

//
//  OnboardingView.swift
//  mini1
//
//  Created by Yana Preisler on 23/06/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var name: String = ""
    @State private var desafiante: String = ""
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                    .foregroundColor(Color("Black"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                    .foregroundColor(Color("Gray02"))
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
                .padding(.bottom, 10)
            
            Text("Conecte-se, conquiste e celebre com seus amigos, mesmo à distância - os desafios compartilhados!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing], 24)
                .padding(.bottom, 14)
            
            Text("Qual o seu nome?")
                .font(.system(.footnote, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.bottom, 0)
                
            TextField("Nome", text: $name)
            
                .padding([.leading, .trailing], 24)
                .padding(.bottom, 10)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Quem você vai desafiar?")
                .font(.system(.footnote, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.bottom, 0)
                
            TextField("Desafiante", text: $desafiante)
                .frame(height: 44)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing], 24)
                .padding(.bottom, 10)
                .padding(.top, 0)
            
            
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("Gray03"))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

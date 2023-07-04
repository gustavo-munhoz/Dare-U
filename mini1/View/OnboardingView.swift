//
//  OnboardingView.swift
//  mini1
//
//  Created by Yana Preisler on 23/06/23.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var userData = UserData()
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppBlack"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppGray02"))
            }
            .frame(maxWidth: .infinity)
            
            Image("Logo")
                .padding(.top, 10)
            
            
            Text("Bem-vindo")
                .fontDesign(.monospaced)
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundColor(Color("AppBlack"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Compartilhe desafios com os seus amigos!")
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 14)
            
            Text("Qual o seu nome?")
                .font(.system(.footnote, weight: .regular))
                .foregroundColor(Color("AppGray02"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Nome", text: $userData.player1Name)
                .font(.system(size: 17))
                .frame(height: 44)
                .padding(.leading, 16)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AppGray02")))
                .padding(.bottom, 10)
            
            Text("Quem você vai desafiar?")
                .font(.system(.footnote, weight: .regular))
                .foregroundColor(Color("AppGray02"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Desafiante", text: $userData.player2Name)
                .font(.system(size: 17))
                .frame(height: 44)
                .padding(.leading, 14)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AppGray02")))
                .padding(.bottom, 46)
            
            NavigationLink(destination:
                OnboardingView2(userData: userData) {
                    userData.didShowOnboarding = true
            }) {
                HStack {
                    Text("pular")
                        .foregroundColor(Color("AppBlack"))
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("AppGray03"))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color("AppPink"), lineWidth: 1))
                .padding(.bottom, 2)
            }
            
            NavigationLink(destination: OnboardingView2(userData: userData) {
                userData.didShowOnboarding = true
            }) {
                HStack {
                    Text("próximo")
                        .foregroundColor(.white)
                        .font(.callout)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("AppPink"))
                .cornerRadius(10)
            }
            
        }
        .padding(.horizontal, 24)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AppGray03"))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(userData: UserData())
    }
}

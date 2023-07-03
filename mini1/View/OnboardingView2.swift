//
//  OnboardingView2.swift
//  mini1
//
//  Created by Yana Preisler on 27/06/23.
//

import SwiftUI

struct OnboardingView2: View {
    
    @ObservedObject var userData: UserData
    var onFinish: () -> Void
    
    @State private var title: String = ""
    
    @State private var category = Category.selfcare
    
    var isDisabled: Bool {
        userData.challenges.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                    .foregroundColor(Color("AppGray02"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                    .foregroundColor(Color("AppBlack"))
            }
            
            Spacer()
            
            Text("Crie os desafios")
                .fontDesign(.monospaced)
                .font(.system(size: 34))
                .bold()
            
            VStack {
                ForEach(userData.challenges) { challenge in
                    ChallengeCardView(goal: challenge, isEditing: Binding.constant(false), deleteAction: {})
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Título")
                    TextField("Título", text: $title)
                }
                HStack {
                    Text("Categoria:")
                    
                    Menu(category.displayName) {
                        ForEach(Category.allCases, id: \.self) { c in
                            Button(c.displayName) {
                                category = c
                            }
                        }
                    }
                    .menuStyle(.borderlessButton)
                }
            }
            .padding()
            .background(Color("AppGray03"))
            .cornerRadius(10) 
            
            Button(action: {
                let challenge = Challenge(description: title, category: category.displayName, timesCompletedThisWeek: 0)
                
                userData.challenges.append(challenge)
            } ) {
                Text("Adicionar desafio")
                    .background(Color("AppGray04"))
            }
            
            Spacer()
            
            NavigationLink(destination: ContentView(userData: userData)) {
                HStack {
                    Text("pular")
                        .foregroundColor(Color("AppBlack"))
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color("AppPink"), lineWidth: 1))
            }
            
            NavigationLink(destination: ContentView(userData: userData)) {
                HStack {
                    Text("próximo")
                        .foregroundColor(.white)
                        .font(.callout)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(isDisabled ? Color("AppGray04") : Color("AppPink"))
                .cornerRadius(10)
            }
            .disabled(isDisabled)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
        .onAppear {
            onFinish()
        }
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView2(userData: UserData()) {
                print("finished")
            }
        }
    }
}

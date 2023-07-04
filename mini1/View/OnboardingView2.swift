//
//  OnboardingView2.swift
//  mini1
//
//  Created by Yana Preisler on 27/06/23.
//

import SwiftUI


import UIKit

struct OnboardingView2: View {
    
    @State private var challengeDescription = ""
    
    @State var challenges: [Challenge] = []
    
    @State private var title: String = ""
    
    @State var category = Category.selfcare
    
    @State var selected : Challenge?
    
    let suggestedChallenges: [Challenge] = [
        Challenge(description: "Andar 2km de skate", isComplete: false, category:  Category.sport.displayName, timesCompletedThisWeek: 10),
        Challenge(description: "Tomar 1L de água", category:  Category.selfcare.displayName, timesCompletedThisWeek: 10),
        Challenge(description: "Assistir um filme", category:  Category.art.displayName, timesCompletedThisWeek: 10),
        Challenge(description: "Tomar café da manhã", category:  Category.cooking.displayName, timesCompletedThisWeek: 10)
    ]
    
    
    
    var isDisabled: Bool {
        selected == nil
    }
    
    var body: some View {
        VStack {
            
            HStack {
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
            
            ScrollView {
                
                Text("Adicione um desafio")
                    .fontDesign(.monospaced)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(Color("AppBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 24)
                
                VStack {
                    ForEach(challenges) { challenge in
                        ChallengeCardView(goal: challenge, isEditing: Binding.constant(false), deleteAction: {})
                    }
                }
            }
            
            HStack {
                Text("Desafios sugeridos")
                    .frame(width: 155, alignment: .leading)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color("AppPink"))
                        .cornerRadius(10)
                
                Spacer()
            }
            
            Spacer(minLength: 10)
                
                ForEach(suggestedChallenges, id: \.description) { challenge in
                    Button(action: {
                        withAnimation {
                            if selected == challenge {
                                selected = nil
                            } else {
                                selected = challenge
                            }
                        }
                    }) {
                        VStack(alignment: .leading) {
                            SelectedChallengeCardView(goal: challenge, isSelected: selected != challenge, deleteAction: {})
                        }
                        .padding(.vertical, 4)
                    }
                }
            
            Spacer(minLength: 16)
            
            NavigationLink(destination: ContentView()) {
                HStack {
                    Text("Fazer depois")
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
            
            NavigationLink(destination: ContentView()) {
                HStack {
                    Text("Vamos lá!")
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
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView2()
        }
    }
}

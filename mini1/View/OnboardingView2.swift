//
//  OnboardingView2.swift
//  mini1
//
//  Created by Yana Preisler on 27/06/23.
//

import SwiftUI
import UIKit

struct OnboardingView2: View {
    @ObservedObject var userData: UserData
    var onFinish: () -> Void
    
    @State private var title: String = ""
    
    @State private var category = Category.selfcare
    
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
            
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppGray02"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppGray02"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppBlack"))
            }
            .frame(maxWidth: .infinity)
            
                Text("Adicione um desafio")
                    .fontDesign(.monospaced)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(Color("AppBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 24)
                
                VStack {
                    ForEach(userData.challenges) { challenge in
                        ChallengeCardView(goal: challenge, isEditing: Binding.constant(false), deleteAction: {})
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

            ScrollView {
                VStack {
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
                            .padding(.horizontal, 24)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .clipped()
            .padding(.horizontal, -24)

            Spacer(minLength: 16)
            
            NavigationLink(destination: ContentView(userData: userData)) {
                HStack {
                    Text("Fazer depois")
                        .foregroundColor(Color("AppBlack"))
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("AppGray03"))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color("AppPink"), lineWidth: 1))
            }
            
            NavigationLink(destination: ContentView(userData: userData)) {
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
            .simultaneousGesture(TapGesture().onEnded { userData.challenges.append(selected!)
                onFinish()
            })
            .disabled(isDisabled)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        
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

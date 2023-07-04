//
//  AddChallengeView.swift
//  mini1
//
//  Created by Yana Preisler on 04/07/23.
//

import SwiftUI

struct AddChallengeView: View {
    
    enum FocusedField {
            case descri
        }
    
    @Environment(\.dismiss) var dismiss
    @Binding var challenges: [Challenge]
    
    @State private var challengeDescription = ""
    @State private var category = Category.art
    @State var selected : Challenge?
    
    @FocusState private var focusedField: FocusedField?
    
    // Desafios sugeridos
    let suggestedChallenges: [Challenge] = [
        Challenge(description: "Andar 2km de skate", isComplete: false, category:  Category.sport.displayName, timesCompletedThisWeek: 10),
        Challenge(description: "Tomar 1L de água", category:  Category.selfcare.displayName, timesCompletedThisWeek: 10),
        Challenge(description: "Assistir um filme", category:  Category.art.displayName, timesCompletedThisWeek: 10),
        Challenge(description: "Tomar café da manhã", category:  Category.cooking.displayName, timesCompletedThisWeek: 10)
    ]
    
    var buttonDisable : Bool {
        if focusedField == .descri {
            return challengeDescription.isEmpty
        } else {
            return selected == nil
        }
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                
                // Seção para adicionar novo desafio
                
                Text("Adicionar novo desafio")
                    .font(.system(size: 34))
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading) {
                    HStack {
                        
                        Text("Título")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
//                            .frame(width: .infinity, height: .infinity)
                            .background(Color("AppPink"))
                            .cornerRadius(10)
                        
                        TextField("Descrição do desafio", text: $challengeDescription)
                            .font(.system(size: 17))
                            .padding(.leading, 16)
                            .focused($focusedField, equals: .descri)
                    }
                    
                    HStack {
                        Text("Categoria")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
//                            .frame(width: .infinity, height: .infinity)
                            .background(Color("AppPink"))
                            .cornerRadius(10)
                        
                        Picker("Category", selection: $category) {
                            ForEach(Category.allCases, id: \.self) { category in
                                Text(category.displayName).tag(category)
                            }
                        }
                    }
                }
                
                .onChange(of: focusedField, perform: { newValue in
                    if newValue == .descri {
                        withAnimation {
                            selected = nil
                        }
                    }
                })
                
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .padding(.top, 4)
                .frame(width: .infinity, height: .infinity)
                .background(Color("AppGray03"))
                .cornerRadius(10)
                
                Spacer(minLength: 24)
                
                // Seção para desafios sugeridos
                
                Text("Desafios sugeridos")
                    .bold()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(suggestedChallenges, id: \.description) { challenge in
                            Button(action: {
                                if selected == challenge {
                                    selected = nil
                                    focusedField = .descri
                                } else {
                                    selected = challenge
                                    focusedField = nil
                                }
                            }) {
                                VStack(alignment: .leading) {
                                    SelectedChallengeCardView(goal: challenge, isSelected: selected != challenge, deleteAction: {})
                                    
                                }
                                .padding(.vertical, 4)
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                .clipped()
                .padding(.horizontal, -24)
                
                Spacer(minLength: 8)
                
                Button(action: addChallenge) {
                    HStack {
                        Text("Adicionar desafio")
                            .foregroundColor(.white)
                            .font(.callout)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(buttonDisable ? Color("AppGray04") : Color("AppPink"))
                    .cornerRadius(10)
                }
                .disabled(buttonDisable)
            }
            
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .padding(.top, 48)
        }
        .onAppear {
                    focusedField = .descri
        }
    }
    
    func addChallenge () {
        let newGoal: Challenge
        
        if let selected {
            newGoal = selected
        } else {
            newGoal = Challenge(
                description: challengeDescription,
                isComplete: false,
                category: category.displayName,
                timesCompletedThisWeek: 0
            )
        }
        
        
        challenges.append(newGoal)
        saveGoals(challenges)
        dismiss()
    }
}

struct AddChallengeView_Previews: PreviewProvider {
    static var challenges: [Challenge] = {
        // Recupera os dados salvos quando a View é carregada
        if let savedGoals = UserDefaults.standard.object(forKey: "Goals") as? Data {
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Challenge].self, from: savedGoals) {
                return loadedGoals
            }
        }
        return []
    }()
    
    static var previews: some View {
        AddChallengeView(challenges: .constant(challenges))
    }
}

//
//  AddChallengeView.swift
//  mini1
//
//  Created by Yana Preisler on 04/07/23.
//

import SwiftUI

struct AddChallengeView2: View {
    
    enum FocusedField {
        case descri
    }
    
    @Environment(\.dismiss) var dismiss
    @Binding var challenges: [Challenge]
    
    @State private var challengeDescription = ""
    @State private var category = Category.art
    @State var selected : Challenge?
    
    @FocusState private var focusedField: FocusedField?
    
    @State private var suggestedChallenges: [Challenge] = []
    @State private var isLoading = true
    
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
                            .background(Color("AppPink"))
                            .cornerRadius(10)
                        
                        Picker("Category", selection: $category) {
                            ForEach(Category.allCases, id: \.self) { category in
                                Text(
                                    category.displayName == "culinaria" ?
                                    "Culinária" :
                                    category.displayName.capitalized).tag(category)
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
                .frame(maxWidth: .infinity)
                .background(Color("AppGray03"))
                .cornerRadius(10)
                
                Spacer(minLength: 24)
                
                // Seção para desafios sugeridos
                
                Text("Desafios sugeridos")
                    .bold()
                
                
                Group {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(2.0, anchor: .center)
                            .padding(.top, 50)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    } else {
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
                    }
                }
                .onAppear {
                    Challenge.fetchChallenges(previousChallenges: suggestedChallenges) { fetchedChallenges in
                        self.suggestedChallenges = fetchedChallenges
                        isLoading = false
                    }
                }
                
                .clipped()
                .padding(.horizontal, -24)
                
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
                category: category.displayName
            )
        }
        
        
        challenges.append(newGoal)
        // saveGoals(challenges)
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
        AddChallengeView2(challenges: .constant(challenges))
    }
}

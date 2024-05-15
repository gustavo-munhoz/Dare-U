//
//  AddChallengeView.swift
//  mini1
//
//  Created by Yana Preisler on 04/07/23.
//

import SwiftUI

struct AddChallengeView2: View {
    @Environment(\.dismiss) var dismiss
    @Binding var challenges: [Challenge]
    
    @State private var challengeDescription = ""
    @State private(set) var category = Category.selfcare
    @State var selected : Challenge?
    
    @State private var suggestedChallenges: [Challenge] = []
    @State private var isLoading = true
    
    var darkFonts: [String] = ["mente", "habilidade", "tecnologia"]
    
    var buttonDisable : Bool {
        return selected == nil && challengeDescription.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                
                // Seção para adicionar novo desafio
                
                Text("Adicionar novo desafio")
                    .font(.system(size: 34))
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.5)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Título")
                            .bold()
                            .foregroundColor(darkFonts.contains(category.displayName) ? Color("AppBlackConstant") : Color("AppGray03Constant"))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color(category.displayName))
                            .cornerRadius(10)
                        
                        TextField("Descrição do desafio", text: $challengeDescription)
                            .font(.system(size: 17))
                            .padding(.leading, 16)
                    }
                    .minimumScaleFactor(0.5)
                    
                    HStack {
                        Text("Categoria")
                            .bold()
                            .foregroundColor(darkFonts.contains(category.displayName) ? Color("AppBlackConstant") : Color("AppGray03Constant"))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color(category.displayName))
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
                    .minimumScaleFactor(0.5)
                }
                
//                .onChange(of: focusedField, perform: { newValue in
//                    if newValue == .descri {
//                        withAnimation {
//                            selected = nil
//                        }
//                    }
//                })
                
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .padding(.top, 4)
                .frame(maxWidth: .infinity)
                .background(Color("AppGray03"))
                .cornerRadius(10)
                
                Spacer(minLength: 24)
                
                Button(action: addChallenge) {
                    HStack {
                        Text("Adicionar desafio")
                            .foregroundColor(.primary)
                            .font(.callout)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(buttonDisable ? Color("AppGray04") : Color(category.displayName))
                    .cornerRadius(10)
                }
                .disabled(buttonDisable)
            }
            
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .padding(.top, 48)
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

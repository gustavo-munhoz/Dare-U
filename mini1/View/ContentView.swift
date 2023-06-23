//
//  ContentView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import SwiftUI; import UIKit

struct ContentView: View {
    @State var goals: [Goal] = {
        // Recupera os dados salvos quando a View é carregada
        if let savedGoals = UserDefaults.standard.object(forKey: "Goals") as? Data {
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
                return loadedGoals
            }
        }
        return []
    }()
    
    @State private var showingAddGoalView = false
    @State private var isSharing = false
    @State private var screenshot: UIImage?
    
    var body: some View {
        VStack {
            Group {
                if !goals.isEmpty {
                    ForEach(goals.indices, id: \.self) { index in
                        HStack {
                            Button(action: {
                                goals[index].isComplete.toggle()
                                saveGoals(goals)
                            }) {
                                Circle()
                                    .fill(goals[index].isComplete ? .blue : .clear)
                                    .frame(width: 20)
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                            }
                            Text(goals[index].description)
                        }
                    }
                }
                else {
                    Text("Sem desafios.")
                }
            }
            
            Button(action: {
                showingAddGoalView = true
            }) {
                Text("Adicionar desafio")
            }
            .padding()
            .sheet(isPresented: $showingAddGoalView) {
                AddGoalView(goals: $goals)
            }
    
            SheetView(showSheetView: $isSharing, view: self)
            
            Spacer().frame(height: 75)
        }
        .padding()
        .background()
    }
}

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var goals: [Goal]
    
    @State private var goalDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Descrição do desafio", text: $goalDescription)
                
                Button("Adicionar desafio") {
                    let newGoal = Goal(description: goalDescription, isComplete: false)
                    goals.append(newGoal)
                    saveGoals(goals)
                    dismiss()
                }
            }
            .navigationTitle("Adicionar desafio")
        }
    }
}

func saveGoals(_ goals: [Goal]) {
    let encoder = JSONEncoder()
    if let encodedGoals = try? encoder.encode(goals) {
        UserDefaults.standard.set(encodedGoals, forKey: "Goals")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

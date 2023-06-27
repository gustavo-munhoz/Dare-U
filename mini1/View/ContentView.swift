//
//  ContentView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import SwiftUI; import UIKit

struct ContentView: View {
    @ObservedObject var userData = UserData()
    
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
    
    var header: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 46)
                    .offset(x: 20, y: 20)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 59)
                    .overlay(
                        Circle().fill(Color.black)
                            .frame(width: 56))
            }

            VStack {
                Text(userData.player1Name)
                    .font(.system(size: 34))
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                
                Text("vs \(userData.player2Name)")
            }
            
            Spacer()
        }
    }
    
    var goalList: some View {
        Group {
            if !goals.isEmpty {
                VStack(spacing: 15) {
                    ForEach(goals.indices, id: \.self) { index in
                        Button(action: {
                            goals[index].isComplete.toggle()
                            saveGoals(goals)
                        }) {
                            GoalCardView(goal: goals[index])
                        }
                    }
                }
            }
            else {
                Text("Sem desafios.")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                header
                
                Text("Desafios")
                    .font(.system(.title3, weight: .bold))
                
                goalList
                
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
                
                Button("Reset") {
                    goals = []
                    saveGoals(goals)
                }
                
                Spacer().frame(height: 75)
            }
            .onAppear {
                NotificationManager.requestPermission()
            }
            .padding(24)
            .background()
        }
    }
}

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var goals: [Goal]
    
    @State private var goalDescription = ""
    @State private var frequency = 1
    @State private var category = Category.fitness
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Descrição do desafio", text: $goalDescription)
                
                Picker("Frequência", selection: $frequency) {
                    ForEach(1...7, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                Picker("Category", selection: $category) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.displayName).tag(category)
                    }
                }
                
                Button("Adicionar desafio") {
                    let newGoal = Goal(
                        description: goalDescription,
                        isComplete: false,

                        category: category.displayName
                    )
                    goals.append(newGoal)
                    saveGoals(goals)
                    dismiss()
                }
            }
            .navigationTitle("Adicionar desafio")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func saveGoals(_ goals: [Goal]) {
    let encoder = JSONEncoder()
    if let encodedGoals = try? encoder.encode(goals) {
        UserDefaults.standard.set(encodedGoals, forKey: "Goals")
    }
}

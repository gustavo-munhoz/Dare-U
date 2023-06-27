//
//  ContentView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import SwiftUI; import UIKit

struct ContentView: View {
    @ObservedObject var userData = UserData()
    
    @State var challenges: [Challenge] = {
        // Recupera os dados salvos quando a View é carregada
        if let savedGoals = UserDefaults.standard.object(forKey: "Goals") as? Data {
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Challenge].self, from: savedGoals) {
                return loadedGoals
            }
        }
        return []
    }()
    
    @State private var showingAddChallengeView = false
    @State private var isSharing = false
    @State private var screenshot: UIImage?
    
    var header: some View {
        HStack(spacing: 32) {
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

            VStack(alignment: .leading) {
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
            if !challenges.isEmpty {
                VStack(spacing: 15) {
                    ForEach(challenges.indices, id: \.self) { index in
                        Button(action: {
                            challenges[index].isComplete.toggle()
                            saveGoals(challenges)
                        }) {
                            ChallengeCardView(goal: challenges[index])
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
            VStack(alignment: .leading, spacing: 40) {
                
                header
                
                //Spacer()
                
                VStack(alignment: .leading) {
                    Text("Desafios")
                        .font(.system(.title3, weight: .bold))
                    
                    goalList
                    
                    Button(action: {
                        showingAddChallengeView = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Adicionar desafio")
                        }
                        .font(.caption)
                        .foregroundColor(Color("AppBlack"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("AppGray04"))
                        )
                    }
                    .padding(.top, 24)
                    .sheet(isPresented: $showingAddChallengeView) {
                        AddChallengeView(goals: $challenges)
                    }
                }
                    
                HStack {
                    Text("Visão semanal")
                        .font(.system(.title3, weight: .bold))
                    
                    Spacer()
                    
                    SheetView(showSheetView: $isSharing, view: self)
                }
                .padding(.bottom, 16)
                
                Button("Reset") {
                    challenges = []
                    saveGoals(challenges)
                }
                
                Spacer()
            }
            .onAppear {
                NotificationManager.requestPermission()
            }
            .padding(.horizontal, 24)
            .background()
        }
    }
}

struct AddChallengeView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var goals: [Challenge]
    
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
                    let newGoal = Challenge(
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

func saveGoals(_ goals: [Challenge]) {
    let encoder = JSONEncoder()
    if let encodedGoals = try? encoder.encode(goals) {
        UserDefaults.standard.set(encodedGoals, forKey: "Goals")
    }
}

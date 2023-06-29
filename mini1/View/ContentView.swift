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
    @State private var isEditing = false
    
    
    var shouldAnimate: Bool {
        return !isEditing && !challenges.filter { $0.isComplete }.isEmpty
    }
    
    
    func resetChallengesIfDateChanged() {
        let currentDate = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        let dateString = formatter.string(from: currentDate)

        let lastOpenedDateString = UserDefaults.standard.string(forKey: "lastOpened") ?? ""

        if dateString != lastOpenedDateString {
            // Data mudou
            for i in 0..<challenges.count {
                challenges[i].isComplete = false
                if Calendar.current.isDateInToday(challenges[i].lastCompletionDate ?? Date()) {
                    challenges[i].timesCompletedThisWeek = 0
                    challenges[i].lastCompletionDate = nil
                }
            }
            saveGoals(challenges)
            UserDefaults.standard.set(dateString, forKey: "lastOpened")
        }
    }

    private func challengeButton(index: Int) -> some View {
        Group {
            if !isEditing {
                Button(action: {
                    if !challenges[index].isComplete && (!Calendar.current.isDateInToday(challenges[index].lastCompletionDate ?? Date()) || challenges[index].lastCompletionDate == nil) {
                        challenges[index].timesCompletedThisWeek += 1
                        challenges[index].lastCompletionDate = Date()
                    } else if challenges[index].isComplete && Calendar.current.isDateInToday(challenges[index].lastCompletionDate ?? Date()) {
                        challenges[index].timesCompletedThisWeek -= 1
                        challenges[index].lastCompletionDate = nil
                    }
                    challenges[index].isComplete.toggle()
                    saveGoals(challenges)
                }) {
                    ChallengeCardView(goal: challenges[index], isEditing: $isEditing) {
                        challenges.remove(at: index)
                        saveGoals(challenges)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                ChallengeCardView(goal: challenges[index], isEditing: $isEditing) {
                    challenges.remove(at: index)
                    saveGoals(challenges)
                }
            }
        }
    }
    
    var header: some View {
        HStack(spacing: 32) {
            ZStack {
                Image("Player2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 46, height: 46)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.white, lineWidth: 6)
                    )
                    .offset(x: 24, y: 20)

                Image("Player1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 59, height: 59)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.white, lineWidth: 3)
                    )
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
    
    var challengeList: some View {
        Group {
            if !challenges.isEmpty {
                VStack(spacing: 15) {
                    let incompleteChallenges = challenges.indices.filter { !challenges[$0].isComplete }
                    let completeChallenges = challenges.indices.filter { challenges[$0].isComplete }
                    
                    ForEach(incompleteChallenges, id: \.self) { index in
                        challengeButton(index: index)
                    }
                    ForEach(completeChallenges, id: \.self) { index in
                        challengeButton(index: index)
                    }
                }
            }
        }
        .animation(.linear, value: shouldAnimate)
    }
    
    var recap: some View {
        Group {
            if challenges.isEmpty {
                Text("Nenhum desafio foi adicionado ainda.")
                    .onAppear {
                        isEditing = false
                    }
            } else {
                VStack(alignment: .leading) {
                    ForEach(challenges.indices, id: \.self) { index in
                        HStack {
                            Text(challenges[index].description)
                                .font(.subheadline)
                            Spacer()
                            Text("\(challenges[index].timesCompletedThisWeek) vezes concluído")
                                .font(.subheadline)
                        }
                        .padding(.bottom, 5)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    
                    header
                    
                    //Spacer()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Desafios")
                                .font(.system(.title3, weight: .bold))
                            
                            Spacer()
                            
                            if !challenges.isEmpty {
                                Button(action: { isEditing.toggle() }) {
                                    Text(isEditing ? "Done" : "Edit")
                                        .fontWeight(isEditing ? .bold : .regular)
                                }
                            }
                        }
                        
                        challengeList
                        
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
                            AddChallengeView(challenges: $challenges)
                        }
                    }
                    
                    HStack {
                        Text("Visão semanal")
                            .font(.system(.title3, weight: .bold))
                        
                        Spacer()
                        
                        SheetView(showSheetView: $isSharing, view: self)
                    }
                    .padding(.bottom, 16)
                    
                    recap
                    
                    Button("Reset") {
                        challenges = []
                        saveGoals(challenges)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    let lastResetDate = UserDefaults.standard.object(forKey: "LastResetDate") as? Date
                    // Verifique se é domingo e se já fez o reset hoje
                    if Calendar.current.component(.weekday, from: Date()) == 1 && !Calendar.current.isDateInToday(lastResetDate ?? Date()) {
                        // Se for domingo e ainda não tiver feito o reset, redefina os contadores
                        for index in challenges.indices {
                            challenges[index].timesCompletedThisWeek = 0
                        }
                        saveGoals(challenges)
                        // Atualize a data do último reset
                        UserDefaults.standard.set(Date(), forKey: "LastResetDate")
                    }
                    NotificationManager.requestPermission()
                }
                
                .padding(.horizontal, 24)
                .preferredColorScheme(.light)
            }
        }
    }
    
    init() {
        resetChallengesIfDateChanged()
    }
}

struct AddChallengeView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var challenges: [Challenge]
    
    @State private var challengeDescription = ""
    @State private var category = Category.art
    
    // Desafios sugeridos
    let suggestedChallenges: [(description: String, category: Category)] = [
        ("Andar 2km de skate", .sport),
        ("Tomar 1L de água", .selfcare),
        ("Hidratar o rosto com creme", .selfcare),
        ("Tomar café da manhã", .cooking)
    ]
    
    var body: some View {
        NavigationView {
            Form {
                // Seção para adicionar novo desafio
                Section(header: Text("Adicionar novo desafio")) {
                    TextField("Descrição do desafio", text: $challengeDescription)
                    
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.displayName).tag(category)
                        }
                    }
                    
                    Button("Adicionar desafio") {
                        let newGoal = Challenge(
                            description: challengeDescription,
                            isComplete: false,
                            category: category.displayName,
                            timesCompletedThisWeek: 0
                        )
                        challenges.append(newGoal)
                        saveGoals(challenges)
                        dismiss()
                    }
                    .disabled(challengeDescription.isEmpty)
                }
                
                // Seção para desafios sugeridos
                Section(header: Text("Desafios sugeridos")) {
                    ForEach(suggestedChallenges, id: \.description) { challenge in
                        Button(action: {
                            challengeDescription = challenge.description
                            category = challenge.category
                        }) {
                            VStack(alignment: .leading) {
                                Text(challenge.description)
                                Text(challenge.category.displayName)
                                    .font(.system(.footnote))
                            }
                            .padding(4)
                        }
                    }
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

func saveGoals(_ challenges: [Challenge]) {
    let encoder = JSONEncoder()
    if let encodedGoals = try? encoder.encode(challenges) {
        UserDefaults.standard.set(encodedGoals, forKey: "Goals")
    }
}

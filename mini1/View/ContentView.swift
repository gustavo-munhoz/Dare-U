//
//  ContentView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import SwiftUI; import UIKit; import Combine

struct ContentView: View {
    var notificationManager = NotificationManager()
    
    @State var cancellable = Set<AnyCancellable>()
    @State private var showingAddChallengeView = false
    @State private var screenshot: UIImage?
    @State private var isSharing = false
    @State private var isEditing = false
    @State private var isPresentingTutorial = false
    @State private var isPresentingYourDay = false
    @State private var isPresentingPoke = false
    @State private var isPresentingUntilNow = false
    @State private var isPresentingSundayStory = false
    
    @ObservedObject var userData: UserData
    
    private func challengeButton(index: Int) -> some View {
        ChallengeCardView(goal: userData.challenges[index], isEditing: $isEditing) {
            userData.challenges.remove(at: index)
            if userData.challenges.isEmpty {
                isEditing = false
            }
        }
        .onTapGesture {
            if isEditing { return }
            
            if !userData.challenges[index].isComplete && (!Calendar.current.isDateInToday(userData.challenges[index].lastCompletionDate ?? Date()) || userData.challenges[index].lastCompletionDate == nil) {
                userData.challenges[index].timesCompletedThisWeek += 1
                userData.challenges[index].lastCompletionDate = Date()
            } else if userData.challenges[index].isComplete && Calendar.current.isDateInToday(userData.challenges[index].lastCompletionDate ?? Date()) {
                userData.challenges[index].timesCompletedThisWeek -= 1
                userData.challenges[index].lastCompletionDate = nil
            }
            
        
            withAnimation {
                userData.challenges[index].isComplete.toggle()
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
    
    var tutorial: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text("🧩 Tutorial")
                .font(.system(.caption, weight: .medium))
                .foregroundColor(Color("AppGray03Constant"))
            
            VStack(alignment: .leading) {
                Text("Primeiros")
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("AppYellow"), lineWidth: 1).padding(.horizontal, -2).padding(.vertical, 0.8))
                
                HStack {
                    Text("passos")
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("AppYellow"), lineWidth: 1).padding(.horizontal, -2).padding(.vertical, 0.8))
                    Text("para")
                }
                
                Text("compartilhar")
                Text("com o seu amigo")
            }
            .foregroundColor(Color("AppGray03Constant"))
            .font(.subheadline)
            .fontWeight(.semibold)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Circle()
                    .fill(Color("AppGray03Constant"))
                    .frame(width: 40)
                    .overlay {
                        Image(systemName: "questionmark")
                            .foregroundColor(.blue)
                            .font(.system(.subheadline, weight: .semibold))
                    }
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .frame(width: 157, height: 226)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("AppOrange"), Color("AppOrangeDark")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing).cornerRadius(10)
        )
        .overlay {
            Image("tutorial")
        }
    }
    
    var yourDay: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("🌟Seu dia")
                .font(.system(.caption, weight: .medium))
                .foregroundColor(Color("AppGray01"))
                
            Rectangle()
                .fill(Color("AppGreen01"))
                .frame(width: 125, height: 122)
                .clipShape(ThreeCornersShape(cornerRadius: 10, corners: [.bottomRight, .topRight, .bottomLeft]))
                .overlay {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Definindo meus desafios em 3 stickers!")
                            .foregroundColor(Color("AppBlackConstant"))
                            .font(.system(.subheadline, weight: .medium))
                        
                        HStack {
                            Text("12:00")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal, -6)
                            
                            Group {
                                Image(systemName: "checkmark")
                                Image(systemName: "checkmark")
                                    .padding(.horizontal, -14)
                            }.foregroundColor(.blue)
                        }
                        .font(.caption2)
                    }
                    .padding(11)
                }
            HStack {
                Spacer()
                
                Circle()
                    .fill(Color("AppGray03Constant"))
                    .frame(width: 40)
                    .overlay {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                            .font(.system(.subheadline, weight: .semibold))
                    }
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("AppYellow"), Color("AppOrangeLight")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing).cornerRadius(10)
        )
    }
    
    var poke: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("👀 Cutuque")
                .font(.system(.caption, weight: .medium))
                .foregroundColor(Color("AppGray03Constant"))
            
            VStack(alignment: .leading) {
                Text("Frases")

                Text("motivacionais")
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("AppPink"), lineWidth: 1).padding(.horizontal, -2))

                Text("que quem você")

                HStack(alignment: .bottom, spacing: 0) {
                    Text("desafia")
                    Text(" não")
                        .italic()
                }

                Text("aguenta mais")
                    .italic()
            }
            .foregroundColor(Color("AppGray03Constant"))
            .font(.subheadline)
            .fontWeight(.semibold)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Circle()
                    .fill(Color("AppGray03Constant"))
                    .frame(width: 40)
                    .overlay {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                            .font(.system(.subheadline, weight: .semibold))
                    }
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .frame(width: 157, height: 226)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("AppBlue"), Color("AppPurpleLight")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing).cornerRadius(10)
        )
        .overlay {
            Image("cutuque")
        }
    }
    
    var untilnow: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("🔥 Até agora...")
                .font(.system(.caption, weight: .medium))
                .foregroundColor(Color("AppGray03Constant"))
            
            VStack(alignment: .leading) {
                Text("Vendo meus")

                HStack(spacing: 0) {
                    Text("desafios")
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("AppYellow"), lineWidth: 1).padding(.horizontal, -2))

                    Text(" no")
                }

                Text("Dare U")
            }
            .foregroundColor(Color("AppGray03Constant"))
            .font(.subheadline)
            .fontWeight(.semibold)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Circle()
                    .fill(Color("AppGray03Constant"))
                    .frame(width: 40)
                    .overlay {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                            .font(.system(.subheadline, weight: .semibold))
                    }
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .frame(width: 157, height: 226)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("AppPink"), Color("AppPinkDark")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing).cornerRadius(10)
        )
        .overlay {
            Image("ate-agora")
        }
    }
    
    var sharing: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Descubra e compartilhe")
                    .font(.system(.title3, weight: .bold))
                
                Image(systemName: "arrow.right")
                    .font(.system(.title3, weight: .bold))
                    .padding(.horizontal, -4)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button(action: { isPresentingTutorial = true}) {
                        tutorial
                    }
                    
                    Button(action: {isPresentingYourDay = true}) {
                        yourDay
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {isPresentingPoke = true}) {
                        poke
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {isPresentingUntilNow = true}) {
                        untilnow
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .sheet(isPresented: $isPresentingTutorial, content: {
            StoriesView(
                imageName: "imagem_tutorial",
                isPresented: $isPresentingTutorial,
                isSharing: $isSharing,
                userData: userData)
        })
        
        .sheet(isPresented: $isPresentingYourDay) {
            StoriesView(
                imageName: "imagem_seu_dia",
                isPresented:$isPresentingYourDay,
                isSharing: $isSharing,
                userData: userData
            )
        }
        .sheet(isPresented: $isPresentingPoke) {
            StoriesView(
                imageName: "imagem_cutuque",
                isPresented:$isPresentingYourDay,
                isSharing: $isSharing,
                userData: userData
            )
        }
        .sheet(isPresented: $isPresentingUntilNow) {
            StoriesView(
                imageName: "imagem_ate_agora",
                isPresented:$isPresentingYourDay,
                isSharing: $isSharing,
                userData: userData
            )
        }
        .sheet(isPresented: $isPresentingSundayStory) {
            StoriesView(
                imageName: "imagem_domingo",
                isPresented: $isPresentingSundayStory,
                isSharing: $isSharing,
                userData: userData
            )
        }
    }
    
    var challengeList: some View {
        Group {
            if !userData.challenges.isEmpty {
                VStack(spacing: 15) {
                    let listas = userData.challenges.filter { $0.isComplete == false } + userData.challenges.filter { $0.isComplete }
                    
                    ForEach(listas) { challenge in
                        challengeButton(index: userData.challenges.firstIndex(where: { $0 == challenge })!)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 40) {
                    
                    header
                    
                    sharing
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Desafios")
                                .font(.system(.title3, weight: .bold))
                            
                            Spacer()
                            
                            if !userData.challenges.isEmpty {
                                Button(action: {
                                    withAnimation { isEditing.toggle() } }) {
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
                            AddChallengeView2(challenges: $userData.challenges)
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    setChangeDaySubscription()
                }
                
                .padding(.horizontal, 24)
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    func setChangeDaySubscription() {
        notificationManager.$isDiffDay
            .sink { _ in
                for (index, _) in userData.challenges.enumerated() {
                    userData.challenges[index].isComplete = false
                    
                    if Calendar.current.component(.weekday, from: Date()) == 1 {
                        userData.challenges[index].timesCompletedThisWeek = 0
                        isPresentingSundayStory = true
                    } else {
                        isPresentingSundayStory = false
                    }
                }
            }
            .store(in: &cancellable)
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
                            category: category.displayName
                        )
                        challenges.append(newGoal)
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

struct StoriesView: View {
    var imageName: String
    @Binding var isPresented: Bool
    @Binding var isSharing: Bool
    @State var level: Int = 1
    @ObservedObject var userData: UserData

    var body: some View {
        VStack(spacing: 20) {
            Button(action: { isPresented = false }) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color("AppGray02"))
                        .frame(width: 30, height: 30)
                }
            }
            
            Image("\(imageName)_\(level)")
                .resizable()
                .aspectRatio(contentMode: .fit)

            SheetView(showSheetView: $isSharing, view: self)
        }
        .overlay {
            
        }
        .padding(.horizontal, 24)
        .onAppear {
            if imageName == "imagem_domingo" || imageName == "imagem_tutorial" {
                level = 1
            } else {
                level = calculateCompletionLevel()
            }
        }
    }
    
    private func calculateCompletionLevel() -> Int {
        let calendar = Calendar.current
        
        // Pegar o início da semana (domingo)
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        
        print("Start of week: \(startOfWeek!)")
        
        // Para cada desafio, calcular quantas vezes ele poderia ter sido completado
        let totalPossibleCompletions = userData.challenges.reduce(0) { result, challenge in
            let creationDate = challenge.dateOfCreation
            
            // Se o desafio foi criado antes do início desta semana, ignore-o
            if creationDate < startOfWeek! {
                return result
            }
            
            // Se o desafio foi criado durante a semana, ele só poderia ter sido concluído nos dias desde a sua criação
            else {
                let daysSinceCreation = calendar.dateComponents([.day], from: creationDate, to: Date()).day ?? 0
                return result + (daysSinceCreation + 1) // adicionando 1 aqui para considerar o dia da criação
            }
        }


        
        print("Total possible completions: \(totalPossibleCompletions)")
        
        // Para cada desafio, calcular quantas vezes ele foi completado
        let totalCompletions = userData.challenges.reduce(0) { $0 + $1.timesCompletedThisWeek }
        
        print("Total completions: \(totalCompletions)")
        
        // Calcular a porcentagem
        let completionPercentage = totalPossibleCompletions == 0 ? 0 : Double(totalCompletions) / Double(totalPossibleCompletions)
        
        print("Completion percentage: \(completionPercentage)")
        
        if completionPercentage < 0.33 {
            return 1
        } else if completionPercentage < 0.66 {
            return 2
        } else {
            return 3
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userData: UserData())
    }
}

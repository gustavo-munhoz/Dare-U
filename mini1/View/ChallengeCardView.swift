//
//  GoalCardView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 27/06/23.
//

import SwiftUI

struct ChallengeCardView: View {
    var goal: Challenge
    @Binding var isEditing: Bool
    var deleteAction: () -> Void

    var darkFonts: [String] = ["Mente", "Habilidade", "Tecnologia"]
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                // Primeiro HStack para as informações do desafio
                HStack {
                    Circle()
                        .fill(goal.isComplete ? Color("AppGray03") : Color(goal.category))
                        .opacity(goal.isComplete ? 0.5 : 1)
                        .frame(width: 55)
                        .overlay(Image(goal.imageName)
                            .resizable()
                            .frame(width: 34, height: 34))
                        .padding(.trailing, 8)

                    VStack(alignment: .leading) {
                        Text(goal.description)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(!goal.isComplete || darkFonts.contains(goal.category) ? Color("AppBlack") : Color("AppGray03"))
                            .strikethrough(goal.isComplete, color: darkFonts.contains(goal.category) ? Color("AppBlack") : Color("AppGray03"))
                        Text(goal.category == "culinaria" ? "Culinária" : goal.category.capitalized)
                            .font(.footnote)
                            .foregroundColor(!goal.isComplete || darkFonts.contains(goal.category) ? Color(uiColor: .darkGray) : Color("AppGray03"))
                    }

                    Spacer()
                }
                .frame(maxWidth: isEditing ? .infinity : .infinity)
                .padding(16)
                .background(
                    ZStack(alignment: .trailing) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("AppGray03"))
                            .shadow(radius: 5)
                        Rectangle()
                            .fill(Color(goal.category))
                            .frame(maxWidth: goal.isComplete ? .infinity : 12)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                )
                

                // Segundo HStack para o botão de exclusão
                if isEditing {
                    Button(action: deleteAction) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.red)
                    }
                    .padding(.trailing, 5)
                    .frame(width: 50)
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .opacity)
                    
                    )
                }
            }
        }
    }
}

//
//  SelectedChallengeCardView.swift
//  mini1
//
//  Created by Yana Preisler on 30/06/23.
//

import SwiftUI

struct SelectedChallengeCardView: View {
    var goal: Challenge
    var isSelected: Bool
    var deleteAction: () -> Void
    
    var darkFonts: [String] = ["Mente", "Habilidade", "Tecnologia"]
    
    var body: some View {
        
        ZStack {
            HStack(spacing: 0) {
                HStack {
                    Circle()
                        .fill(isSelected ? Color("AppGray02").opacity(0.5) : Color(goal.category))
                        .frame(width: 55)
                        .overlay(Image(goal.imageName)
                            .resizable()
                            .frame(width: 34, height: 34)
                            .opacity(isSelected ? 0.5 : 1)
                        )
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading) {
                        Text(goal.description)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(isSelected ? Color("AppGray02") : Color("AppBlack"))
                        Text(goal.category)
                            .font(.footnote)
                            .foregroundColor(isSelected ? Color("AppGray02") : Color("AppBlack"))
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: isSelected ? .infinity : .infinity)
                .padding(16)
                .background(
                    ZStack(alignment: .trailing) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("AppGray03"))
                            .shadow(radius: 5)
                        Rectangle()
                            .fill(isSelected ? Color("AppGray02").opacity(0.5) : Color(goal.category))
                            .frame(maxWidth: 12)
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                )
            }
        }
    }
}

struct SelectedChallengeCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedChallengeCardView(goal: Challenge(description: "Hidratar o rosto com creme", category: Category.selfcare.displayName, timesCompletedThisWeek: 10), isSelected: true) {}
    }
}

//
//  GoalCardView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 27/06/23.
//

import SwiftUI

struct ChallengeCardView: View {
    var goal: Challenge
    
    
    var body: some View {
        HStack {
            Circle()
                .fill(.yellow)
                .frame(width: 55)
                .overlay(Image(systemName: "square")
                    .resizable()
                    .frame(width: 34, height: 34))
            
            VStack(alignment: .leading) {
                Text(goal.description)
                    .font(.system(size: 15, weight: .semibold))
                Text("diário")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .darkGray))
            }
            
            Spacer()
            
            NavigationLink(destination: ContentView()) {
                Image(systemName: "chevron.right")
            }
            .padding(14)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(goal.isComplete ? .red : .white)
                .shadow(radius: 5)
                .overlay(
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(.red)
                            .frame(width: 12)
                    }
                )
        )
    }
}

struct ChallengeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCardView(goal: Challenge(description: "Hidratar o rosto com creme", category: Category.fitness.displayName))
    }
}

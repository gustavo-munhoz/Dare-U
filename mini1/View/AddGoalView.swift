//
//  AddGoalView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import SwiftUI

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var goals: [Goal]
    
    @State private var goalDescription = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Descrição da Meta", text: $goalDescription)
                
                Button("Adicionar Meta") {
                    let newGoal = Goal(description: goalDescription, isComplete: false)
                    goals.append(newGoal)
                    dismiss()
                }
            }
            .navigationTitle("Adicionar Meta")
        }
    }
}

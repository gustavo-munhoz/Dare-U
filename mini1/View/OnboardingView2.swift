//
//  OnboardingView2.swift
//  mini1
//
//  Created by Yana Preisler on 27/06/23.
//

import SwiftUI

struct OnboardingView2: View {
    @State private var title: String = ""
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                    .foregroundColor(Color("Gray02"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 10))
                    .foregroundColor(Color("Black"))
            }
            
            Spacer()
            
            Text("Crie os desafios")
                .fontDesign(.monospaced)
                .font(.system(size: 34))
                .bold()
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Título")
                    TextField("Título", text: $title)
                }
                HStack {
                    Text("Categoria:")
                    @State var category = Category.fitness
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.displayName).tag(category)
                        }
                    }
                }
            }
            .cornerRadius(10)
            .background(Color("Gray03"))
            
        }
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView2()
    }
}

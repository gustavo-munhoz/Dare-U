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
            .padding()
            .background(Color("Gray03"))
            .cornerRadius(10)
            
            Spacer()
            
            NavigationLink(destination: ContentView()) {
                HStack {
                    Text("pular")
                        .foregroundColor(Color("Black"))
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color("Pink"), lineWidth: 1))
            }
            
            NavigationLink(destination: ContentView()) {
                HStack {
                    Text("próximo")
                        .foregroundColor(.white)
                        .font(.callout)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("Pink"))
                .cornerRadius(10)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView2()
    }
}

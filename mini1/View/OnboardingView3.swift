//
//  OnboardingView.swift
//  mini1
//
//  Created by Gabriel Preisler on 04/07/23.
//

import SwiftUI

struct OnboardingView3: View {
    @ObservedObject var userData = UserData()
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppBlack"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppGray02"))
                Image(systemName: "circle.fill")
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                    .font(.system(size: 8))
                    .foregroundColor(Color("AppGray02"))
            }
            .frame(maxWidth: .infinity)
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(minHeight: 200)
                .padding(.top, 10)
                
            Spacer()
                .frame(minHeight: 20)
            
            Text("Bem-vindo")
                .fontDesign(.monospaced)
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundColor(Color("AppBlack"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundColor(Color("AppGreen01"))
                    .overlay(
                        Image("Amigos")
                            .resizable()
                            .frame(width: 34, height: 34)
                        )
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    
                    Text("Conecte-se com os seus amigos ")
                        .foregroundColor(Color("AppBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("por meio de")
                            .foregroundColor(Color("AppBlack"))
                            
                        Text("desafios semanais!")
                            .bold()
                            .foregroundColor(Color("AppBlack"))
                    }
                }
            }
            .minimumScaleFactor(0.5)
            
            HStack{
                
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundColor(Color("AppOrange"))
                    .overlay(
                        Image("Foquetes")
                            .resizable()
                            .frame(width: 34, height: 34)
                        )
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    
                    Text("Compartilhe experiências e ")
                        .bold()
                        .foregroundColor(Color("AppBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("memórias juntos,")
                            .foregroundColor(Color("AppBlack"))
                        
                        Text("mesmo estando ")
                            .foregroundColor(Color("AppBlack"))
                          
                    }
                    
                Text("separados por quilômetros. ")
                    .foregroundColor(Color("AppBlack"))
                }
            }
            .minimumScaleFactor(0.5)
            
            HStack{
                
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundColor(Color("AppYellow"))
                    .overlay(
                        Image("Estrela")
                            .resizable()
                            .frame(width: 34, height: 34)
                        )
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    
                    Text("Conecte-se com os seus amigos ")
                        .foregroundColor(Color("AppBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("por meio de")
                            .foregroundColor(Color("AppBlack"))
                            
                        Text("desafios semanais!")
                            .bold()
                            .foregroundColor(Color("AppBlack"))
                    }
                }
            }
            .minimumScaleFactor(0.5)
            
            Spacer()
                .frame(minHeight: 20)
            
            NavigationLink(destination:
                OnboardingView(userData: userData)) {
                HStack {
                    Text("próximo")
                        .foregroundColor(.white)
                        .font(.callout)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("AppPink"))
                .cornerRadius(10)
            }
            
        }
        .padding([.horizontal, .bottom], 24)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AppGray03"))
    }
}

struct OnboardingView3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView3(userData: UserData())
    }
}


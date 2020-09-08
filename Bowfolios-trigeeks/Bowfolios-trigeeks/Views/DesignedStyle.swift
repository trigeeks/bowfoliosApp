//
//  DesignedButton.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundColor(Color.black)
           .background(
               ZStack {
                   Color(#colorLiteral(red: 0.786849916, green: 0.8632053137, blue: 1, alpha: 1))
                   RoundedRectangle(cornerRadius: 15, style: .continuous)
                       .foregroundColor(Color.white)
                       .blur(radius: 4)
                       .offset(x: -8, y: -8)
                   RoundedRectangle(cornerRadius: 15, style: .continuous)
                       .fill(
                           LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.843988955, green: 0.9167951345, blue: 0.9955160022, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                   )
                       
                       .blur(radius: 2)
                       .padding(2)
               }
           )
               .overlay(
                   RoundedRectangle(cornerRadius: 15)
                       .stroke(Color.white, lineWidth: 2)
           )
           .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
               .shadow(color: Color(#colorLiteral(red: 0.7972047925, green: 0.8879345059, blue: 0.9982059598, alpha: 1)), radius: 20, x: 20, y: 20)
               .shadow(color: Color.white, radius: 20, x: -20, y: -20)
    }
}

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
        .font(.system(size: 20))
        .padding(20)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15).strokeBorder(Color.black.opacity(0.05), lineWidth: 4)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 5, y: 5)
                .shadow(color: Color.white, radius: 3, x: -5, y: -5)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: -5, y: -5)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        )
    }
    
    
}

struct TestView: View {
    @State var email = ""
    var body: some View {
        VStack {

            Spacer()
            TextField("Email", text: $email).modifier(TextFieldModifier())
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Button").frame(width: 150, height: 60).modifier(ButtonModifier()).frame(maxWidth: .infinity)
            }
            Spacer()
        }.frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.8999916911, green: 0.9301283956, blue: 0.9705904126, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}
struct DesignedButton_Previews: PreviewProvider {
    static var previews: some View {
        
        TestView()
    }
}


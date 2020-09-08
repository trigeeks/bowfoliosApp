//
//  DesignedButton.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI


struct DesignedButton: View {
    var buttonText: String
    var isImage: Bool
    var body: some View {
        VStack {
            
            if isImage {
            Image(systemName: buttonText)
                .font(.system(size: 45)).foregroundColor(Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1))).frame(width: 80, height: 80)
            } else {
            
            Text(buttonText)
                .foregroundColor(Color.black)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 150, height: 60)
            }
                
                
        }
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

struct TestView: View {
    var body: some View {
        VStack {
            Spacer()
            DesignedButton(buttonText: "person", isImage: false)
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


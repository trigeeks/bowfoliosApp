//
//  Modifiers.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/8/20.
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
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15).foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 4)
                            .foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                            .blur(radius: 4)
                            .offset(x: 2, y: 4)
                            .mask(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                        
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 4)
                            .foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                            .blur(radius: 4)
                            .offset(x: -2, y: -3)
                            .mask(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)))

                    )
            )
    }
    
    
}


struct SectionModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 15).foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            )
    }
    
    
}

struct ButtonsModifier: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Group {
                    if configuration.isPressed {
                    RoundedRectangle(cornerRadius: 15).fill(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: -5)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: 5, y: 5)
                    } else {
                        RoundedRectangle(cornerRadius: 15).fill(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }
}


struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)), lineWidth: 4)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: -5, y: -5)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: 5, y: 5)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(#colorLiteral(red: 0.9358322024, green: 0.9386646152, blue: 0.9737249017, alpha: 1)), lineWidth: 4)
                    }
                }
            )
    }
}

struct RoundButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                Group {
                    if configuration
                        .isPressed {
                        Circle().fill(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: -5)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: 5, y: 5)
                    } else {
                        Circle().fill(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }
}

struct LongButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                Group {
                    if configuration.isPressed {
                    RoundedRectangle(cornerRadius: 15).fill(Color(#colorLiteral(red: 0.4437265396, green: 0.6356848478, blue: 1, alpha: 0.5364137414)))
                        .shadow(color: Color(#colorLiteral(red: 0.3474860191, green: 0.4888443947, blue: 0.8093919754, alpha: 1)), radius: 5, x: 0, y: 0)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: 5, y: 5)
                    } else {
                        RoundedRectangle(cornerRadius: 15).foregroundColor(Color(#colorLiteral(red: 0.4437265396, green: 0.6356848478, blue: 1, alpha: 0.5364137414)))
                            .shadow(color: Color(#colorLiteral(red: 0.3474860191, green: 0.4888443947, blue: 0.8093919754, alpha: 1)), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }


}

struct TestView: View {
    @State var email = ""
    @State var isExpand = false
    var body: some View {
        VStack {

            Spacer()
            TextField("Email", text: $email).modifier(TextFieldModifier())
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Button").frame(width: 150, height: 60).modifier(ButtonModifier()).frame(maxWidth: .infinity)
            }
            
            
            
            Button(action: {
                self.isExpand.toggle()
            }) {
                Image(systemName: "person.fill").resizable().foregroundColor(Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)))
                    .frame(width: 60, height: 60)
                    .cornerRadius(50)
            }.buttonStyle(RoundButtonStyle())
            
            
            
            
            Spacer()
        }.frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}
struct DesignedButton_Previews: PreviewProvider {
    static var previews: some View {
        
        TestView()
    }
}

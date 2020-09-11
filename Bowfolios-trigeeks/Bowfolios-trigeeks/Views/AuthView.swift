//
//  AuthView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        print("here")
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                
            } else {
                self.email = ""
                self.password = ""
            }
        }
        
    }
    
    var body: some View {
        VStack{
            VStack {
                
                VStack {
                Text("Welcome back!")
                    .font(.system(size: 32, weight: .heavy))
                    
                
                Text("Sign in to continue")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
                    
                    }.cornerRadius(15)
                .padding()

                
                VStack{

                        TextField("Email address", text: $email)
                            .modifier(TextFieldModifier())
                    
                    
                    SecureField("Password", text: $password).modifier(TextFieldModifier())
                    
                }.padding(.vertical, 70)
                
                Button(action: signIn){
                    Text("Sign In")
                        .frame(width: UIScreen.main.bounds.width*0.9, height: 70)
                        .modifier(ButtonModifier())
                }//.frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(width: UIScreen.main.bounds.width - 30 , height: 500)
            //.background(Color.white.opacity(0.5))
            .cornerRadius(25)
                .offset(y: UIScreen.main.bounds.height / 7)
            Spacer()
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
                
                
            }
            
            Spacer()
            
            NavigationLink (destination: SignUpView()){
                HStack{
                    Text("Don't have an account?")
                        .font(.system(size: 14, weight:.light))
                        .foregroundColor(.primary)
                    Text("Create an account")
                        .font(.system(size: 14,weight: .bold))
                }
                
            }
            Spacer()
            
        }.padding(.horizontal, 32)
        .background(Color(#colorLiteral(red: 0.8999916911, green: 0.9301283956, blue: 0.9705904126, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var rePassword: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signUp(){
        if rePassword != password {
            error = "Your passwords don't match"
        } else {
            session.signUp(email: email, password: password) { (result, error) in
                if let error = error {
                    self.error = error.localizedDescription
                } else {
                    self.email = ""
                    self.password = ""
                }
            }
        }
    }
    var body: some View {
        VStack{
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign Up to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            VStack{
                TextField("Email address", text: $email)
                    .modifier(TextFieldModifier())
                    
                
                SecureField("Password", text: $password)
                    .modifier(TextFieldModifier())
                
                SecureField("Re-Enter Password", text: $rePassword)
                .modifier(TextFieldModifier())
                    
            }.padding(.vertical, 70)
            
            Button(action: signUp){
                Text("Sign Up")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 70)
                .modifier(ButtonModifier())
            }
            
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
                
                
            }
            
            Spacer()
            
            
        }.padding(.horizontal, 32)
            .padding(.vertical, 50)
        .background(Color(#colorLiteral(red: 0.8999916911, green: 0.9301283956, blue: 0.9705904126, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
    }
}




struct AuthView: View {
    
    @State var index: Int = 0
    var body: some View {
        NavigationView{

            VStack(spacing: 20) {
                Spacer()
                
                // Logo image
                Image("logo")
                
                
                
                // MARK: -Descriptions and button
                VStack {
                    Text("Welcome To Bowfolios")
                        .font(.largeTitle).fontWeight(.heavy).multilineTextAlignment(.center)
                    Text("Profiles, projects, and interest areas for the UH Community")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }.padding()
                
                // Button go to SignInView
                NavigationLink(destination: SignInView()) {
                    Text("GET START").fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.00619146321, green: 0.4578815103, blue: 0.1789277494, alpha: 1)))
                        .cornerRadius(10)
                }.padding()
                Spacer()
            }.frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(
                    ZStack{
                        Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8937863708, green: 0.9039856791, blue: 0.9527032971, alpha: 1))).edgesIgnoringSafeArea(.all)
                        Rectangle().foregroundColor(Color.white).edgesIgnoringSafeArea(.all).rotationEffect(Angle(degrees: 80)).offset(x: 0, y: -80)
                    }
            )
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

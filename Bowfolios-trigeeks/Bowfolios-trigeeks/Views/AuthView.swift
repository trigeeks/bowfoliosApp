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
            Text("Welcome back!")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign in to continue")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            VStack{
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.black), lineWidth: 1))
                    
                
                SecureField("Password", text: $password).font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.black), lineWidth: 1))
                    
            }.padding(.vertical, 70)
            
            Button(action: signIn){
                Text("Sign In")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
            }
            
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
            
        }.padding(.horizontal, 32)
        
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signUp(){
        session.signUp(email: email, password: password) { (result, error) in
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
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign Up to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            VStack{
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.black), lineWidth: 1))
                    
                
                SecureField("Password", text: $password).font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.black), lineWidth: 1))
                    
            }.padding(.vertical, 70)
            
            Button(action: signUp){
                Text("Sign Up")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
            }
            
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
                
                
            }
            
            Spacer()
            
            
        }.padding(.horizontal, 32)
    }
}

struct AuthView: View {
    
    var body: some View {
        NavigationView{
            
            VStack {
                Image("logo")
                NavigationLink(destination: SignInView()) {
                    Text("SIGN IN")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.green)
                }
            }
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

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
    
    // array that store views
    // put into Pagesview
    // TODO: this should be change to actuall picture of our app by changing the assets images
    let views = [ AnyView( // first view
        ZStack {
            HStack {
                Image("editProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("profileView")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
            Text("  Making your profile  ").fontWeight(.semibold).font(.system(size: 38)).background(Color.black.opacity(0.3)).rotationEffect(Angle(degrees: 20)).foregroundColor(.white)
    }),
                  AnyView( // second view
                    ZStack {
                        HStack {
                            Image("interestView")
                                .resizable().aspectRatio(contentMode: .fit)
                            Image("filterView")
                                .resizable().aspectRatio(contentMode: .fit)
                        }
                        Text("  Adding your projects  ").fontWeight(.semibold).font(.system(size: 38)).background(Color.black.opacity(0.3)).rotationEffect(Angle(degrees: -20)).foregroundColor(.white)
                  }),
                  AnyView(
                    ZStack {
                        HStack {
                            Image("addProject")
                                .resizable().aspectRatio(contentMode: .fit)
                            Image("editProfile")
                                .resizable().aspectRatio(contentMode: .fit)
                        }
                        Text("connect to people with shared interests!").fontWeight(.semibold).font(.system(size: 38)).multilineTextAlignment(.center).background(Color.black.opacity(0.3)).foregroundColor(.white)
                  }) ]
    
    
    var body: some View {
        NavigationView{

            VStack(spacing: 20) {
                Spacer()
                
                // Logo image
                Image("logo")
                
                // PresentView that can scroll
                PagesView(views).frame(height: 250)
                
                // Title
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
        AuthView()
    }
}

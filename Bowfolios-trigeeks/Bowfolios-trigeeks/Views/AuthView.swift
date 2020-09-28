//
//  AuthView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

var TextColor = Color("bg1")
struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var isVisiable = false
    @State var showAlert = false
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        print("here")
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                self.showAlert = true
                
            } else {
                self.email = ""
                self.password = ""
            }
        }
        
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Spacer()
                    Text("Welcome To Bowfolios!")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .foregroundColor(TextColor)
                        .multilineTextAlignment(.trailing)
                        .padding(.top, 40)
                        .padding(.leading, 6)
                        .frame(width: UIScreen.main.bounds.width*3/4)
                    
                }

                
                VStack {
                    
                    // Log in Information field
                    VStack(alignment: .leading) {
                        
                        // email text filed
                        Text("Email")
                            .fontWeight(.semibold)
                            .font(.title)
                            .foregroundColor(TextColor)
                        
                        TextField("Enter Your Email", text: $email)
                            .keyboardType(.emailAddress)
                            .modifier(TextFieldModifier())
                            
                            
                            
                        // password text field
                        Text("Password")
                            .fontWeight(.semibold)
                            .font(.title)
                            .foregroundColor(TextColor)
                        
                        HStack {
                            
                            if isVisiable {
                            TextField("Enter Your Password", text: $password)
                                .modifier(TextFieldModifier())
                            } else {
                                SecureField("Enter Your Password", text: $password)
                                    .padding(1)
                                    .modifier(TextFieldModifier())
                            }
                            
                            // change visiable password button
                            Button(action: {
                                self.isVisiable.toggle()
                            }, label: {
                                Image(systemName: "eye.fill").foregroundColor(.gray)
                                    
                            }).buttonStyle(ButtonsModifier())
                            
                            

                        }
                        
                        
                        
                    }.padding(20)
                    
                    
                    // Button log in
                    VStack {
                        Button(action: {signIn()}, label: {
                            Text("Login")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                        })
                        .buttonStyle(LongButtonStyle())

                    }.padding()
                }.background(
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 8, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
                )
                .padding(30)
                
                Spacer()
                
                // go to signup section
                
                    HStack {
                        Text("Do not have an account?")
                            .fontWeight(.semibold)
                            .foregroundColor(TextColor)
                    NavigationLink (destination: SignUpView()) {
                        Text("Register").fontWeight(.semibold)
                            .foregroundColor(TextColor)
                    }.buttonStyle(ButtonsModifier())
                    }.padding(30)
                    .modifier(SectionModifier())
                
                
                Spacer()
                
                
            }.background(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
            .ignoresSafeArea(.all)
            if showAlert {
                AlertView(showAlert: $showAlert, alertMessage: $error).transition(.slide)
            }
        }
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var rePassword: String = ""
    @State var isVisiable = false
    @State var showAlert = false
    @EnvironmentObject var session: SessionStore
    
    func signUp(){
        if rePassword != password {
            error = "Your passwords don't match"
            showAlert = true
        } else {
            session.signUp(email: email, password: password) { (result, error) in
                if let error = error {
                    self.error = error.localizedDescription
                    showAlert = true
                } else {
                    self.email = ""
                    self.password = ""
                }
            }
        }
    }
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                    Text("Create Account")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(TextColor)
                    
                    Text("Sign Up to get started")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                    }
                }.padding(.bottom, 20)
                VStack {
                VStack{
                    VStack(alignment: .leading) {
                        
                        // email text filed
                        Text("Email")
                            .fontWeight(.semibold)
                            .font(.title)
                            .foregroundColor(TextColor)
                        TextField("Email address", text: $email)
                            .keyboardType(.emailAddress)
                            .modifier(TextFieldModifier())
                    }
                        
                    

                    VStack(alignment: .leading) {
                        
                        // Password text filed
                        Text("Password")
                            .fontWeight(.semibold)
                            .font(.title)
                            .foregroundColor(TextColor)
                        HStack {
                            
                            if isVisiable {
                            TextField("Enter Your Password", text: $password)
                                .modifier(TextFieldModifier())
                            } else {
                                SecureField("Enter Your Password", text: $password)
                                    .padding(1)
                                    .modifier(TextFieldModifier())
                            }
                            
                            // change visiable password button
                            Button(action: {
                                self.isVisiable.toggle()
                            }, label: {
                                Image(systemName: "eye.fill").foregroundColor(.gray)
                                    
                            }).buttonStyle(ButtonsModifier())
                            
                            

                        }
                    }

                    
                    TextField("Re-Enter Password", text: $rePassword)
                    .modifier(TextFieldModifier())
                        
                }.padding()
                
                Button(action: signUp){
                    Text("Sign Up").fontWeight(.semibold)
                        .font(.title2)
                        .foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                }.padding().buttonStyle(LongButtonStyle())
                }.background(
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 8, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
                )
                
                Spacer()
                
                
            }.padding(.horizontal, 32)
                .padding(.vertical, 50)
            .background(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
            
            if showAlert {
                AlertView(showAlert: $showAlert, alertMessage: $error).transition(.flipFromTop)
            }
        }

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


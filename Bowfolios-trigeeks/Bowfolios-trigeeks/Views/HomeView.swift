//
//  HomeView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import Pages


struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var projects = ProjectViewModel()
    @ObservedObject var profiles = ProfileViewModel()
    @State var selected = 0
    @State var isExpand = false
    @State var editView: Bool = false
    @State var showAddProject = false
    @State var showSheet = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                // MARK: -Navigation Menu
                VStack(spacing: 20) {
                    HStack {
                        Text("Bowfolios").font(.system(size: 26)).fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)))
                        Spacer()
                        
                        
                        // profile button
                        VStack {
                            Button(action: {
                                self.isExpand.toggle()
                            }) {
                                Image(systemName: "person").font(.system(size: 30)).foregroundColor(Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)))
                                    .frame(width: 50, height: 50).modifier(ButtonModifier())
                            }
                        }
                    }
                    
                    
                    // Four navigation menu button
                    HStack{
                        Button(action: {
                            self.selected = 0
                        }) {
                            Text("Profiles").fontWeight(.semibold).foregroundColor(
                                self.selected == 0 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        }
                        Spacer()
                        Button(action: {
                            self.selected = 1
                        }) {
                            Text("Projects").fontWeight(.semibold).foregroundColor(self.selected == 1 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        }
                        Spacer()
                        Button(action: {
                            self.selected = 2
                        }) {
                            Text("Interests").fontWeight(.semibold).foregroundColor(self.selected == 2 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        }
                        Spacer()
                        Button(action: {
                            self.selected = 3
                        }) {
                            Text("Filter").fontWeight(.semibold).foregroundColor(self.selected == 3 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        }
                        
                    }
                    
                }.padding()
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
                    .background(
                        ZStack {
                            Color(#colorLiteral(red: 0.786849916, green: 0.8632053137, blue: 1, alpha: 1))
                            RoundedRectangle(cornerRadius: 0, style: .continuous)
                                .foregroundColor(Color.white)
                                .blur(radius: 4)
                                .offset(x: -8, y: -8)
                            RoundedRectangle(cornerRadius: 0, style: .continuous)
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
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.7972047925, green: 0.8879345059, blue: 0.9982059598, alpha: 1)), radius: 20, x: 20, y: 20)
                    .shadow(color: Color.white, radius: 20, x: -20, y: -20)
                
                
                // MARK: - Main Pages View
                MainView(selected: $selected)

            }.edgesIgnoringSafeArea(.all)
            
            if isExpand {
                ZStack {
                    Rectangle().foregroundColor(Color.white.opacity(0.01)).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isExpand = false
                    }
                    VStack(spacing: 30) {
                        Button(action: {
                            withAnimation {
                                self.editView = true
                                self.showSheet = true
                                self.isExpand.toggle()
                            }
                        }) {
                            Text("My Profile").frame(width: 150, height: 60).modifier(ButtonModifier())
                            }.animation(.interpolatingSpring(mass: 0.5, stiffness: 90, damping: 10, initialVelocity: 0))
                            
                            
                        
                        Button(action: {
                            self.showAddProject = true
                            self.showSheet = true
                            self.isExpand.toggle()
                        }) {
                             Text("Add Project").frame(width: 150, height: 60).modifier(ButtonModifier())
                        }.animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 4))
                        
                        Button(action: {
                            self.session.signOut()
                        }) {
                            Text("Log Out").frame(width: 150, height: 60).modifier(ButtonModifier())
                        }.animation(.interpolatingSpring(mass: 1.5, stiffness: 100, damping: 10, initialVelocity: 0))
                    }.offset(x: UIScreen.main.bounds.width/4, y: -UIScreen.main.bounds.height * 0.2)
                        
                }.transition(.move(edge: .trailing))
            }
        } // end of ZStack
            .onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
        }
        .sheet(isPresented: $showSheet, content:{
            if self.editView {
                EditProfileView(editView: self.$editView, showSheet: self.$showSheet).environmentObject(self.session)
            } else if self.showAddProject {
                AddProjectView(showAddProject: self.$showSheet, showSheet: self.$showSheet)
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// MARK: -Main Content View

struct MainView: View {
    @Binding var selected: Int
    var body: some View {
        
        Pages(currentPage: $selected, navigationOrientation: .horizontal, transitionStyle: .scroll, hasControl: false) { () -> [AnyView] in
            
            ProfileView()  //profile
            ProjectView()  //project
            TestView()  //interest
            FilterView()  //filter
            
        }
    }
}

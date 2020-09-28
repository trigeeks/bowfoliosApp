//
//  HomeView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore
import FirebaseAuth


struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profiles: ProfileViewModel
    @EnvironmentObject var projects: ProjectViewModel
    @State var selected = 0
    @State var isExpand = false
    @State var editView: Bool = false
    @State var showAddProject = false
    @State var showSheet = false
    @State var forceReload = false // this var does nothing but forces a reload
    
    @State var showedProfile = Profile(firstName: "", lastName: "", bio: "", email: "", title: "", projects: [], interests: [], picture: "")
    @State var isOpenProfile = false
    @State var showedProject = Project(name: "", description: "", picture: "", homepage: "", interests: [])
    @State var isOpenProject = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                TopBar(isExpand: $isExpand, selected: $selected)
                
                
                // MARK: - Main Pages View
                MainView(selected: $selected, forceReload: self.$forceReload, showedProfile: $showedProfile, isOpenProfile: $isOpenProfile, showedProject: $showedProject, isOpenProject: $isOpenProject)
                
            }.edgesIgnoringSafeArea(.all)

            
            if isExpand {
                ZStack {
                    Rectangle().foregroundColor(Color.white.opacity(0.01)).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isExpand = false
                    }
                    VStack(spacing: 20) {
                        Button(action: {
                            withAnimation {
                                self.editView = true
                                self.showSheet = true
                                self.isExpand.toggle()
                            }
                        }) {
                            Text("My Profile").fontWeight(.semibold).frame(width: 100)
                        }.buttonStyle(ButtonsModifier())
                        .animation(.interpolatingSpring(mass: 0.5, stiffness: 90, damping: 10, initialVelocity: 0))
                        
                        
                        
                        Button(action: {
                            self.showAddProject = true
                            self.showSheet = true
                            self.isExpand.toggle()
                        }) {
                            Text("Add Project").fontWeight(.semibold).frame(width: 100)
                        }.buttonStyle(ButtonsModifier())
                        .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 4))
                        
                        Button(action: {
                            self.session.signOut()
                        }) {
                            Text("Log Out").fontWeight(.semibold).frame(width: 100)
                        }.buttonStyle(ButtonsModifier())
                        .animation(.interpolatingSpring(mass: 1.5, stiffness: 100, damping: 10, initialVelocity: 0))
                    }.offset(x: UIScreen.main.bounds.width/4, y: -UIScreen.main.bounds.height * 0.2)
                    
                }.transition(.move(edge: .trailing))
            }
            
            if isOpenProfile {
                BrowseProfileView(showedProfile: showedProfile, isShowTappedProfile: $isOpenProfile)
            }
            if isOpenProject {
                BrowseProjectView(project: showedProject, isShowTappedProject: $isOpenProject)
            }
        }
        .fullScreenCover(isPresented: $showSheet, content:{
            if self.editView {
                EditProfileView(editView: self.$editView, showSheet: self.$showSheet, forceReload: self.$forceReload).environmentObject(self.session)
            } else if self.showAddProject {
                AddProjectView(showAddProject: self.$showSheet, showSheet: self.$showSheet, forceReload: self.$forceReload)
            }
        })
        .onAppear {
            self.profiles.fetchData()
            self.projects.fetchData()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
// MARK: -Navigation Menu
struct TopBar: View {
    @Binding var isExpand: Bool
    @Binding var selected: Int
    @State var userImage = ""
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
//                Text("Bowfolios").font(.system(size: 26)).fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)))
                Image("bowfolio").resizable().frame(width: UIScreen.main.bounds.width / 2, height:  UIScreen.main.bounds.width / 12)
                Spacer()
                
                
                // profile button
                VStack {
                    Button(action: {
                        self.isExpand.toggle()
                    }) {
                        Image(systemName: "person").font(.system(size: 30)).foregroundColor(Color.black)
                            .frame(width: 50, height: 50).cornerRadius(50)
                    }.buttonStyle(RoundButtonStyle())
                }
            }
            
            
            // Four navigation menu button
            HStack{
                Button(action: {
                    self.selected = 0
                }) {
                    Text("Profiles").fontWeight(.semibold).foregroundColor(
                        self.selected == 0 ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                }
                Spacer()
                Button(action: {
                    self.selected = 1
                }) {
                    Text("Projects").fontWeight(.semibold).foregroundColor(self.selected == 1 ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                }
                Spacer()
                Button(action: {
                    self.selected = 2
                }) {
                    Text("Interests").fontWeight(.semibold).foregroundColor(self.selected == 2 ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                }
                Spacer()
                Button(action: {
                    self.selected = 3
                }) {
                    Text("Filter").fontWeight(.semibold).foregroundColor(self.selected == 3 ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                }
                
            }
            
        }.padding(.horizontal)
        .padding(.bottom)
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
        .background(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
        .onAppear(perform: getUserImage)
    }
    
    func getUserImage(){
        let db = Firestore.firestore()
        let userEmail : String = (Auth.auth().currentUser?.email)!
        
        let doc = db.collection("profiles").document(userEmail)
        doc.getDocument { (document, err) in
            if let document = document, document.exists {
                
                //document is found
                let profile = try! document.data(as: Profile.self)
                
                //fetching data and display into Textfields
                self.userImage = profile!.picture

            } else {
                print("Document does not exist, it will create a new document for user")
            }
        }
    }
}

// MARK: -Main Content View

struct MainView: View {
    @Binding var selected: Int
    @Binding var forceReload: Bool
    @Binding var showedProfile: Profile
    @Binding var isOpenProfile: Bool
    @Binding var showedProject: Project
    @Binding var isOpenProject: Bool
    var body: some View {
        
        ZStack {
            Pages(currentPage: $selected, forceReload: $forceReload, hasControl: false) { () -> [AnyView] in
                
                ProfileView(forceReload: self.$forceReload, showedProject: $showedProject, isOpenProject: $isOpenProject)
                    .environmentObject(ProjectViewModel()).environmentObject(ProfileViewModel())
                
                ProjectView(forceReload: self.$forceReload, showedProfile: $showedProfile, isOpenProfile: $isOpenProfile)
                    .environmentObject(ProjectViewModel()).environmentObject(ProfileViewModel())
                
                InterestView(showedProfile: $showedProfile, isOpenProfile: $isOpenProfile, showedProject: $showedProject, isOpenProject: $isOpenProject)
                    .environmentObject(ProfileViewModel()).environmentObject(ProjectViewModel())
                
                FilterView(showedProject: $showedProject, isOpenProject: $isOpenProject).environmentObject(ProjectViewModel()).environmentObject(ProfileViewModel())
            }
            
            
        }

    }
}



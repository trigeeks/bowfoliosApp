//
//  ContentView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/6/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
    func getUser(){
        session.listen()
        
    }
    
    var body: some View {
        
        Group{
            //judging the current user State with Firebase Auth
            if session.session != nil {
                
                //user already logged in
               
                    HomeView()
              
            }
            else {
                // no available loggin state
                AuthView()
                
            }
        }.onAppear {
            self.getUser()
            self.profiles.fetchData()
            self.projects.fetchData()

        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore()).environmentObject(ProfileViewModel()).environmentObject(ProfileViewModel())
    }
}

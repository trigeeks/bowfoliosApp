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
        }.onAppear(perform: getUser)
      
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

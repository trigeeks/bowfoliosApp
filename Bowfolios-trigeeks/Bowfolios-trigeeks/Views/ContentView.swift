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
    @State private var showView = false
    @State private var angle: Double = 360
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 1
    
    func getUser(){
        session.listen()
        
    }
    
    var body: some View {
        
        //
        Group{
            if showView {
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
                    
                }
            } else {
                ZStack{
                    Color("bg6").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Image("icon").rotation3DEffect(
                        .degrees(angle),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    ).opacity(opacity).scaleEffect(scale)
                }
            }
        }.onAppear{
            withAnimation(.linear(duration: 2)){
                angle = 0
                scale = 3
                opacity = 0
            }
            withAnimation(Animation.linear.delay(1.75)){
                showView = true
            }
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore()).environmentObject(ProfileViewModel()).environmentObject(ProfileViewModel())
    }
}

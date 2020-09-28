//
//  ProfileView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    @Binding var forceReload: Bool
    @Binding var showedProject: Project
    @Binding var isOpenProject: Bool
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack{
                    ForEach(self.profiles.profiles) { profile in
                        ProfileRowView(profile: profile, showedProject: $showedProject, isOpenProject: $isOpenProject).padding(.horizontal)
                        Spacer().frame(height: 12).background(Color("bg5"))
                    }
                }
                .onAppear {
                    self.profiles.fetchData()
                    self.projects.fetchData()
                }
            }

        }
    }
    
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(forceReload: .constant(false))
//    }
//}

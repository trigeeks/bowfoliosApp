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
    @State var showedProject: Project = Project(name: "", description: "", picture: "", homepage: "", interests: [])
    @State var isShowTapedProject: Bool = false
    @Binding var forceReload: Bool
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack{
                    ForEach(self.profiles.profiles) { profile in
                        ProfileRowView(profile: profile, showedProject: $showedProject, isShowTapedProject: $isShowTapedProject).padding(.horizontal)
                        Spacer().frame(height: 12).background(Color("bg5"))
                    }
                }
                .onAppear {
                    self.profiles.fetchData()
                    self.projects.fetchData()
                }
            }
            if isShowTapedProject {
                BrowseProjectView(project: showedProject, isShowed: $isShowTapedProject)
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(forceReload: .constant(false))
    }
}

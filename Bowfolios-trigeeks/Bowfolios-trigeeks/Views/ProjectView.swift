//
//  ProjectsView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    @State var showedProfile: Profile = Profile(firstName: "", lastName: "", bio: "", email: "", title: "", projects: [], interests: [], picture: "")
    @State var isShowTapedProfile: Bool = false
    @Binding var forceReload: Bool
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack{
                    ForEach(self.projects.projects) { project in
                        ProjectRowView(project: project, showedProfile: $showedProfile, isShowTapedProfile: $isShowTapedProfile).padding(.horizontal)
                        Spacer().frame(height: 12).background(Color("bg5"))
                    }
                }
                .onAppear {
                    self.profiles.fetchData()
                    self.projects.fetchData()
                }
            }
            if isShowTapedProfile {
                BrowseProfileView(profile: showedProfile, isShowed: $isShowTapedProfile)
            }
        }
    }
}



struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(forceReload: .constant(false)).environmentObject(ProjectViewModel()).environmentObject(ProfileViewModel())
    }
}

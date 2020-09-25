//
//  InterestView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct InterestView: View {
   
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
    @State var showedProfile: Profile = Profile(firstName: "", lastName: "", bio: "", email: "", title: "", projects: [], interests: [], picture: "")
    @State var showedProject: Project = Project(name: "", description: "", picture: "", homepage: "", interests: [])
    @State var isShowTapedProfile: Bool = false
    @State var isShowTapedProject: Bool = false
    @State var interestsArray = InterestsArray().interestsArray
    var body: some View {
        ZStack {
            VStack{
            List{
                ForEach(self.interestsArray, id: \.self){ sec in
                    InterestRowView(theInterest: sec, showedProfile: $showedProfile, showTapedProfile: $isShowTapedProfile, showedProject: $showedProject, showTapedProject: $isShowTapedProject)
                }
                
            }
                
               
            
            }.onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
        }
            
            if isShowTapedProfile {
                BrowseProfileView(profile: showedProfile, isShowed: $isShowTapedProfile)
            }
            if isShowTapedProject {
                BrowseProjectView(project: showedProject, isShowed: $isShowTapedProject)
            }
        }
    }
    
}




struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}

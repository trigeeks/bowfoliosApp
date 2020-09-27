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
    @State var isShowTappedProfile: Bool = false
    @State var isShowTappedProject: Bool = false
    @State var interestsArray = InterestsArray().interestsArray
    
    var body: some View {
        ZStack {
            ScrollView{
            LazyVStack{
            
                ForEach(self.interestsArray, id: \.self){ sec in
                    InterestRowView(theInterest: sec, showedProfile: $showedProfile, showTapedProfile: $isShowTappedProfile, showedProject: $showedProject, showTapedProject: $isShowTappedProject)
                }.padding(.bottom)
                
            
            }.onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
            }
            .padding(.horizontal)
            }
            if isShowTappedProfile {
                BrowseProfileView(profile: showedProfile, isShowed: $isShowTappedProfile)
            }
            if isShowTappedProject {
                BrowseProjectView(project: showedProject, isShowed: $isShowTappedProject)
            }
        }
    }
    
}




struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}

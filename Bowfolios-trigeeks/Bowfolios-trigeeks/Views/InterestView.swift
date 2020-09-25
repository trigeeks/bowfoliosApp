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
    @State var isShowTapedProfile: Bool = false
    @State var interestsArray = InterestsArray().interestsArray
    var body: some View {
        ZStack {
            VStack{
            List{
                ForEach(self.interestsArray, id: \.self){ sec in
                    InterestRowView(theInterest: sec, showedProfile: $showedProfile, showTapedProfile: $isShowTapedProfile)
                }
                
            }
                
               
            
            }.onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
        }
            
            if isShowTapedProfile {
                BrowseProfileView(profile: showedProfile, isShowed: $isShowTapedProfile)
            }
        }
    }
    
}




struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}

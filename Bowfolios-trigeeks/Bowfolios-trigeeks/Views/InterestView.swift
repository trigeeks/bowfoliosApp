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
    @Binding var showedProfile: Profile
    @Binding var isOpenProfile: Bool
    @Binding var showedProject: Project
    @Binding var isOpenProject: Bool
    
    @State var interestsArray = InterestsArray().interestsArray
    
    var body: some View {
        ZStack {
            ScrollView{
            LazyVStack{
            
                ForEach(self.interestsArray, id: \.self){ sec in
                    InterestRowView(theInterest: sec, showedProfile: $showedProfile, isOpenProfile: $isOpenProfile, showedProject: $showedProject, isOpenProject: $isOpenProject)
                }.padding(.bottom)
                
            
            }.onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
            }
            .padding(.horizontal)
            }
        }
    }
    
}

//struct InterestView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestView()
//    }
//}

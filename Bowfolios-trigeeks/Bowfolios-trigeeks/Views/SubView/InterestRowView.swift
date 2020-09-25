//
//  InterestRowView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

struct InterestRowView: View {
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
    @State var theInterest: String
    @State var thePics: [String] = []
    @Binding var showedProfile: Profile
    @Binding var showTapedProfile: Bool
    
    var body: some View {
        VStack{
            Text(theInterest).fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false){
                
            HStack{
                
                ForEach(self.profiles.profiles){ prof in
                    if prof.interests.contains(self.theInterest){
                        WebImage(url: URL(string: prof.picture))
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width:50, height: 50)
                            .clipShape(Circle())
                            .onTapGesture {
                                    self.showedProfile = prof
                                    self.showTapedProfile = true 
                            }
                            
                    }
                }
                
                ForEach(self.projects.projects){ proj in
                if proj.interests.contains(self.theInterest){
                    WebImage(url: URL(string: proj.picture)).renderingMode(.original).resizable().scaledToFit().frame(width:50, height: 50).clipShape(Circle())
                }
                }
                
            }.padding(.horizontal)
            }
        }.onAppear {
            self.profiles.fetchData()
            self.projects.fetchData()
           
        }
    }

}

//struct InterestRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestRowView(theInterest: "lala", thePics: ["sas"])
//    }
//}

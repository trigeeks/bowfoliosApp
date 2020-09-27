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
    @Binding var showedProject: Project
    @Binding var showTapedProject: Bool
    
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
                                .frame(width:50, height: 50)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.showedProfile = prof
                                    self.showTapedProfile = true 
                                }
                                .modifier(SmallImageModifier())
                            
                        }
                    }
                    
                    ForEach(self.projects.projects){ proj in
                        if proj.interests.contains(self.theInterest){
                            WebImage(url: URL(string: proj.picture))
                                .renderingMode(.original)
                                .resizable()
                                .frame(width:50, height: 50)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.showedProject = proj
                                    self.showTapedProject = true
                                }
                                .modifier(SmallImageModifier())
                        }
                    }
                    
                }.padding(.all)
            }
        }.onAppear {
            self.profiles.fetchData()
            self.projects.fetchData()
        }
        .background(
            RoundedRectangle(cornerRadius: 25).fill(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 10, y: 2)
        )
    }
    
}

//struct InterestRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestRowView(theInterest: "lala", thePics: ["sas"])
//    }
//}

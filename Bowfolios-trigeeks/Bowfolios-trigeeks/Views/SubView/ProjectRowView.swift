//
//  ProjectRowView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProjectRowView: View {
    @State var project: Project
    @EnvironmentObject var profiles: ProfileViewModel
    
    // filter the profileData to get profiles that in the given project
    func getParticipants(project: String) -> [String] {
        
        var participants: [String] = []
        for profile in profiles.profiles {
            if profile.projects.contains(project) {
                
                participants.append(profile.picture)
            }
        }
        print(participants)
        return participants
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                WebImage(url: URL(string: self.project.picture)).renderingMode(.original)
                    .resizable()
                    .cornerRadius(50)
                    .frame(width: 60, height:60)
                Text(self.project.name)
                    .font(.system(size: 20, weight: .bold))
            }
            
            Text(self.project.description)
                .fixedSize(horizontal: false, vertical: true)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(self.project.interests, id: \.self) {interest in
                        Text("  \(interest)  ")
                            
                            .fontWeight(.semibold)
                            .padding(5)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("bg2"), Color("bg1")]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                            
                        
                    }
                }
            }
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(getParticipants(project: project.name) , id: \.self) { participant in
                        
                        WebImage(url: URL(string: participant ))
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(50)
                        
                    }
                }
            }
            
            
            
        }
    }
}


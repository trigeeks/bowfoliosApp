//
//  ProfileRowView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


struct ProfileRowView: View {
    @State var profile: Profile
    @EnvironmentObject var projects: ProjectViewModel
    @Binding var showedProject: Project
    @Binding var isShowTapedProject: Bool
    
    func getProject(projectName: String) -> Project {
        for project in projects.projects {
            if project.name == projectName {
                return project
            }
        }
        print("Error: Can't find that project")
        return Project(name: "", description: "", picture: "", homepage: "", interests: [])
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading) {
                        // show full name
                        HStack{
                            Text(self.profile.firstName)
                                .font(.system(size: 20, weight: .bold))
                            Text(self.profile.lastName)
                                .font(.system(size: 20, weight: .bold))
                        }
                        Text(self.profile.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    WebImage(url: URL(string: self.profile.picture)).renderingMode(.original)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 60, height:60)
                }
                Text(self.profile.bio)
                    .fixedSize(horizontal: false, vertical: true)
                
             
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(profile.interests, id: \.self) {interest in
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
                VStack(alignment: .leading) {
                    HStack {
                        Text("Projects").fontWeight(.semibold)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profile.projects, id: \.self) { project in
                                
                                WebImage(url: URL(string: self.getProject(projectName: project).picture))
                                    .renderingMode(.original)
                                    .resizable().frame(width: 50, height: 50)
                                    .cornerRadius(50)
                                    .onTapGesture {
                                        self.showedProject = self.getProject(projectName: project)
                                        self.isShowTapedProject = true
                                    }
                            }
                        }
                    }
                }
                
            }
        }.padding(.vertical, 10)
    }
}



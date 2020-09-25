//
//  CardView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/24/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct BrowseProfileView: View {
    var profile: Profile
    @EnvironmentObject var projects: ProjectViewModel
    @Binding var isShowed: Bool
    var body: some View {
        ZStack {
            
            Rectangle().fill(Color.white.opacity(0.5)).ignoresSafeArea()
                .onTapGesture(count: 1, perform: {
                    dismiss()
                })
            
            VStack {
                
                // Picture, Name, Title and Email
                VStack {
                    WebImage(url: URL(string: profile.picture))
                        .resizable()
                        .cornerRadius(150)
                        .frame(width: 150, height: 150)
                    Text("\(profile.firstName) \(profile.lastName)")
                        .fontWeight(.heavy)
                        .font(.title)
                    HStack {
                        Text("\(profile.title)")
                            .foregroundColor(.gray)
                        Text("\(profile.email)")
                    }
                }
                
                // Interest and Projects
                VStack(alignment: .leading) {
                    Text(profile.bio).fontWeight(.semibold)
                    Divider()
                    Text("Projects:")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profile.projects, id: \.self) { projectName in
                                
                                WebImage(url: URL(string: getProject(projectName: projectName)))
                                    .resizable()
                                    .cornerRadius(50)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                    Divider()

                    Text("Interests:")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profile.interests, id: \.self) { interest in
                                Text("  \(interest)  ")
                                    .fontWeight(.semibold)
                                    .background(Color(#colorLiteral(red: 0.7262665033, green: 0.720197618, blue: 0.7732493281, alpha: 1)))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    
                }.padding()
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 4 / 5)
            .background(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1)))
            .cornerRadius(50)
        }.animation(.spring()).transition(.move(edge: .trailing))
        
    }
    
    
    //MARK: -Data Functions
    func getProject(projectName: String) -> String {
        for project in projects.projects {
            if project.name == projectName {
                return project.picture
            }
            
        }
        print("Error: Can't find that project")
        return ""
        
    }
    
    func dismiss() {
        self.isShowed = false
    }
}

struct CardView: View {
    var profile = Profile(firstName: "Wei", lastName: "He", bio: "This is bio which is very long.", email: "wei@test.com", title: "student", projects: ["Bowfolio"], interests: ["Climate Change", "ICS"], picture: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/440px-Image_created_with_a_mobile_phone.png")
    var body: some View {
        BrowseProfileView(profile: profile, isShowed: .constant(true))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

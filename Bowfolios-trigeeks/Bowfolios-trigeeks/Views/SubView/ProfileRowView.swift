//
//  ProfileRowView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ProfileRowView: View {
    @State var profile: Profile
    @ObservedObject var projects = ProjectViewModel()
    
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
                    Image("turtlerock")
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
                                
                                Image("turtlerock")
                                    .resizable().frame(width: 50, height: 50).cornerRadius(50)
                            }
                        }
                    }
                }
                
            }
        }.onAppear() {
            self.projects.fetchData()
        }
    }
}



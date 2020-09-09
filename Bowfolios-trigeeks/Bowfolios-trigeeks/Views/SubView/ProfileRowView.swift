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
                
            }
        }
    }
}



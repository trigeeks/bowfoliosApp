//
//  ProfileView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var projects = ProjectViewModel()
    @ObservedObject var profiles = ProfileViewModel()
    var body: some View {
        
        List(self.profiles.profiles) { profile in
            ProfileRowView(profile: profile)
        }
        .onAppear {
            self.profiles.fetchData()
            self.projects.fetchData()
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//  ProjectsView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    @Binding var forceReload: Bool
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(self.projects.projects) { project in
                    ProjectRowView(project: project).padding(.horizontal)
                    Spacer().frame(height: 12).background(Color("bg5"))
                }
            }
            .onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
            }
        }
    }
}



struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(forceReload: .constant(false)).environmentObject(ProjectViewModel()).environmentObject(ProfileViewModel())
    }
}

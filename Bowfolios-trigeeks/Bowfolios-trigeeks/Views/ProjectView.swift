//
//  ProjectsView.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct ProjectView: View {
    @ObservedObject var projects = ProjectViewModel()
    @ObservedObject var profiles = ProfileViewModel()
    var body: some View {
        
        List(self.projects.projects) { project in
            ProjectRowView(project: project)
        }
        .onAppear {
            self.profiles.fetchData()
            self.projects.fetchData()
        }
        
    }
}
    


struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}

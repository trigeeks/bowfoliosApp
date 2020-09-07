//
//  HomeView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/7/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        Button(action: {
            self.session.signOut()
        }) {
            Image(systemName: "clear.fill").resizable().frame(width: 25, height: 25).padding()
            
            Text("Quit").fontWeight(.regular)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

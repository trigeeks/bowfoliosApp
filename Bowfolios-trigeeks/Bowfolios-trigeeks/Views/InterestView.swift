//
//  InterestView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

struct InterestView: View {
   
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
    @State var interestsArray = InterestsArray().interestsArray
    var body: some View {
        VStack{
        List{
            ForEach(self.interestsArray, id: \.self){ sec in
                InterestRowView(theInterest: sec)
            }
            
        }
        
        }.onAppear {
            self.profiles.fetchData()
            self.projects.fetchData()
        }
    }
    
}



struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}

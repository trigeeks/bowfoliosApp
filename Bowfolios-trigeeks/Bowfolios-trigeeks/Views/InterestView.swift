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
    @ObservedObject var interestSection = InterestViewModel()
    var body: some View {
        VStack{
        List{
            ForEach(self.interestSection.interests){ sec in
                InterestRowView(theInterest: sec.title, userPics: sec.users, projectPics: sec.projects)
            }
            }
        }.onAppear {
            self.interestSection.fetchData()
        }
    }
}



struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}

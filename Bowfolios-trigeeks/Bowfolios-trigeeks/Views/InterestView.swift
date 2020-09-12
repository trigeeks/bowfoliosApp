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
   // @ObservedObject var interestSection = InterestViewModel()
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
//    @State var interestSec: [String:[String]] = ["Software Engineering":[],"Climate Change":[],"HPC":[],"Distributed Computing":[],"Renewable Energy":[],"AI":[],"Visualization":[],"Scalable IP Networks":[],"Educational Technology":[],"Unity":[]]
//    @State var pics: [[String]] = [[]]
    @State var interestsArray: [String] = ["Software Engineering", "Climate Change", "HPC", "Distributed Computing", "Renewable Energy", "AI", "Visualization", "Scalable IP Networks", "Educational Technology", "Unity"]
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
           // self.getPics()
        }
    }
    
//    func getPics() {
//
//        for eachProfile in self.profiles.profiles {
//            for eachInterestF in eachProfile.interests {
//                if self.interestSec[eachInterestF] == nil {
//
//                    self.interestSec[eachInterestF]?.append(eachProfile.picture)
//
//                } else {
//
//                    if !self.interestSec[eachInterestF]!.contains(eachProfile.picture) {
//                        self.interestSec[eachInterestF]?.append(eachProfile.picture)
//                    }
//                }
//
//            }
//        }
//
//        for eachProject in self.projects.projects {
//            for eachInterestP in eachProject.interests {
//                if self.interestSec[eachInterestP] == nil {
//
//                    self.interestSec[eachInterestP]?.append(eachProject.picture)
//
//                } else {
//                    if !self.interestSec[eachInterestP]!.contains(eachProject.picture) {
//
//                        self.interestSec[eachInterestP]?.append(eachProject.picture)
//
//                    }
//                }
//            }
//        }
//
//    }
}



struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}

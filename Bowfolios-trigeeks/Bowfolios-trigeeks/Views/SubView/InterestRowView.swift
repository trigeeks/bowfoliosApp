//
//  InterestRowView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

struct InterestRowView: View {
    
    var theInterest: String
    var userPics: [String]?
    var projectPics: [String]?
    
    var body: some View {
        VStack{
            Text(theInterest)
            
            Divider()
            
            ScrollView{
                
            HStack{
                if self.userPics != nil {
                    ForEach(self.userPics!, id: \.self){ userPic in
                    WebImage(url: URL(string: userPic)).renderingMode(.original).resizable().scaledToFit().frame(width:50, height: 50).clipShape(Circle())
                    
                }
                }
                
                if self.projectPics != nil {
                ForEach(self.projectPics!, id: \.self){ projectPic in
                    WebImage(url: URL(string: projectPic)).renderingMode(.original).resizable().scaledToFit().frame(width:50, height: 50).clipShape(Circle())
                    
                }
                }
            }
            }
        }
    }
}

struct InterestRowView_Previews: PreviewProvider {
    static var previews: some View {
        InterestRowView(theInterest: "lala", userPics: ["lala"], projectPics: ["lala"])
    }
}

//
//  Profile.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Profile: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var firstName: String
    var lastName: String
    var bio: String
    var email: String
    var title: String
    var projects: [String]
    var interests: [String]
    var picture: String
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case firstName
        case lastName
        case bio
        case email
        case title
        case projects
        case interests
        case picture
        
    }
}

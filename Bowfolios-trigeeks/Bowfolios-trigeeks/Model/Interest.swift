//
//  Interest.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Interest: Codable, Identifiable {
    
    @DocumentID var id: String?
    var projects: [String]
    var users: [String]
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case projects
        case users
        
    }
}

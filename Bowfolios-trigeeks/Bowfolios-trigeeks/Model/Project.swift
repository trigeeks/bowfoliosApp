//
//  Project.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Project: Codable, Identifiable {
    
    @DocumentID var id: String?
    var name: String
    var description: String
    var picture: String
    var homepage: String
    var interests: [String]

    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case description
        case picture
        case homepage
        case interests
        
    }
}

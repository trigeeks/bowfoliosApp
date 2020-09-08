//
//  ProfileViewModel.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase

class ProfileViewModel: ObservableObject {
    
    @Published var profiles: [Profile] = []
    
}

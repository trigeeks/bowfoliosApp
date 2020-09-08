//
//  ProfileViewModel.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import Firebase
import Combine

class ProfileViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var profile: Profile
    @Published var modified = false
    
    init(profile: Profile  = Profile(firstName: "", lastName: "", email: "", bio: "", title: "", projects: [], interests: [], picture: "")) {
        self.profile = profile
        
        self.$profile
            .dropFirst()
            .sink { [weak self] project in
                self?.modified = true
        }
    .store(in: &cancellables)
    }
    
    // add Profile when user sign up successfully
    func addProfile(profile: Profile) {
        do {
            let _ = try db.collection("profiles").document(profile.email).setData(from: profile)
            print("added")
        } catch {
            print(error)
        }
    }
}


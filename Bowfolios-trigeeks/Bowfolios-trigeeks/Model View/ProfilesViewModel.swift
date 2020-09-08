//
//  ProfilesViewModel.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
 
class ProfilesViewModel: ObservableObject {
    
    @Published var profiles = [Profile]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("profiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.profiles = documents.compactMap { (queryDocumentSnapshot) -> Profile? in
               return try? queryDocumentSnapshot.data(as: Profile.self)

            }
            print(self.profiles)
            print("Done for fetching data")
        }
    }
    
    // add project to the given profile when Adding Project
    func addOneProject(projectName: String, email: String) {
        db.collection("profiles").document(email).updateData(["projects" : FieldValue.arrayUnion([projectName])])
        
        print("updated!")
        
        }
    
    
    // update profile when users use EditProfile View
    func updateProfile(profile: Profile) {
        do {
            try db.collection("profiles").document(profile.email).setData(from: profile, merge: true)
        } catch {
            print(error)
        }
    }
    
    // generate url from storage and put into picture
    func loadImageFromStorage(profile: Profile) {
        let storage = Storage.storage().reference()
        let imageRef = storage.child("profileImages/\(profile.email.lowercased()).jpg")
        imageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                self.loadImageFromStorage(profile: profile)
            } else {
            //self.project.picture = "\(url!)"
            self.db.collection("profiles").document(profile.email).updateData(["picture" : "\(url!)"])
            }
            

        }

    }
    
    
    func save(profile: Profile, isUploadImage: Bool) {
        updateProfile(profile: profile)
        if isUploadImage {
            loadImageFromStorage(profile: profile)
        }
    }
}

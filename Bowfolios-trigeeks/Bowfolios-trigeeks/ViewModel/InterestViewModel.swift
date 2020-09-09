//
//  InterestViewModel.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class InterestViewModel: ObservableObject {
    
    @Published var interests = [Interest]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("interests").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.interests = documents.compactMap { (queryDocumentSnapshot) -> Interest? in
                return try? queryDocumentSnapshot.data(as: Interest.self)
                
            }
            print(self.interests)
        }
    }
}

//
//  ProjectViewModel.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/8.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProjectViewModel: ObservableObject {
    
    @Published var projects = [Project]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("projects").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.projects = documents.compactMap { (queryDocumentSnapshot) -> Project? in
                return try? queryDocumentSnapshot.data(as: Project.self)
                
            }
            print(self.projects)
            print("Done for fetching project data")
        }
    }

    
    // add a new project to firestore
    func addProject(project: Project) {
        do {
            let _ = try db.collection("projects").document(project.id!).setData(from: project)
        } catch {
            print(error)
        }
    }
    
    // update profile when users use EditProject View
    func updateProject(project: Project) {
        do {
            try db.collection("projects").document(project.id!).setData(from: project, merge: true)
        } catch {
            print(error)
        }
    }
    
    //
    func save(project: Project, isUploadImage: Bool) {
        updateProject(project: project)
        if isUploadImage {
            loadImageFromStorage(project: project)
        }
    }
    
    // generate url from storage and put into picture
    func loadImageFromStorage(project: Project) {
        let storage = Storage.storage().reference()
        let imageRef = storage.child("projectImages/\(project.id!.lowercased()).jpg")
        imageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                self.loadImageFromStorage(project: project)
            } else {
                //self.project.picture = "\(url!)"
                self.db.collection("projects").document(project.id!).updateData(["picture" : "\(url!)"])
            }
            
            
        }
        
    }
    
    
}

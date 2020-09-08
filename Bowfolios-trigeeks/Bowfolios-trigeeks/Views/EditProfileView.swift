//
//  EditProfileView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct EditProfileView: View {
    @Binding var editView: Bool
    
    @EnvironmentObject var session: SessionStore
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var title = ""
    @State private var bio = ""
    @State private var interests = ""
    @State private var projects = ""
    @State private var picture = ""
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    
    var body: some View {
        VStack{
            HStack{
                
                Button(action: {
                    self.editView = false
                }) {
                    Text("Cancel")
                        .multilineTextAlignment(.leading)
                }.padding(.horizontal)
                
                Spacer()
                
                Text("Edit profile").font(.headline).multilineTextAlignment(.center).padding(.trailing, 12)
                
                Spacer()
                
            Button(action: {
                self.editProfile()
                self.editView = false
            }){
                Text("Save")
                    
            }.padding(.horizontal)
            }.padding(.top, 20)
            
            Spacer()

            Button(action: {
                self.showActionSheet = true
            }) {
                if image == nil {
                    ZStack{

                        
                        Image("turtlerock").renderingMode(.original).resizable().scaledToFit().frame(width:120, height: 120).clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                        
                        Image(systemName: "camera.on.rectangle").font(.system(size: 30, weight: .regular)).foregroundColor(Color.white)
                        .shadow(radius: 10)
                    }
                }else{
                    ZStack{
                                            
                        Image(uiImage: image!).renderingMode(.original).resizable().scaledToFit().frame(width:120, height: 120).clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                        
                        Image(systemName: "camera.on.rectangle").font(.system(size: 30, weight: .regular)).foregroundColor(Color.white)
                        .shadow(radius: 10)
                        
                    }
                }
            }.padding(.vertical, 30).actionSheet(isPresented: $showActionSheet){
                ActionSheet(title: Text("Add a picture"), message: nil, buttons: [
                //button 1
                    .default(Text("Camera"), action: {
                        self.showImagePicker = true
                        self.sourceType = .camera
                    }),
                    //button2
                    .default(Text("Photo library"), action: {
                        self.showImagePicker = true
                        self.sourceType = .photoLibrary
                    }),
                    
                    //button3
                    .cancel()
                ])
            }.sheet(isPresented: $showImagePicker){
                imagePicker(image: self.$image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
            }
            
            Spacer()
            Form{
            HStack{
                Text("First Name")
                    .multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("First Name", text: $firstName)
                .font(.system(size: 14))
                
                
            }
            
            HStack{
                Text("Last Name")
                    .multilineTextAlignment(.leading).padding(.horizontal)

                TextField("Last Name", text: $lastName)
                .font(.system(size: 14))
                

            }
            
            HStack{
                Text("Title   ")
                    .multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("Aka?", text: $title)
                .font(.system(size: 14))
                
                
            }
                
                HStack(alignment: .top){
                Text("Bio     ")
                    .multilineTextAlignment(.leading).padding(.horizontal)
                
                    TextField("Add a Bio to your profile", text: $bio)
                        .font(.system(size: 14)).lineLimit(4)
                        .multilineTextAlignment(.leading).frame(height: 100)
            }
                
            
            HStack{
                Text("Interests")
                    .multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("What do you like", text: $interests)
                .font(.system(size: 14))
                
                
            }
            
            HStack{
                Text("Projects")
                    .multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("your projects", text: $projects)
                .font(.system(size: 14))
                
                
            }
                
            }
            Spacer()
            
        }.onAppear {
            self.getInfo()
        }
    }
    
// MARK: - functions
    func editProfile() {
        let db = Firestore.firestore()
        let userEmail : String = (Auth.auth().currentUser?.email)!
        print("Current user email is " + userEmail)
        
        //skip adding picture now
        
         db.collection("profiles").document(userEmail).setData(["bio": bio, "email": userEmail, "firstName": firstName, "interests": [interests], "lastName": lastName, "picture": "nothing", "projects": [projects], "title": title])
        
        
//        case 1: users chose a image as their profile photo
        if let thisImage = self.image {
            uploadImage(image: thisImage, path: userEmail)
        } else {
            print("could't upload image - no image present!")
        }
    }
    
    func getInfo(){
        let db = Firestore.firestore()
        let userEmail : String = (Auth.auth().currentUser?.email)!
        
        let doc = db.collection("profiles").document(userEmail)
        doc.getDocument { (document, err) in
            if let document = document, document.exists {
                
                //document is found
                let profile = try! document.data(as: Profile.self)
                
                //fetching data and display into Textfields
                self.firstName = profile!.firstName
                self.lastName = profile!.lastName
                self.bio = profile!.bio
                self.title = profile!.title
                
            } else {
                print("Document does not exist, it will create a new document for user")
            }
        }
    }
    
}
// MARK: - helper functions
func uploadImage(image: UIImage, path: String){
    if let imageData = image.jpegData(compressionQuality: 0.2){
        let storage = Storage.storage()
        storage.reference().child(path).putData(imageData, metadata: nil){
            (_, err) in
            if let err = err{
                print("an error has happened -> \(err.localizedDescription)")
            } else {
                print("image uploaded successfully")
            }
        }
        
        } else {
                   print("could't unwrap/case image to data")
    }
}



// MARK: - helper views



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(editView: .constant(true))
    }
}

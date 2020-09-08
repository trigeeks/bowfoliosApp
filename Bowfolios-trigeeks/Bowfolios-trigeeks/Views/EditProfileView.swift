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

            Spacer()
            HStack{
                Text("First Name")
                    .font(.headline).multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("First Name", text: $firstName)
                .font(.system(size: 14))
                .padding(12)
                
            }.background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1))
            
            HStack{
                Text("Last Name")
                    .font(.headline).multilineTextAlignment(.leading).padding(.horizontal)

                TextField("Last Name", text: $lastName)
                .font(.system(size: 14))
                .padding(12)

            }.background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1))
            
            HStack{
                Text("Title   ")
                    .font(.headline).multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("Aka?", text: $title)
                .font(.system(size: 14))
                .padding(12)
                
            }.background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1)).edgesIgnoringSafeArea(.all)
            
            HStack{
                Text("Bio     ")
                    .font(.headline).multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("Add a Bio to your profile", text: $bio)
                .font(.system(size: 14))
                    .padding(12)
                
            }
            .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1)).edgesIgnoringSafeArea(.all)
            
            HStack{
                Text("Interests")
                    .font(.headline).multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("What do you like", text: $interests)
                .font(.system(size: 14))
                .padding(12)
                
            }.background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1)).edgesIgnoringSafeArea(.all)
            
            
            HStack{
                Text("Projects")
                    .font(.headline).multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("your projects", text: $projects)
                .font(.system(size: 14))
                .padding(12)
                
            }.background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1)).edgesIgnoringSafeArea(.all)
            
            Spacer()
            
            Button(action: {
                self.editProfile()
                self.editView = false
            }){
                Text("Edit")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
            }
            
                        
            
            Button(action: {
                self.showActionSheet = true
            }) {
                if image == nil {
                    Text("pick a image")
                }else{
                    ZStack{
                                            
                        Image(uiImage: image!).renderingMode(.original).resizable().scaledToFit().frame(width:200, height: 100)
                        
                    }
                }
            }.actionSheet(isPresented: $showActionSheet){
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
        }
    }
    
    //upload data to firebase
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
    
}

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

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
    }
}

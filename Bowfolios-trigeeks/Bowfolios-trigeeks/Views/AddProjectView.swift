//
//  AddProjectView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct AddProjectView: View {
    @Binding var showAddProject: Bool
    @Binding var showSheet: Bool
    @Binding var forceReload: Bool
    
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
    @State private var name = ""
    @State private var homepage = ""
    @State private var description = ""
    @State private var interests: [String] = []
    @State private var picture = ""
    // TODO: add real interests list
    @State var interestsArray: [String] = ["Software Engineering", "Climate Change", "HPC", "Distributed Computing", "Renewable Energy", "AI", "Visualization", "Scalable IP Networks", "Educational Technology", "Unity"]
    @State var usersArray: [String] = []
    
    @State var selectedParticipantsArray: [String] = []
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var showInterestsSelections = false
    @State var showParticipantsSelections = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    
    @State var value = CGFloat(0)
    
    
    
    var body: some View {
        ZStack {
        VStack {

            //MARK: - navigation button and title
            HStack{
                
                Button(action: {
                    self.handleCancelButton()
                }) {
                    Text("Cancel")
                        .multilineTextAlignment(.leading)
                }.padding(.horizontal)
                
                Spacer()
                
                Text("Add Project")
                    .font(.headline).multilineTextAlignment(.center).padding(.trailing, 12)
                
                Spacer()
                
                // Save Button
                Button(action: {
                    self.handleSaveButton()
                }){
                    Text("Save")
                    
                }.padding(.horizontal)
                .disabled(name == "" ||
                homepage == "" ||
                interests.count <= 0 ||
                description == "" ||
                image == nil)
                
                
                }.padding(.top, 20)
            
            Spacer()
            
                Button(action: {
                    self.showActionSheet = true
                }) {
                    if image == nil {
                        ZStack{
                            
                            
                            Image("turtlerock").renderingMode(.original).resizable().scaledToFit().frame(width:120, height: 120).clipShape(Circle())
                                .background(
                                    Circle().fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 8, y: 10)
                                    .shadow(color: Color.white.opacity(1), radius: 2, x: -10, y: -10)
                            )
                            
                            Image(systemName: "camera.on.rectangle").font(.system(size: 30, weight: .regular)).foregroundColor(Color.white)
                            .shadow(radius: 10)
                        }
                    }else{
                        ZStack{
                                                
                            Image(uiImage: image!).renderingMode(.original).resizable().frame(width:120, height: 120).clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
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

            //MARK: - Form for projecct information
            Form {
                HStack{
                    Text("Name          ")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    
                    TextField("Project Name", text: $name)
                        .font(.system(size: 14))
                    
                }
                
                
                HStack(alignment: .top) {
                    Text("Description")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    
                    //                TextField("Description", text: $description)
                    //                .font(.system(size: 14))
                    MutiLineTextField(preText: "Add some description of your project", text: $description).frame(height: 80)
                    
                    
                }

                
                HStack{
                    Text("Homepage ")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    
                    TextField("Project page link", text: $homepage)
                        .font(.system(size: 14))
                    
                    
                }

                
                HStack{
                    Text("Interests")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    Spacer()
                    Image(systemName: "chevron.down")
                    
                    
                }.onTapGesture {
                    self.showInterestsSelections = true
                }
                
                
                if interests.count > 0 {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(self.interests, id: \.self) { interest in
                                Text("  \(interest)  ")
                                .fontWeight(.semibold)
                                           .background(Color(#colorLiteral(red: 0.4322651923, green: 0.5675497651, blue: 0.8860189915, alpha: 1)))
                                           .foregroundColor(Color.white)
                                           .cornerRadius(20)
                            }
                        }.padding()
                        
                    }
                    
                }
                
                HStack{
                    Text("Participants")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    Spacer()
                    Image(systemName: "chevron.down")
                    
                    
                }.onTapGesture {
                    self.showParticipantsSelections = true
                    self.getUsersArray()
                }
                
                if selectedParticipantsArray.count > 0 {
                    VStack {
                        ForEach(self.selectedParticipantsArray, id: \.self) { user in
                            HStack {
                                Spacer()
                                Text("  \(user)  ")
                            }.padding(10)
                            
                        }
                    }
                }
                
            }
            Spacer()
            
        }
            
            // MARK: - Selections of interests and participants
            Selections(showSelections: $showInterestsSelections, selectedArray: $interests, itemsArray: $interestsArray).offset(y: showInterestsSelections ? 0 : 900).animation(.linear)
            
            Selections(showSelections: $showParticipantsSelections, selectedArray: $selectedParticipantsArray, itemsArray: $usersArray).offset(y: showParticipantsSelections ? 0 : 900).animation(.linear)
        }
        
//        .offset(y: -self.value).animation(.spring()).onAppear {
//            self.profilesViewModel.fetchData()
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
//                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//                let height = value.height
//                self.value = height
//            }
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
//                self.value = 0
//            }
//
//        }
    }
    
    
    // MARK: - Button functions

    func handleCancelButton() {
        dismiss()
    }
    
    func handleSaveButton() {
        setParticipants()
        let project: Project = Project(name: self.name, description: self.description, picture: "", homepage: self.homepage, interests: self.interests)
        uploadImage(image: image!, path: project.id!)
        projects.addProject(project: project)
        self.forceReload.toggle()
        dismiss()
    }
    
    func dismiss() {
        showAddProject = false
        showSheet = false
    }

    // MARK: - Data functions

    func uploadImage(image: UIImage, path: String){
        if let imageData = image.jpegData(compressionQuality: 0.2){
            let storage = Storage.storage()
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            storage.reference().child("projectImages/\(path).jpg").putData(imageData, metadata: metadata){
                (_, err) in
                if let err = err{
                    print("an error has happened -> \(err.localizedDescription)")
                } else {
                    print("project image uploaded successfully")
                    let imageRef = storage.reference().child("projectImages/\(path).jpg")
                    imageRef.downloadURL { (url, error) in
                        if error != nil {
                            print((error?.localizedDescription)!)
                        } else {
                            //self.project.picture = "\(url!)"
                            Firestore.firestore().collection("projects").document(path).updateData(["picture" : "\(url!)"])
                        }
                        
                        
                    }
                }
            }
            
            } else {
                       print("could't unwrap/case image to data")
        }
    }
    
    
    func setParticipants() {
        for user in self.selectedParticipantsArray {
            for profile in self.profiles.profiles {
                if profile.email.lowercased() == user.lowercased() {
                    
                    self.profiles.addOneProject(projectName: self.name, email: profile.email)
                    
                }
            }
        }
    }
    
    func getUsersArray() {
        var users: [String] = []
        for profile in profiles.profiles {
            users.append(profile.email)
        }
        self.usersArray = users
    }
    
    
    
    
} // end of struct





struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(showAddProject: .constant(true), showSheet: .constant(true), forceReload: .constant(false))
    }
}

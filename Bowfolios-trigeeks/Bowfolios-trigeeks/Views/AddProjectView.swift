//
//  AddProjectView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct AddProjectView: View {
    @Binding var showAddProject: Bool
    @Binding var showSheet: Bool
    
    @ObservedObject var profilesViewModel = ProfileViewModel()
    @ObservedObject var projectViewModel = ProjectViewModel()
    
    @State private var name = ""
    @State private var homepage = ""
    @State private var description = ""
    @State private var interests: [String] = []
    @State private var picture = ""
    
    @State var selectedParticipantsArray: [String] = []
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    
    
    var body: some View {
        VStack {
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
                    //interest.count <= 0 ||
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
                Text("Name          ")
                    .multilineTextAlignment(.leading).padding(.horizontal)
                
                TextField("Project Name", text: $name)
                .font(.system(size: 14))
                
                
            }
                
                HStack{
                    Text("Homepage ")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    
                    TextField("Project page link", text: $homepage)
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
                    Text("Interests")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    
                    
                }
                
                HStack{
                    Text("Participants")
                        .multilineTextAlignment(.leading).padding(.horizontal)
                    
                    
                }
                
            }
            Spacer()
            
        }.onAppear {
            self.profilesViewModel.fetchData()
        }
    }
    
    
    // MARK: - Button functions

    func handleCancelButton() {
        dismiss()
    }
    
    func handleSaveButton() {
        let project: Project = Project(name: self.name, description: self.description, picture: "nothing", homepage: self.homepage, interests: self.interests)
        uploadImage(image: image!, path: project.id!)
        projectViewModel.addProject(project: project)
        projectViewModel.loadImageFromStorage(project: project)
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
                }
            }
            
            } else {
                       print("could't unwrap/case image to data")
        }
    }
    
    
    func setParticipants() {
        for user in self.selectedParticipantsArray {
            for profile in self.profilesViewModel.profiles {
                if profile.email.lowercased() == user.lowercased() {
                    
                    self.profilesViewModel.addOneProject(projectName: self.name, email: profile.email)
                    
                }
            }
        }
    }
    
    
    
    
} // end of struct





struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(showAddProject: .constant(true), showSheet: .constant(true))
    }
}

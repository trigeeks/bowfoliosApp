//
//  FilterView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/9/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @State var showSelections: Bool = false
    @State var selectedArray: [String] = []
    @State var interestsArray: [String] = ["Software Engineering", "Climate Change", "HPC", "Distributed Computing", "Renewable Energy", "AI", "Visualization", "Scalable IP Networks", "Educational Technology", "Unity"].sorted()
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel
    
//    func getInterests() -> [String] {
//        var interestsArray: [String] = []
//
//        //for profile in profilesViewModel.profiles {
//        for profile in profilesViewModel.profiles {
//            for interest in profile.interests {
//                if interestsArray.contains(interest) == false {
//                    interestsArray.append(interest)
//                }
//            }
//        }
//
//        //for project in projectsViewModel.projects {
//        for project in projectsViewModel.projects {
//            for interest in project.interests {
//                if interestsArray.contains(interest) == false {
//                    interestsArray.append(interest)
//                }
//            }
//        }
//
//        return interestsArray
//
//    }
    
    
    var body: some View {
        
        
        
        GeometryReader { geometry in
            
            
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        // plus button
                        HStack {
                            Text("Interests:").fontWeight(.semibold)
                            Spacer()
                            Button(action: {
                                self.showSelections = true
                            }) {
                                Image(systemName: "plus").font(.system(size: 26))
                            }
                            
                        }.padding()
                        
                        // display interests selected
                        HStack {
                            
                            generateContent(in: geometry, selectedArray: self.selectedArray)
                            
                        }.padding(.bottom, 30)
                        Spacer()
                    }
                    
                    
                    
                    // showing result section: profileCards
                    ForEach(self.getProfiles(interests: self.selectedArray), id:\.self) { profile in

                        ProfileRowView(profile: profile).padding()
                    }.id(UUID())
                    
                    
                }
                .background(Color.white)
                
                
                
                Selections(showSelections: self.$showSelections, selectedArray: self.$selectedArray, itemsArray: self.$interestsArray).zIndex(self.showSelections ? 1 : -1)
                
                
            }.edgesIgnoringSafeArea(.bottom)
            .onAppear {
                self.profiles.fetchData()
                self.projects.fetchData()
            }
            
        }
    }
    

    
    // Get profiles by given interests

    func getProfiles(interests: [String]) -> [Profile]{
        var profiles: [Profile] = []
        for profile in self.profiles.profiles {
            var isContains = false
            for interest in interests {
                if profile.interests.contains(interest) {
                    isContains = true
                }
            }
            if isContains {
                profiles.append(profile)
            }
        }
        
        return profiles
    }
    
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}




// make item in HStack can wrap if this line is full
func generateContent(in g: GeometryProxy, selectedArray: [String]) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    return ZStack(alignment: .topLeading) {
        ForEach(selectedArray, id: \.self) { selectedItem in
            Text("  \(selectedItem)  ")
            .fontWeight(.semibold)
            .background(Color(#colorLiteral(red: 0.4322651923, green: 0.5675497651, blue: 0.8860189915, alpha: 1)))
            .foregroundColor(Color.white)
            .cornerRadius(20)
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if selectedItem == selectedArray.last! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if selectedItem == selectedArray.last! {
                        height = 0 // last item
                    }
                    return result
                })
        }
    }
}

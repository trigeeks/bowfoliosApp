//
//  FilterView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/9/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Namespace private var animation
    @State var showSelections: Bool = true
    @State var selectedArray = Set<String>()
    @State var interestsArray = InterestsArray().interestsArray
    @EnvironmentObject var projects: ProjectViewModel
    @EnvironmentObject var profiles: ProfileViewModel

    @State var items: [ExpandList] = InterestsArray().interestsArray.map { (interest) -> ExpandList in
        return (ExpandList(name: interest, isTitle: false, isSelected: IsSelected(false)))
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                //MARK: - Top Section of the View: button and selected Array
                HStack {
                    Text("Interests:").fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.showSelections.toggle()
                        }
                    }) {
                        if showSelections {
                            Image(systemName: "chevron.down").font(.system(size: 26))
                        } else {
                            Image(systemName: "chevron.right").font(.system(size: 26))
                        }
                    }
                    
                }.padding(.horizontal)
                
                
                // display interests selected
                HStack {
                    generateContent(in: geometry, selectedArray: Array(self.selectedArray))
                    
                }
                
                
                ZStack {
                    
                    //MARK: - List of All Interests to be selected
                    if showSelections {

                            List(items, children: \.items, selection: $selectedArray) { row in
                                MultiSelectRow(item: row, selectedItems: $selectedArray)
                            }.zIndex(5).transition(.move(edge: .trailing)).animation(.spring())

                            
                        VStack {
                            Spacer()
                            Button(action: {
                                self.selectedArray = Set<String>()
                            }, label: {
                                Text("Check All")
                            }).padding(.bottom, 40)
                        }.zIndex(6)
                        
                        
                    }
                    
                    //MARK: - List of Profiles
                    ScrollView(showsIndicators: false) {
                        // showing result section: profileCards
                        LazyVStack {
                            ForEach(self.getProfiles(interests: Array(self.selectedArray)), id:\.self) { profile in
                                
                                ProfileRowView(profile: profile).padding()
                            }.id(UUID())
                        }
                    }.background(Color.white)
                }.edgesIgnoringSafeArea(.bottom)
                .onAppear {
                    self.profiles.fetchData()
                    self.projects.fetchData()
                }
            }
        } // end of Geometry Reader
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



// MARK: - Selection List
// listItem Object
struct ExpandList: Identifiable {
    var id = UUID()
    let name: String
    let isTitle: Bool
    var isSelected: IsSelected
    var items: [ExpandList]?
}
// make isSelected in ExpandList mutable
class IsSelected {
    var isSelected: Bool
    
    init(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
    func togglel(){
        self.isSelected.toggle()
    }
}
// List Item Row
struct MultiSelectRow : View {
    
    var item: ExpandList
    @Binding var selectedItems: Set<String>
    var isSelected: Bool {
        selectedItems.contains(item.name)
    }
    
    var body: some View {
        Button(action: {
            if self.isSelected {
                self.selectedItems.remove(self.item.name)
            } else {
                self.selectedItems.insert(self.item.name)
            }
            print(Array(self.selectedItems))
        }, label: {
            HStack {
                Text(self.item.name)
                Spacer()
                if self.isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.blue)
                }
            }
        })
    }
}



//MARK: - auto wrap function: this is global so any view can call it
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

//
//  SelectionsSheet.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/8/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct SelectionsSheet: View {
    @State var testArray = ["A", "B", "C"]
    @State var selectedArray: [String] = []
    var body: some View {
        Selections(showSelections: .constant(true), selectedArray: $selectedArray, itemsArray: $testArray)
    }
}

struct SelectionsSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelectionsSheet()
    }
}


struct Selections: View {
    
    @Binding var showSelections: Bool
    @Binding var selectedArray: [String]
    @Binding var itemsArray: [String]
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 20) {
                
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            self.showSelections = false

                        }) {
                            Text("Done").font(.system(size: 22)).fontWeight(.semibold)
                        }
                    }.padding()
                    
                    ScrollView {
                        Divider()
                        ForEach(itemsArray, id: \.self) { item in
                            SelectionRow(selectedArray: self.$selectedArray, content: item)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height*2/5)
            .background(Color(#colorLiteral(red: 0.9420220852, green: 0.9421797395, blue: 0.9420013428, alpha: 1)))
                .cornerRadius(30)
        }
        
            .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.01))
        .edgesIgnoringSafeArea(.all)

    }

}

struct SelectionRow: View {
    @State var isSelected = false
    @Binding var selectedArray: [String]
    
    var content: String
    var body: some View {
        VStack {
        Button(action: {
            
            self.isSelected.toggle()
            
            if self.isSelected {
                self.selectedArray.append(self.content)
               print(self.selectedArray)
                
            } else {
                self.selectedArray.remove(at: self.selectedArray.firstIndex(of: self.content)!)
                print(self.selectedArray)
            }
        }) {
            HStack {
                Text(content)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark").foregroundColor(Color.blue)
                }
                
                
            }.font(.system(size: 20)).padding(.horizontal).padding(.vertical, 2)
        }.foregroundColor(Color.black)
        Divider()
        }.onAppear {
            if self.selectedArray.contains(self.content) {
                self.isSelected = true
            }
        }
    }

}

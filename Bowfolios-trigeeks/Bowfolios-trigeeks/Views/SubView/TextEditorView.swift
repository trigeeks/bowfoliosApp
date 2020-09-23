//
//  TextEditorView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/23/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    var body: some View {
        VStack {
            VStack {
                Divider()
                TextEditor(text: $text).frame(height: UIScreen.main.bounds.height/4)
                Spacer()
                
            }.frame(maxHeight: .infinity).background(Color(#colorLiteral(red: 0.8864660859, green: 0.8863860965, blue: 0.9189570546, alpha: 1))).ignoresSafeArea().padding(.top, 1)
            .navigationBarTitle("", displayMode: .inline)

            
        }
    }
}


struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(text: .constant("Placeholderjbasjbjas ascjasjcbjabsc scanknskcnaksncaksnckasnckanscknascascasckanknkasncaksncknckasnca"))
    }
}

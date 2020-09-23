//
//  AlertView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/23/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    var body: some View {
        GeometryReader() { _ in
            VStack {
                HStack {
                    Text("ERROR").font(.title).bold().foregroundColor(Color.red.opacity(0.7))
                    Spacer()
                }.padding(.horizontal, 25)
                
                // error message
                Text(self.alertMessage).foregroundColor(Color.black.opacity(0.7)).padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
                
                Button(action: {
                    self.showAlert.toggle()
                }) {
                    Text("OK").padding(.vertical).frame(width: UIScreen.main.bounds.width - 120).foregroundColor(Color.black)
                    }.background(Color(#colorLiteral(red: 0.4928489327, green: 0.5647422075, blue: 0.6939288378, alpha: 1))).cornerRadius(20)
                }.padding().background(Color.white).cornerRadius(20)
        }.background(Color.black.opacity(0.2)).edgesIgnoringSafeArea(.all)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(showAlert: .constant(true), alertMessage: .constant("This is wrong"))
    }
}

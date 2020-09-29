//
//  LaunchView.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/29/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    @State private var showView = false
    @State private var angle: Double = 360
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Group{
            if showView {
                ContentView()
            } else {
                ZStack{
                    Color("bg3").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Image("bowfolio").rotation3DEffect(
                        .degrees(angle),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    ).opacity(opacity).scaleEffect(scale)
                }
            }
        }.onAppear{
            withAnimation(.linear(duration: 2)){
                angle = 0
                scale = 3
                opacity = 0
            }
            withAnimation(Animation.linear.delay(1.75)){
                showView = true
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

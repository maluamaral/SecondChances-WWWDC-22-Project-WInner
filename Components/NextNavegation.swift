//
//  File.swift
//  
//
//  Created by Maria Luiza Amaral on 22/04/22.
//

import Foundation
import SwiftUI

struct NextNavegation<Content: View>: View {
    private let sound = AddMusic(name: "next", format: ".mp3")
    @State private var animation = 0
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: content){
                Image("buttonNext")
                    .resizable()
                    .frame(width: 66, height: 66, alignment: .trailing)
                    .opacity(Double(animation))
                    .animation(
                        .easeInOut,
                        value: animation
                    )
                
            }//.padding(.bottom, 55)
                .simultaneousGesture(TapGesture().onEnded{
                    DispatchQueue.global(qos: .userInitiated).async {
                        sound.playOnce()
                    }
                })
        }.onAppear {
            animation = 1
            
        }
    }
}


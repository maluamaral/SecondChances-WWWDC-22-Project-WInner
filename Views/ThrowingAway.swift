//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 21/04/22.
//

import SwiftUI
import SpriteKit

struct ThrowingAway: View{
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    @State var showButton = false
    @State var showAlert = true
    
    var scene: SKScene {
            let scene = DragAndDropScene()
            scene.size = CGSize(width: 1012, height: 1078)
        scene.scaleMode = .aspectFill
            return scene
        }

    var body: some View {
        ZStack{
            Color.white
             .ignoresSafeArea()
            VStack {
                AddText(placeholder: "However, unfortunately, time passes and I get stuck in the wardrobe because I'm getting old. So then I'm dumped for my new home.")
                    .padding(.top, -30)
                    .padding(.trailing, 30)
                    .zIndex(2)
                ZStack{
                    SpriteView(scene: scene)
                        .frame(width: screenWidth - 50, height: screenHeight - 350, alignment: .center)
                        .ignoresSafeArea()
                        .zIndex(1)
                    if showAlert{
                        AlertDrag()
                            .padding(.top, UIScreen.main.bounds.size.height * 0.7)
                            .zIndex(3)
                    }
                
                }
                if showButton {
                    HStack(spacing: 0){
                        NextNavegation(content: { TheFinal() })
                    }
                
                }
            }.navigationBarHidden(true)
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "DragAndDropScene")), perform: { _ in
                    showButton = true
                })
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "Drag")), perform: { _ in
                    showAlert = false
                })
               
            AddTexture()
        }
        
    }
}



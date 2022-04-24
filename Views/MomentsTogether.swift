//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 20/04/22.
//

import SpriteKit
import SwiftUI
import CoreMotion

struct MomentsTogether: View{
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    @State private var polaroid = Image("darkPolaroid")
    @State private var tapPolaroid = false
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State var showButton = false
    @State var showAlert = true

    var scene: SKScene {
            let scene = PictureRevealScene()
            scene.size = CGSize(width: 866, height: 1073)
            scene.scaleMode = .aspectFill
            return scene
        }
    
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                VStack {
                    Text("We visited many places and enjoyed many moments together.")
                        .font(.custom("Marmelad-Regular", size: 30))
                        .foregroundColor(Color("brown"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.top, 100)
                        //.padding(.leading, 20)
                        .zIndex(2)
                    ZStack{
                        SpriteView(scene: scene)
                            .frame(width: screenWidth - 125, height: screenHeight - 300, alignment: .center)
                                   
                                    .zIndex(1)
                        if showAlert{
                            AlertMoveIpad()
                                .padding(.top, UIScreen.main.bounds.size.height * 0.7)
                                .zIndex(3)
                        }
                    }
                    
                    
                    if showButton {
                        HStack(spacing: 0){
                            NextNavegation(content: { ThrowingAway() })
                        }
                    }
                }
                AddTexture()
            }
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "PictureRevealScene")), perform: { _ in
            showButton = true
            
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "PictureRevealAlert")), perform: { _ in
            showAlert = false
            
        })
        
        
        .navigationBarHidden(true)
        .background(.white)
    }
    
}

struct MomentsTogether_Previews: PreviewProvider {
    static var previews: some View {
        MomentsTogether()
    }
}

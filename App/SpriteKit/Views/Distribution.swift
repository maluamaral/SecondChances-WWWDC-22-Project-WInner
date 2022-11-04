//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 19/04/22.
//

import SwiftUI

struct Distribution: View {
    @State var touchInView = false
    
    private var firstSound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "happy")!
    }
    private var secondSound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "sad")!
    }
    private var onlySound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "unica")!
    }
    
    private var erasableImageView: ErasableImageView {
        var view =  ErasableImageView(
            topImageName: "distribution",
            bacgroundImageName: "distributionPB"
        )
        view.enableButtonNext = enableButtonNext
        return view
    }
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    func enableButtonNext(){
        touchInView = true
    }
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                VStack {
                    AddText(placeholder:"Afterwards, my friends and I are transported around the world to be distributed to the store where I will be temporarily staying.")
                        .padding(.trailing, 20)
                        .padding(.top, 100)
                        .zIndex(2)
                    erasableImageView
                        .frame(width: screenWidth - 250, height: screenHeight - 350, alignment: .center)
                        .zIndex(1)
                    
                    HStack(spacing: 0){
                        if touchInView {
                            NextNavegation(content: { Sale() })
                                .padding(.bottom, 50)
                        }
                    }
                }
                 AddTexture()
                
            }.onAppear{
                firstSound.setVolume(volume: 1.0)
                onlySound.setVolume(volume: 1.0)
                
            }
             .onChange(of: touchInView) { newValue in
                firstSound.setVolume(volume: 0.0)
                // onlySound.setVolume(volume: 0.3)
            }
        }.navigationBarHidden(true)
            .background(.white)
    }
}

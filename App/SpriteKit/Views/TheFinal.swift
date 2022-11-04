//
//  File.swift
//  
//
//  Created by Maria Luiza Amaral on 22/04/22.
//

import SwiftUI

struct TheFinal: View {
    
    @State var touchInView = false
    private var firstSound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "happy")!
    }
    private var secondSound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "sad")!
    }
    
    
    private var erasableImageView: ErasableImageView {
        let view =  ErasableImageView(
            topImageName: "garbage",
            bacgroundImageName: "alternatives"
        ) {
            touchInView = true
        }
        return view
    }
    
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack{
            ZStack{
                VStack {
                    erasableImageView
                        .frame(width: screenWidth - 100, height: screenHeight - 175, alignment: .center)
                    HStack(spacing: 0){
                        AddText(placeholder: !touchInView ? "The garbage." : "However, we can give ourselves second chances, so that we take care of the planet and also build inspiring stories with other people.")
                            .padding(.leading, 30)
                            .padding(.bottom, 50)
                    }
                }
                AddTexture()
            }
        }.navigationBarHidden(true)
            .background(.white)
            .onAppear{
                secondSound.setVolume(volume: 1.0)
                //onlySound.setVolume(volume: 1.0)
                
            }
            
             .onChange(of: touchInView) { newValue in
                firstSound.setVolume(volume: 1.0)
                 //onlySound.setVolume(volume: 0.3)
            }
    }
}

struct TheFinal_Previews: PreviewProvider {
    static var previews: some View {
        TheFinal()
    }
}

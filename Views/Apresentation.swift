//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 14/04/22.
//

import SwiftUI

struct Apresentation: View {
    private let firstSound = AddMusic(name: "happy", format: ".mp3")
    private let secondSound = AddMusic(name: "sad", format: ".mp3")
    private let onlySound = AddMusic(name: "unica", format: ".mp3")
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    @State private var animation = 0
    
    var body: some View {
        VStack{
            ZStack{
                Color("creme")
                    .ignoresSafeArea()
                VStack {
                    AddText(placeholder:"Hi, I'm Printed, a t-shirt. I born in Brazil, em 2022 and today I want tell my history for you")
                    .padding(.trailing, 50)
                    ZStack{
                            Rectangle()
                                .fill(Color("yellow"))
                                .frame(width: screenWidth - 150, height: screenHeight - 300, alignment: .center)
                            
                            Image("tshirtHappy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth - 400, height: screenHeight - 400, alignment: .center)
                       // }
                    }
                    HStack(spacing: 0){
                        NextNavegation(content: { Manufacture() })
                    }
                }.padding(.top)
                
                AddTexture()
            }.navigationBarHidden(true)
        
        }.onAppear{
//            firstSound.play()
//            secondSound.play()
//              onlySound.play()
            
            MusicCoordinator.shared.addMusic(onlySound)
            MusicCoordinator.shared.addMusic(firstSound)
            MusicCoordinator.shared.addMusic(secondSound)

        }
    }
}


struct Apresentation_Previews: PreviewProvider {
    static var previews: some View {
        Apresentation()
    }
}

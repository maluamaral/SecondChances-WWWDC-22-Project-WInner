//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 14/04/22.
//

import SwiftUI
import UIKit

struct Manufacture: View {
    @State var touchInView = false
    @State var showAlert = true
    
    private var firstSound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "happy")!
    }
    private var secondSound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "sad")!
    }
//
    private var onlySound: AddMusic {
        MusicCoordinator.shared.getMusic(byName: "unica")!
    }
    
    private var erasableImageView: ErasableImageView {
        var view =  ErasableImageView(
            topImageName: "begin",
            bacgroundImageName: "beginPB"
        )
        view.enableButtonNext = enableButtonNext
        return view
    }
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    func enableButtonNext(){
        touchInView = true
        showAlert = false
    }
    
    var body: some View {
        ZStack(alignment: .top)  {
            //Color("creme")
            // .ignoresSafeArea()
            VStack{
                AddText(placeholder:"I'm made of fabric, probably cotton and polyester. To be made into a piece, the fabric is cut and sewn, giving it my shape.")
                    .padding(.top, 40)
                    .padding(.bottom, -30)
                    .zIndex(2)
                ZStack{
                    erasableImageView
                    .frame(width: screenWidth - 50, height: screenHeight - 300, alignment: .center)
                    .zIndex(1)
                    
                    if showAlert{
                        AlertBlushScene()
                            .padding(.top, UIScreen.main.bounds.size.height * 0.7)
                            .zIndex(3)
                    }
                }
                
                
                HStack(spacing: 0){
                    
                    if touchInView {
                        NextNavegation(content: { Distribution() })
                            .padding(.bottom, 50)
                    }
                   
                }
           }.onChange(of: touchInView) { newValue in
               firstSound.setVolume(volume: 0.0)
               //onlySound.setVolume(volume: 0.3)
           }
            
            AddTexture()
        }.navigationBarHidden(true)
            .background(.white)
    }
}

struct Manufacture_Previews: PreviewProvider {
    static var previews: some View {
        Manufacture()
    }
}

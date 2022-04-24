//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 20/04/22.
//

import SwiftUI

struct Buy: View{
    @State var touchInView = false
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    private var erasableImageView: ErasableImageView {
        var view =  ErasableImageView(
            topImageName: "buyBad",
            bacgroundImageName: "buy"
        )
        view.enableButtonNext = enableButtonNext
        return view
    }
    
    func enableButtonNext(){
        touchInView = true
    }
    
    var body: some View {
        ZStack() {
            VStack() {
                AddText(placeholder:"Here, I'm on display for everyone, so they can get to know me and if they like me, take me to a new home.")
                    .padding(.trailing, 20)
                    .padding(.top, 200)
                    .zIndex(2)
               erasableImageView
                    .frame(width: screenWidth - 150, height: screenHeight - 150)
                    .zIndex(1)
                if touchInView {
                    NextNavegation(content: { MomentsTogether() })
                        .padding(.bottom, 50)
                }
            }
            AddTexture()
        }.navigationBarHidden(true)
            .background(.white)
    }
    
}

struct Buy_Previews: PreviewProvider {
    static var previews: some View {
        Buy()
    }
}


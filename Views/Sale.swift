//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 19/04/22.
//

import SwiftUI

struct Sale: View {
    @State var touchInView = false
    private var erasableImageView: ErasableImageView {
        var view =  ErasableImageView(
            topImageName: "sale",
            bacgroundImageName: "salePB"
        )
        view.enableButtonNext = enableButtonNext
        return view
    }
    
    func enableButtonNext(){
        touchInView = true
    }
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                VStack {
                    AddText(placeholder:"Here, I'm on display for everyone, so they can get to know me and if they like me, take me to a new home.")
                      .zIndex(2)
                    erasableImageView
                        .frame(width: screenWidth - 100, height: screenHeight - 250, alignment: .center)
                        .zIndex(1)
                    HStack(spacing: 0){
                        
                        if touchInView {
                            NextNavegation(content: { Buy() })
                            
                        }
                    }
                }
                AddTexture()
            }
        }.navigationBarHidden(true)
            .background(.white)
    }
}

struct Sale_Previews: PreviewProvider {
    static var previews: some View {
        Sale()
    }
}


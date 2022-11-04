//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 19/04/22.
//

import SwiftUI
struct AddText: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    var placeholder : String
    
    var body: some View {
        Text(placeholder)
            .font(.custom("Poppins-Regular", size: 32))
            .frame(width: screenWidth - 175, height: 150)
            .foregroundColor(Color("brown"))
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            //.padding(.bottom, 60)
    }
}

//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 15/04/22.
//

import SwiftUI

struct ErasableImageView : UIViewControllerRepresentable {
    
    let topImageName: String
    let bacgroundImageName: String
    var enableButtonNext: () -> Void = {}
    
    func makeUIViewController(context: Context) -> MaskImagesView {
        let maskImagesView = MaskImagesView(topImageUsed: UIImage(named: topImageName)!, backgroundImageUse: UIImage(named: bacgroundImageName)!)
        maskImagesView.enableButtonNext = enableButtonNext
        return maskImagesView
    }
    
    func updateUIViewController(_ uiViewController: MaskImagesView, context: Context) {
    }
    
    
    typealias UIViewControllerType = MaskImagesView

    
}

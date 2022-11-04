//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 15/04/22.
//

import UIKit
import SwiftUI

class MaskImagesView:  UIViewController  {
    private let sound = AddMusic(name: "erase", format: ".mp3")
    var enableButtonNext: () -> Void = {}
    var maskDrawingAlpha: CGFloat = 0 {
        didSet {
            maskableView.maskDrawingAlpha = maskDrawingAlpha
            
        }
    }
    var circleRadius: CGFloat = 0
    {
       didSet {
        maskableView.circleRadius = circleRadius
       }
   }
    
    var topImage: UIImage?
    var maskableView: Eraser!
    
    var maskableViewBounds = CGRect.zero
    
    private var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()

    convenience init(topImageUsed: UIImage, backgroundImageUse: UIImage) {
        self.init()
        self.topImage = topImageUsed
        self.backgroundImage.image = backgroundImageUse
        self.maskableView = .init(topImage: topImage!)
        self.maskableView.movedCallback = touchMoved
        self.maskableView.endedCallback = touchEnded
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrainsts()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circleRadius = 120
        maskDrawingAlpha = 0.8
        maskableView.circleCursorColor = UIColor(.clear)
        maskableView.outerCircleCursorColor = UIColor(.clear)
    }
    
    override func viewDidLayoutSubviews() {
        if maskableView.bounds != maskableViewBounds {
            maskableViewBounds = maskableView.bounds
            maskableView.updateBounds()
        }
    }
    
    var moving = false
    
    func touchMoved() {
        print("moved")
        enableButtonNext()
        if !moving {
            moving = true
            sound.play()
        }
    }
    
    func touchEnded() {
        print("ended")
        sound.pauseSound()
        moving = false
    }
    
    func setupConstrainsts(){
        maskableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImage)
        view.addSubview(maskableView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            maskableView.topAnchor.constraint(
                equalTo: view.topAnchor, constant: 0),
            maskableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 0),
            maskableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: 0),
            maskableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
}

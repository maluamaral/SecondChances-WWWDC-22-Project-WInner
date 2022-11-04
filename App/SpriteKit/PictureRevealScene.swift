//
//  File.swift
//  Clothes
//
//  Created by Maria Luiza Amaral on 20/04/22.
//

import SpriteKit
import CoreMotion

class PictureRevealScene : SKScene {
    private let sound = AddMusic(name: "polaroid", format: ".mp3")
    var motionManager = CMMotionManager()
    var queue = OperationQueue()
    
    var oppacity = 1.0
    
    var reveals = [SKSpriteNode]()
    var polaroids = [SKSpriteNode]()
    var revealedPolaroids = [SKSpriteNode]()
    var positions: [(CGPoint, CGFloat)] = [
        (CGPoint(x: 0, y: -20), 9),
        (CGPoint(x:150, y: -300), -5),
        (CGPoint(x: 200, y: 400), -10),
        (CGPoint(x: -250, y: 100), -11),
        
    ]
    var background = SKSpriteNode(imageNamed: "map")
    
    var closeButton = SKSpriteNode(imageNamed: "closeButton")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        setup()
    }
    
    var openPolaroidIndex: Int?
    var pictureIsOpen: Bool {
        openPolaroidIndex != nil
    }
    
    func setup(){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        background.zPosition = -3
        background.position = CGPoint(x: 0, y: 0)
        background.name = "background"
        self.addChild(background)
        
        //darkPolaroid.position = CGPoint(x: 0, y: 0)
        addPolaroid(image: .init(imageNamed: "polaroidPark"), angle: 9, position: CGPoint(x: 0, y: -20))
        addPolaroid(image: .init(imageNamed: "polaroidTravel"), angle: 5, position: CGPoint(x: 150, y: -300))
        addPolaroid(image: .init(imageNamed: "polaroidHome"), angle: -10, position: CGPoint(x: 200, y: 400))
        addPolaroid(image: .init(imageNamed: "polaroidGuitar"), angle: -11, position: CGPoint(x: -250, y: 100))
        
        self.addChild(closeButton)
        
        closeButton.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.oppacity = 1.0
            let location = touch.location(in: self)
            for (i, polaroid) in polaroids.enumerated() {
                let reveal = reveals[i]
                if polaroid.contains(location)
                    && !pictureIsOpen
                    && !revealedPolaroids.contains(polaroid) {
                    print(polaroid)
                    
                    polaroid.setScale(1.5)
                    polaroid.zRotation = 0
                    polaroid.zPosition = 3
                    polaroid.position = CGPoint(x: 0, y: 0)
                    polaroid.alpha = 1.0
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "PictureRevealAlert"), object: nil)
                    
                    reveal.setScale(1.5)
                    reveal.zRotation = 0
                    reveal.zPosition = 3
                    reveal.position = CGPoint(x: 0, y: 0)
                    
                    background.alpha = 0.5
                    
                    openPolaroidIndex = i
                    
                    motionManager.accelerometerUpdateInterval = 0.5
                    motionManager.startAccelerometerUpdates(to: self.queue) { (data, error) in
                        guard let myData = data,
                              self.pictureIsOpen else {
                            print("Error: \(error)")
                            return
                        }
            
                        if  myData.acceleration.x > 0.3 || myData.acceleration.x < -0.3 {
                            polaroid.alpha = self.oppacity
                            self.sound.setVolume(volume: 30.0)
                            self.sound.play()
                            self.oppacity -= 0.2
                            
                        }else{
                            self.sound.pauseSound()
                        }
                        
                        if polaroid.alpha < 0.1 {
                            self.closeButton.isHidden = false
                            self.closeButton.setScale(0.6)
                            self.closeButton.position = CGPoint(x: polaroid.frame.maxX - 20, y: polaroid.frame.maxY + 40)
                        }
                    }
                }
            }
            
            if closeButton.contains(location),
                let openPolaroidIndex = openPolaroidIndex {
                let (startingPosition, startingAngle) = positions[openPolaroidIndex]
                self.sound.stopSound()
                closeButton.isHidden = true
                
                motionManager.stopAccelerometerUpdates()
                motionManager = CMMotionManager()
                queue = OperationQueue()
                
                background.alpha = 1.0
                
                polaroids[openPolaroidIndex].zPosition = 0
                polaroids[openPolaroidIndex].setScale(0.3)
                polaroids[openPolaroidIndex].position = startingPosition
                polaroids[openPolaroidIndex].zRotation = startingAngle
                
                revealedPolaroids.append(polaroids[openPolaroidIndex])
                
                let reveal = reveals[openPolaroidIndex]
                reveal.zPosition = 0
                reveal.setScale(0.3)
                reveal.position = startingPosition
                reveal.zRotation = startingAngle
                
                self.openPolaroidIndex = nil
                
                if (revealedPolaroids.count == 4) {
                    // Avisa a view que pode mostrar o botao
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "PictureRevealScene"), object: nil)
                }
            }
            
        }
        
    }
    func addPolaroid(image: SKSpriteNode, angle: Float, position: CGPoint) {
        let blackImage = SKSpriteNode(imageNamed: "darkPolaroid")
        image.position = position
        image.setScale(0.3)
        image.zRotation = CGFloat(GLKMathDegreesToRadians(angle))
        
        blackImage.position = position
        blackImage.setScale(0.3)
        blackImage.zRotation = CGFloat(GLKMathDegreesToRadians(angle))
        
        self.addChild(image)
        self.addChild(blackImage)
        
        reveals.append(image)
        polaroids.append(blackImage)
    }
    
    func addPolaroidColored(image: SKSpriteNode){
        self.addChild(image)
    }
}

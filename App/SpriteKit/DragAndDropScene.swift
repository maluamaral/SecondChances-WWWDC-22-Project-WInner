//
//  File.swift
//  
//
//  Created by Maria Luiza Amaral on 22/04/22.
//

import SpriteKit

class DragAndDropScene : SKScene {
    var enableButtonNext: () -> Void = {}
    
    private var closeBox = true
    private var currentNode: SKNode?
    private var tshirt = SKSpriteNode(imageNamed: "tshirtSide")
    private var garbage = SKSpriteNode(imageNamed: "box")
    private var background = SKSpriteNode(imageNamed: "throwingAway")
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = .white
        
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if tshirt.contains(location) {
                    self.currentNode = node
                    let texture = SKTexture(imageNamed: "tshirtBad")
                    tshirt.run(SKAction.setTexture(texture, resize: true))
                    tshirt.zPosition = 2
                    tshirt.setScale(0.4)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let _ = self.currentNode {
            let touchLocation = touch.location(in: self)
            tshirt.position = touchLocation
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Drag"), object: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if garbage.contains(location) {
                tshirt.removeFromParent()
                
                makeBoxAnimation()
                self.currentNode = nil
                enableButtonNext()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "DragAndDropScene"), object: nil)
            
            }
        }
    }
    
    func setup(){
        background.zPosition = 0
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)
        
        tshirt.zPosition = 2
        tshirt.setScale(0.8)
        tshirt.position = CGPoint(x: 180, y: 300)
        self.addChild(tshirt)
        
        garbage.setScale(0.8)
        garbage.zPosition = 1
        garbage.position = CGPoint(x: 150, y: -400)
        self.addChild(garbage)
    }
    
    func makeBoxAnimation(){
        let box1 = SKTexture(imageNamed: "box1")
        let box2 = SKTexture(imageNamed: "box2")
        let box3 = SKTexture(imageNamed: "box3")
        
        var frames: [SKTexture] = []
        frames.append(box1)
        frames.append(box2)
        frames.append(box3)
        
        if closeBox{
            garbage.run(SKAction.animate(with: frames,
                                 timePerFrame: 0.5,
                                 resize: true,
                                 restore: false))
        }
        closeBox = false
        
    }
}


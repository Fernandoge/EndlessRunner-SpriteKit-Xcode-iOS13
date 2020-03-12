//
//  GameScene.swift
//  MageRunner
//
//  Created by Fernando Garcia on 11-03-20.
//  Copyright © 2020 Fernando Garcia. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var movingObject: SKNode!
    
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        // Get label node from scene and store it for use later
        /*
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        */
        
        movingObject = SKNode()
        self.addChild(movingObject)
        
        // background
        let backgroundTexture = SKTexture(imageNamed: "winterBackground")
        let moveBackgroundSprite = SKAction.moveBy(x: -backgroundTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.25 * backgroundTexture.size().width))
        let resetBackgroundSprite = SKAction.moveBy(x: backgroundTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveBackgroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveBackgroundSprite, resetBackgroundSprite]))
        
        for i in 0 ... 6 {
            let sprite = SKSpriteNode(texture: backgroundTexture)
            sprite.zPosition = -1000
            sprite.setScale(0.4)
            sprite.position = CGPoint(x: CGFloat(i) * sprite.size.width, y: 0)
            sprite.run(moveBackgroundSpritesForever)
            movingObject.addChild(sprite)
        }
        
        // trees
        let treesTexture = SKTexture(imageNamed: "winterTrees")
        let moveTreesSprite = SKAction.moveBy(x: -treesTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.08 * treesTexture.size().width))
        let resetTreesSprite = SKAction.moveBy(x: treesTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveTreesSpritesForever = SKAction.repeatForever(SKAction.sequence([moveTreesSprite, resetTreesSprite]))
        
        for i in 0 ... 6 {
            let sprite = SKSpriteNode(texture: treesTexture)
            sprite.zPosition = -100
            sprite.setScale(0.4)
            sprite.position = CGPoint(x: CGFloat(i) * sprite.size.width, y: 0)
            sprite.run(moveTreesSpritesForever)
            movingObject.addChild(sprite)
        }
        
        // ground
        let groundTexture = SKTexture(imageNamed: "winterGround")
        let moveGroundSprite = SKAction.moveBy(x: -groundTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.02 * groundTexture.size().width))
        let resetGroundSprite = SKAction.moveBy(x: groundTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite, resetGroundSprite]))
        
        for i in 0 ... 5  {
            let sprite = SKSpriteNode(texture: groundTexture)
            sprite.setScale(0.4)
            sprite.position = CGPoint(x: CGFloat(i) * sprite.size.width, y: 0)
            sprite.run(moveGroundSpritesForever)
            movingObject.addChild(sprite)
        }
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    

}

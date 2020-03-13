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
    
    var physicsDelegate = PhysicsDetection()
    var movingObject: SKNode!
    var player = Player(imageNamed: "idle1_1")
    var touching = false
    
    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = physicsDelegate
        
        loadMap()
        
        player.load()
        addChild(player)
    }
    
    func loadMap() {
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
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.isDynamic = false
            sprite.physicsBody?.categoryBitMask = ColliderType.GROUND
            sprite.physicsBody?.contactTestBitMask = ColliderType.PLAYER
            sprite.setScale(0.4)
            sprite.position = CGPoint(x: CGFloat(i) * sprite.size.width, y: -190)
            sprite.run(moveGroundSpritesForever)
            movingObject.addChild(sprite)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if touching {
            player.jump()
        } else if !player.isGrounded && player.isJumping {
            player.isJumping = false
        }
        
        if (player.physicsBody?.velocity.dy)! < player.fallingVelocity && player.position.y > 10 {
            player.fall()
        }
    }
}

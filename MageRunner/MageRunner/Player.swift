//
//  Player.swift
//  MageRunner
//
//  Created by Fernando Garcia on 11-03-20.
//  Copyright © 2020 Fernando Garcia. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    var runFrames: [SKTexture] = []
    var jumpFrames: [SKTexture] = []
    var fallFrames: [SKTexture] = []
    var isJumping = false
    var isGrounded = false
    var isFalling = false
    
    var maxJump: CGFloat = 600
    var fallingVelocity: CGFloat = -200
    var jumpForce = 0

    func load() {
        //load animations
        runFrames = loadAnimation(spriteName: "run1", spritesAmount: 8)
        jumpFrames = loadAnimation(spriteName: "jump1", spritesAmount: 2)
        fallFrames = loadAnimation(spriteName: "fall1", spritesAmount: 2)
        
        //spawn player
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GROUND
        physicsBody?.contactTestBitMask = 0
        physicsBody?.fieldBitMask = 0
        position = CGPoint(x: -280, y: -130)
        animate(with: runFrames)
    }
    
    func loadAnimation(spriteName: String, spritesAmount: Int) -> [SKTexture] {
        let playerAnimatedAtlas = SKTextureAtlas(named: "Player")
        var frames: [SKTexture] = []
        
        for i in 1...spritesAmount {
            let playerTextureName = "\(spriteName)_\(i)"
            frames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        return frames
    }
    
    func animate(with frames: [SKTexture]) {
        let animation = SKAction.animate(with: frames, timePerFrame: 0.1, resize: false, restore: false)
        run(SKAction.repeatForever(animation), withKey: "animatingPlayer")
    }
    
    func jump() {
        //First jump if the player is on the ground
        if isGrounded {
            isJumping = true
            isGrounded = false
            animate(with: jumpFrames)
            physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2))
            jumpForce = 0
            //More force to the jump if touching continues
        } else if isJumping && jumpForce < 3 {
            physicsBody?.applyForce(CGVector(dx: 0, dy: 5))
            jumpForce += 1
        } else if isJumping {
            if (physicsBody?.velocity.dy)! < maxJump {
                physicsBody?.applyForce(CGVector(dx: 0, dy: 30))
            //Stop the jump after reaching the max jump distance
            } else {
                isJumping = false
            }
        }
    }
    
    func groundTouched() {
        if isGrounded {
            return
        } else {
            //Turn off dynamic body so the player doesn't bounce
            physicsBody?.isDynamic = false
            isGrounded = true
            isFalling = false
            animate(with: runFrames)
            physicsBody?.isDynamic = true
        }
    }
    
    func fall() {
        if isFalling {
            return
        } else {
            animate(with: fallFrames)
            isFalling = true
        }
    }
}


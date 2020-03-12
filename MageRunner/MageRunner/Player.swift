//
//  Player.swift
//  MageRunner
//
//  Created by Fernando Garcia on 11-03-20.
//  Copyright © 2020 Fernando Garcia. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    var node = SKSpriteNode()
    var currentFrames: [SKTexture] = []
    var runFrames: [SKTexture] = []
    var jumpFrames: [SKTexture] = []
    var fallFrames: [SKTexture] = []
    
    func load() {
        
        //load animations
        runFrames = loadAnimation(spriteName: "run1", spritesAmount: 8)
        jumpFrames = loadAnimation(spriteName: "jump1", spritesAmount: 2)
        fallFrames = loadAnimation(spriteName: "fall1", spritesAmount: 2)
        
        //spawn player
        currentFrames = runFrames
        let firstFrameTexture = currentFrames[0]
        node = SKSpriteNode(texture: firstFrameTexture)
        node.position = CGPoint(x: -280, y: -130)
        animatePlayer()
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
    
    func animatePlayer() {
        let animation = SKAction.animate(with: currentFrames, timePerFrame: 0.1, resize: false, restore: true)
        node.run(SKAction.repeatForever(animation), withKey: "animatingPlayer")
    }
}


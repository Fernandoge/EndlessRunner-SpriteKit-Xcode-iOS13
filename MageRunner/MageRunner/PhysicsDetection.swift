//
//  PhysicsDetection.swift
//  MageRunner
//
//  Created by Fernando Garcia on 12-03-20.
//  Copyright © 2020 Fernando Garcia. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0x1 << 0
    static let GROUND: UInt32 = 0x1 << 1
}


class PhysicsDetection: NSObject, SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            if let player = contact.bodyA.node as? Player {
                player.groundTouched()
            } else if let player = contact.bodyB.node as? Player {
                player.groundTouched()
            }
        }
    }

}

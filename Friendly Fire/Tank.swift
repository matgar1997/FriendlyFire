//
//  Tank.swift
//  Friendly Fire
//
//  Created by macrevieweru on 8/10/15.
//  Copyright (c) 2015 macrevieweru. All rights reserved.
//

import Foundation
import SpriteKit

class Tank : SKSpriteNode {
    
    var myBulletArray : [SKSpriteNode] = []
    var mBulletImage : String
    
    init(tankImage : String, bulletImage : String) {
        let texture = SKTexture(imageNamed: tankImage)
        self.mBulletImage = bulletImage
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }

    func fireBullet() {
        let bulletImage = SKSpriteNode(imageNamed: mBulletImage)
        bulletImage.physicsBody = SKPhysicsBody(circleOfRadius: bulletImage.size.height / 2)
        bulletImage.physicsBody?.affectedByGravity = false
        bulletImage.physicsBody?.contactTestBitMask = 16
        bulletImage.physicsBody?.collisionBitMask = 0
        bulletImage.xScale = 0.7
        bulletImage.yScale = 0.7
        myBulletArray.append(bulletImage)
        let location = self.position
        bulletImage.position = location
        let fireAction = SKAction.moveToY(self.frame.height + bulletImage.size.height / 2, duration: 1)
        self.addChild(bulletImage)
        bulletImage.runAction(fireAction)
    }
    
    func moveLeft() {
        let leftAction = SKAction.moveTo(CGPoint(x: self.position.x - 10, y: self.position.y), duration: 0.1)
        self.runAction(leftAction)
    }
    
    func moveRight() {
        let rightAction = SKAction.moveTo(CGPoint(x: self.position.x + 10, y: self.position.y), duration: 0.1)
        self.runAction(rightAction)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
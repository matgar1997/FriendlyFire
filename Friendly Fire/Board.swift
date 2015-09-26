//
//  Board.swift
//  Friendly Fire
//
//  Created by macrevieweru on 8/10/15.
//  Copyright (c) 2015 macrevieweru. All rights reserved.
//

import Foundation
import SpriteKit

class Board : SKScene, SKPhysicsContactDelegate {
    
    var tankArray : [Tank] = []
    var targetArray : [SKSpriteNode] = []
    var mRandomXCoor : [Int] = []
    //let player1 : Tank = Tank(tankImage: "BottomTankImage", bulletImage: "UserBulletImage")
    //let player2 : Tank = Tank(tankImage: "TopTankImage", bulletImage: "AIBulletImage")
    
    init(p1 : Tank) {
        super.init()
        let AIPlayer : Tank = Tank(tankImage: "TopTankImage", bulletImage: "AIBulletImage")
        self.tankArray.append(p1)
        self.tankArray.append(AIPlayer)
    }
    
    init(p1 : Tank, p2 : Tank) {
        super.init()
        self.tankArray.append(p1)
        self.tankArray.append(p2)
    }

    func generateTargetFirst() {
        
        targetArray[0] = SKSpriteNode(imageNamed: "TargetImage")
        targetArray[1] = SKSpriteNode(imageNamed: "TargetImage")
        
        for i in (Int(self.targetArray[0].size.width))...(Int(self.frame.width - self.targetArray[0].size.width)) {
            self.mRandomXCoor.append(i)
        }
        
        targetArray[0].physicsBody = SKPhysicsBody(circleOfRadius: targetArray[0].size.width / 2)
        targetArray[0].physicsBody?.affectedByGravity = false
        targetArray[0].physicsBody?.collisionBitMask = 0
        targetArray[0].physicsBody?.contactTestBitMask = 1
        targetArray[0].yScale = 1.5
        targetArray[0].xScale = 1.5
        //self.targetArray.append(targetArray[0])
        addChild(targetArray[0])
        
        targetArray[1].physicsBody = SKPhysicsBody(circleOfRadius: targetArray[1].size.width / 2)
        targetArray[1].physicsBody?.affectedByGravity = false
        targetArray[1].physicsBody?.collisionBitMask = 0
        targetArray[1].physicsBody?.contactTestBitMask = 4
        targetArray[1].yScale = 1.5
        targetArray[1].xScale = 1.5
        //self.targetArray.append(bottomTarget)
        addChild(targetArray[1])
    }
    
    func generateNewTargets(position : Int) {
        
        if position == 0 {
            
            let x1 = CGFloat(self.mRandomXCoor[Int(arc4random_uniform(UInt32(self.mRandomXCoor.count)))])
            let y1 = (self.tankArray[0].position.y - self.tankArray[0].size.height / 2) - 30
            
            self.targetArray[position].runAction(SKAction.moveTo(CGPoint(x: x1, y: y1), duration: 0))
            
        }
            
        else if position == 1 {
            
            let x2 =  CGFloat(self.mRandomXCoor[Int(arc4random_uniform(UInt32(self.mRandomXCoor.count)))])
            let y2 = (self.tankArray[1].position.y + self.tankArray[0].size.height / 2) + 30
            
            self.targetArray[position].runAction(SKAction.moveTo(CGPoint(x: x2, y: y2), duration: 0))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
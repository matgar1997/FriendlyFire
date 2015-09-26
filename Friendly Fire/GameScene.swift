//
//  GameScene.swift
//  Friendly Fire
//
//  Created by iD Student on 7/23/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//


//
// Update Version 1.1: Improved collision accuracy
// Next update remember to credit http://www.freesfx.co.uk for sound

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let bottomBlaster : SKSpriteNode = SKSpriteNode(imageNamed: "BottomTankImage")
    let topBlaster : SKSpriteNode = SKSpriteNode(imageNamed: "TopTankImage")
    let backgroundImage : SKSpriteNode = SKSpriteNode(imageNamed: "GamebackgroundImage")
    var targetArray : [SKSpriteNode] = []
    var mScore : Int = 0
    var myLabel = SKLabelNode(fontNamed:"Chalkduster")
    var countLabel : SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    var myBulletArray : [SKSpriteNode] = []
    var aiBulletArray : [SKSpriteNode] = []
    let setUpTar : SKSpriteNode = SKSpriteNode(imageNamed: "TargetImage")
    let topTarget = SKSpriteNode(imageNamed: "TargetImage")
    let bottomTarget = SKSpriteNode(imageNamed: "TargetImage")
    
    var mShot : Bool = false // true only for debug (Causes AI not to shoot)
    var mStartMotion : Bool = false
    var firstTargetUser : Bool = true
    var firstTargetAI : Bool = true
    
    var mKeepMoving : Int = 0 // 0 = no, 1 = right, 2 = left
    var mRandomXCoor : [Int] = []
    
    var defaults : NSUserDefaults = NSUserDefaults()
    
    var startTimer : NSTimer = NSTimer()
    var mRunTimeTimer : NSTimer = NSTimer()
    
    var countDown : Int = 3
    var mTimeRemaining : Int = 60
    
    var gameCanStart : Bool = false
    var firstAdding : Bool = true
    
    var player : AVAudioPlayer!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        
        for i in (Int(0 + self.setUpTar.size.width))...(Int(self.frame.width - self.setUpTar.size.width)) {
            self.mRandomXCoor.append(i)
        }
        //set position
        
        
        backgroundImage.position.y = self.frame.height / 2
        backgroundImage.position.x = self.frame.width / 2
        
        backgroundImage.zPosition = -10
        
        topBlaster.position.y = self.frame.height / 2 + self.frame.height / 3.5
        topBlaster.position.x = 0 + self.topBlaster.size.width / 2
        topBlaster.physicsBody = SKPhysicsBody(circleOfRadius: (topBlaster.size.width / 2) - 30)
        topBlaster.physicsBody?.affectedByGravity = false
        topBlaster.physicsBody?.collisionBitMask = 0
        topBlaster.physicsBody?.contactTestBitMask = 8
        
        bottomBlaster.position.y = (self.frame.height / 2) - (self.frame.height / 3.5)
        bottomBlaster.position.x = self.frame.width - self.bottomBlaster.size.width / 2
        bottomBlaster.physicsBody = SKPhysicsBody(circleOfRadius: (bottomBlaster.size.width / 2) - 30)
        bottomBlaster.physicsBody?.affectedByGravity = false
        bottomBlaster.physicsBody?.collisionBitMask = 0
        bottomBlaster.physicsBody?.contactTestBitMask = 2
        
        myLabel.text = "";
        myLabel.fontSize = 50;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        myLabel.fontColor = UIColor.blackColor()
        
        countLabel.fontSize = 30;
        countLabel.position.x = self.frame.width / 2
        countLabel.position.y = (self.frame.height / 2.5)
        countLabel.fontColor = UIColor.blackColor()
        
        //self.addChild(myLabel)
        
        self.physicsWorld.contactDelegate = self
        
        //scale for iPhone 6
        if self.frame.height == 667 {
            backgroundImage.xScale = 1.2 // 1.2
            backgroundImage.yScale = 1.6 //1.6
            
            topBlaster.xScale = 0.2
            topBlaster.yScale = 0.2
            
            bottomBlaster.xScale = 0.2
            bottomBlaster.yScale = 0.2
            //print(self.mRandomXCoor.count)
        }
            
            //scale for iPhone 6+
        else if self.frame.height == 736 {
            //println("not for 6+")
            backgroundImage.xScale = 1.2 // 1.2
            backgroundImage.yScale = 1.6 //1.6
            
            topBlaster.xScale = 0.2
            topBlaster.yScale = 0.2
            
            bottomBlaster.xScale = 0.2
            bottomBlaster.yScale = 0.2
        }
            
            //Scale for iPhone 5
        else if self.frame.height == 568 {
            //println("not for 5")
            backgroundImage.xScale = 0.9 // 1.2
            backgroundImage.yScale = 1.3 //1.6
            
            topBlaster.xScale = 0.2
            topBlaster.yScale = 0.2
            
            bottomBlaster.xScale = 0.2
            bottomBlaster.yScale = 0.2
            
            self.myLabel.fontSize = 30
            self.countLabel.fontSize = 20
        }
            
            //scale for iPhone 4
        else if self.frame.height == 480 {
            //println("not for 4")
            backgroundImage.xScale = 0.9 // 1.2
            backgroundImage.yScale = 1.0 //1.6
            
            topBlaster.xScale = 0.1
            topBlaster.yScale = 0.1
            
            bottomBlaster.xScale = 0.1
            bottomBlaster.yScale = 0.1
            
            self.myLabel.fontSize = 30
            self.countLabel.fontSize = 20
        }
        //Adding
        
        self.addChild(myLabel)
        self.addChild(countLabel)
        self.addChild(backgroundImage)
        self.addChild(bottomBlaster)
        self.addChild(topBlaster)
        
        self.startTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "startDelay", userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        /*
        for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInNode(self)
        
        let sprite = SKSpriteNode(imageNamed:"BulletImage")
        
        sprite.xScale = 1.0
        sprite.yScale = 1.0
        sprite.position = location
        
        //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        let action = SKAction.moveToY(self.frame.maxY + sprite.size.height / 2, duration: 5)
        sprite.runAction(action)
        
        self.addChild(sprite)
        }
        */
        
        if self.gameCanStart == true {
            
            for touch in (touches ) {
                let location = touch.locationInNode(self)
                
                
                /*
                if location.y > self.size.height / 2 {
                userFireBullet()
                }
                
                */
                
                if location.x > self.bottomBlaster.position.x - 20 && location.x < self.bottomBlaster.position.x + 20 && location.y > self.bottomBlaster.position.y - 20 && location.y < self.bottomBlaster.position.y + 20 {
                    userFireBullet()
                }
                else {
                    if location.x > self.size.width / 2 {
                        //println("Move Right")
                        self.mKeepMoving = 1
                        self.moveRight()
                    }
                    else {
                        //println("Move Left")
                        self.mKeepMoving = 2
                        self.moveLeft()
                    }
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.mKeepMoving = 0
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if self.gameCanStart && firstAdding == true {
            createTargets()
            moveTargets(0)
            moveTargets(1)
            firstAdding = false
        }
        
        
        if gameCanStart {
            
            
            
            if self.mKeepMoving != 0 {
                if self.mKeepMoving == 1 {
                    self.moveRight()
                }
                else {
                    self.moveLeft()
                }
            }
            
            for bullet in myBulletArray {
                if bullet.position.y > self.size.height {
                    bullet.removeFromParent()
                }
            }
            
            
            for var i = 0; i < aiBulletArray.count; i++ {
                let bullet : SKSpriteNode = aiBulletArray[i]
                
                if bullet.position.y <= 0 {
                    bullet.removeFromParent()
                    aiBulletArray.removeAtIndex(i)
                    self.mShot = false
                }
            }
            
            /*
            for bullet in aiBulletArray {
            if bullet.position.y <= 0 {
            bullet.removeFromParent()
            aiBulletArray.removeAtIndex(indexOfAccessibilityElement(bullet))
            self.mShot = false
            }
            }
            
            */
            
            
            
            if topBlaster.position.x >= targetArray[0].position.x - 15 && topBlaster.position.x <= targetArray[0].position.x + 15 && mShot == false {
                
                if (!(bottomBlaster.position.x + bottomBlaster.size.width > topBlaster.position.x && bottomBlaster.position.x - bottomBlaster.size.width < topBlaster.position.x)) {
                    self.mShot = true
                    self.aiFireBullet()
                }
            }
            
            
            /*
            if self.mStartMotion == false {
            self.aiMoveToPosition()
            self.mStartMotion = true
            }
            
            */
            
            aiMoveToPosition()
            self.myLabel.text = "\(self.mScore)"
            
        }
        
    }
    
    func userFireBullet() {
        let bulletImage = SKSpriteNode(imageNamed: "UserBulletImage")
        bulletImage.physicsBody = SKPhysicsBody(circleOfRadius: bulletImage.size.width / 2)
        bulletImage.physicsBody?.affectedByGravity = false
        bulletImage.physicsBody?.contactTestBitMask = 16
        bulletImage.physicsBody?.collisionBitMask = 0
        bulletImage.xScale = 0.7
        bulletImage.yScale = 0.7
        myBulletArray.append(bulletImage)
        let location = bottomBlaster.position
        bulletImage.position = location
        let fireAction = SKAction.moveToY(self.frame.height + bulletImage.size.height / 2, duration: 1)
        self.addChild(bulletImage)
        bulletImage.runAction(fireAction)
        //testing
        //generateTarget(1)
    }
    
    
    func aiFireBullet() {
        let bulletImage = SKSpriteNode(imageNamed: "AIBulletImage")
        bulletImage.physicsBody = SKPhysicsBody(circleOfRadius: bulletImage.size.width / 2)
        bulletImage.physicsBody?.affectedByGravity = false
        bulletImage.physicsBody?.contactTestBitMask = 32
        bulletImage.physicsBody?.collisionBitMask = 0
        bulletImage.xScale = 0.7
        bulletImage.yScale = 0.7
        aiBulletArray.append(bulletImage)
        let location = topBlaster.position
        bulletImage.position = location
        let fireAction = SKAction.moveToY(0 - bulletImage.size.height / 2, duration: 1)
        self.addChild(bulletImage)
        bulletImage.runAction(fireAction)
        self.mStartMotion = false
    }
    
    func moveLeft() {
        //println(bottomBlaster.position.x)
        if bottomBlaster.position.x > 0 {
            let leftAction = SKAction.moveTo(CGPoint(x: self.bottomBlaster.position.x - 10, y: self.bottomBlaster.position.y), duration: 0.1)
            self.bottomBlaster.runAction(leftAction)
        }
    }
    
    func moveRight() {
        
        if bottomBlaster.position.x < self.size.width {
            let rightAction = SKAction.moveTo(CGPoint(x: self.bottomBlaster.position.x + 10, y: self.bottomBlaster.position.y), duration: 0.1)
            self.bottomBlaster.runAction(rightAction)
        }
    }
    
    func createTargets() {
        
        topTarget.physicsBody = SKPhysicsBody(circleOfRadius: topTarget.size.width / 2)
        topTarget.physicsBody?.affectedByGravity = false
        topTarget.physicsBody?.collisionBitMask = 0
        topTarget.physicsBody?.contactTestBitMask = 1
        topTarget.yScale = 1.5
        topTarget.xScale = 1.5
        self.targetArray.append(topTarget)
        addChild(topTarget)
        
        bottomTarget.physicsBody = SKPhysicsBody(circleOfRadius: bottomTarget.size.width / 2)
        bottomTarget.physicsBody?.affectedByGravity = false
        bottomTarget.physicsBody?.collisionBitMask = 0
        bottomTarget.physicsBody?.contactTestBitMask = 4
        bottomTarget.yScale = 1.5
        bottomTarget.xScale = 1.5
        self.targetArray.append(bottomTarget)
        addChild(bottomTarget)
    }
    
    func moveTargets(position : Int) {
        
        if position == 0 {
            
            let x1 = CGFloat(self.mRandomXCoor[Int(arc4random_uniform(UInt32(self.mRandomXCoor.count)))])
            let y1 = (self.bottomBlaster.position.y - self.bottomBlaster.size.height / 2) - 30
            
            self.targetArray[position].runAction(SKAction.moveTo(CGPoint(x: x1, y: y1), duration: 0))
            
        }
            
        else if position == 1 {
            
            let x2 =  CGFloat(self.mRandomXCoor[Int(arc4random_uniform(UInt32(self.mRandomXCoor.count)))])
            let y2 = (self.topBlaster.position.y + self.bottomBlaster.size.height / 2) + 30
            
            self.targetArray[position].runAction(SKAction.moveTo(CGPoint(x: x2, y: y2), duration: 0))
        }
    }
    
    func increaseScore() {
        self.mScore++
    }
    
    func setScore(score : Int) {
        self.mScore = score
    }
    
    func aiMoveToPosition() {
        
        let action = SKAction.moveTo(CGPoint(x: self.targetArray[0].position.x, y: self.topBlaster.position.y), duration: 0.9)
        
        self.topBlaster.runAction(action)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //println("CONTACT")
        //Bottom target = 1, Human Tank = 2, Top Target = 4, AI Tank = 8, Human bullet = 16, AIBullet = 32
        
        //AI hits target
        if contact.bodyA.contactTestBitMask == 1 && contact.bodyB.contactTestBitMask == 32 {
            //println("AI Hits Target")
            //targetCollisionSound()
            increaseScore()
            moveTargets(0)
            //targetArray[0].removeFromParent()
            //generateTarget(0)
        }
        else if contact.bodyB.contactTestBitMask == 1 && contact.bodyA.contactTestBitMask == 32 {
            //println("AI Hits Target")
            //targetCollisionSound()
            increaseScore()
            moveTargets(0)
            //targetArray[0].removeFromParent()
            //generateTarget(0)
        }
        
        //human hits target
        if contact.bodyA.contactTestBitMask == 16 && contact.bodyB.contactTestBitMask == 4 {
            //println("human Hits Target")
            //targetCollisionSound()
            increaseScore()
            moveTargets(1)
            //targetArray[1].removeFromParent()
            //generateTarget(1)
        }
        else if contact.bodyB.contactTestBitMask == 16 && contact.bodyA.contactTestBitMask == 4 {
            //println("human Hits Target")
            //targetCollisionSound()
            increaseScore()
            moveTargets(1)
            //targetArray[1].removeFromParent()
            //generateTarget(1)
        }
            
            //else if userBullet contacts AITank -> end game
        else if contact.bodyA.contactTestBitMask == 16 && contact.bodyB.contactTestBitMask == 8 {
            self.mRunTimeTimer.invalidate()
            goToEndScreen()
        }
            
        else if contact.bodyB.contactTestBitMask == 16 && contact.bodyA.contactTestBitMask == 8 {
            self.mRunTimeTimer.invalidate()
            goToEndScreen()
        }
            
            //else if AIBullet contacts UserTank -> end game
        else if contact.bodyA.contactTestBitMask == 32 && contact.bodyB.contactTestBitMask == 2 {
            self.mRunTimeTimer.invalidate()
            goToEndScreen()
        }
            
        else if contact.bodyB.contactTestBitMask == 32 && contact.bodyA.contactTestBitMask == 2 {
            self.mRunTimeTimer.invalidate()
            goToEndScreen()
        }
        
    }
    
    func goToEndScreen() {
        defaults.setInteger(self.mScore, forKey: "MYSCORE")
        
        let scoreScene = GameEnded(size: self.size)
        let transition : SKTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        self.scene?.view?.presentScene(scoreScene, transition: transition)
    }
    
    func startDelay() {
        
        if self.countDown == 3 {
            self.myLabel.text = "Ready"
        }
            
        else if self.countDown == 2 {
            self.myLabel.text = "Set"
        }
            
        else if self.countDown == 1 {
            self.myLabel.text = "Go"
            
            self.mRunTimeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "decreaseGameRunTime", userInfo: nil, repeats: true)
        }
        else if self.countDown == 0 {
            
            self.gameCanStart = true
            self.startTimer.invalidate()
        }
        
        self.countDown--
    }
    
    //Not Implemented yet, save when selected in settings screen
    func setGameRunTime() {
        
        if defaults.objectForKey("MYRUNTIME") == nil || defaults.integerForKey("MYRUNTIME") == 0 {
            self.mTimeRemaining = 60
        }
            
        else if defaults.objectForKey("MYRUNTIME") as! Int == 60 {
            self.mTimeRemaining = 60
        }
            
        else if defaults.objectForKey("MYRUNTIME") as! Int == 40 {
            self.mTimeRemaining = 40
        }
            
        else if defaults.objectForKey("MYRUNTIME") as! Int == 20 {
            self.mTimeRemaining = 20
        }
        
    }
    
    
    func decreaseGameRunTime() {
        
        self.countLabel.text = "Time: \(self.mTimeRemaining)"
        
        if self.mTimeRemaining == 0 {
            self.mRunTimeTimer.invalidate()
            goToEndScreen()
        }
            
        else {
            self.mTimeRemaining--
        }
    }
    
    func targetCollisionSound() {
        let path = NSBundle.mainBundle().pathForResource("Target Crash Sound", ofType: "mp3")
        let fileURL = NSURL(fileURLWithPath: path!)
        player = try? AVAudioPlayer(contentsOfURL: fileURL)
        player.prepareToPlay()
        player.play()
    }
    
}


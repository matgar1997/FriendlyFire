//
//  HighScoreScene.swift
//  Friendly Fire
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//

import SpriteKit

class HighScoreScene: SKScene {
    
    let backgroundImage : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImage")
    let clearHighScore : SKSpriteNode = SKSpriteNode(imageNamed: "ResetHighScoreImage")
    let mainMenuButton : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImageButton")
    
    var defaults : NSUserDefaults = NSUserDefaults()
    
    var highScorelabel : SKLabelNode = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        self.highScorelabel.fontName = "Chalkduster"
        
        if self.frame.height == 667 {
            backgroundImage.xScale = 1.2 // 1.2
            backgroundImage.yScale = 1.6 //1.6
        }
            
            //scale for iPhone 6+
        else if self.frame.height == 736 {
            //println("not for 6+")
            backgroundImage.xScale = 1.2 // 1.2
            backgroundImage.yScale = 1.6 //1.6
        }
            
            //Scale for iPhone 5
        else if self.frame.height == 568 {
            //println("not for 5")
            backgroundImage.xScale = 0.9 // 1.2
            backgroundImage.yScale = 1.3 //1.6
        }
            
            //scale for iPhone 4
        else if self.frame.height == 480 {
            //println("not for 4")
            backgroundImage.xScale = 0.9 // 1.2
            backgroundImage.yScale = 1.0 //1.6
        }
        
        backgroundImage.position.x = self.frame.width / 2
        backgroundImage.position.y = self.frame.height / 2
        
        highScorelabel.position.x = self.frame.width / 2
        highScorelabel.position.y = self.frame.height / 2
        highScorelabel.zPosition = 100
        
        mainMenuButton.position.x = self.frame.width / 2
        mainMenuButton.position.y = self.frame.height / 8
        mainMenuButton.zPosition = 100
        
        clearHighScore.position.x = self.frame.width / 2
        clearHighScore.position.y = self.frame.height / 4
        clearHighScore.zPosition = 100
        
        addChild(backgroundImage)
        addChild(highScorelabel)
        addChild(mainMenuButton)
        addChild(clearHighScore)
        
        self.setTextToLabel()
    }
    
    func goToMainScreen() {
        let mainScene = MainMenu(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 1.0)
        self.scene?.view?.presentScene(mainScene, transition: transition)
    }
    
    func setTextToLabel() {
        if defaults.objectForKey("MYHIGHSCORE") == nil || defaults.integerForKey("MYHIGHSCORE") == 0 {
            self.highScorelabel.text = "No High Score Yet"
        }
            
        else {
            let temp = defaults.objectForKey("MYHIGHSCORE") as! Int
            highScorelabel.text = "High Score: \(temp)"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if mainMenuButton.frame.contains(location) {
                goToMainScreen()
                
            }
            
            if clearHighScore.frame.contains(location) {
                defaults.setInteger(0, forKey: "MYHIGHSCORE")
                self.setTextToLabel()
            }
        }
    }
}

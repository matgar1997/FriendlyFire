//
//  GameEnded.swift
//  Friendly Fire
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//
//  Bug Fix- Fix buttons and labels so they always appear correctly

import SpriteKit

class GameEnded: SKScene {
    
    var mHighScore : Int = 0
    var mCurrentScore : Int = 0
    
    var defaults : NSUserDefaults = NSUserDefaults()
    let mKey : String = "MYSCORE"
    
    let gameSceneBackground : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImage")
    let mainMenuButton : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImageButton")
    
    var previousBestLabel : SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    var currentScoreLabel : SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    
    override func didMoveToView(view: SKView) {
        
        //self.mHighScore = defaults.integerForKey("MYHIGHSCORE")
        self.mCurrentScore = defaults.integerForKey(mKey)
        isNewHighScore()
        
        //scale for iPhone 6
        if self.frame.height == 667 {
            gameSceneBackground.xScale = 1.2 // 1.2
            gameSceneBackground.yScale = 1.6 //1.6
        }
            
            //scale for iPhone 6+
        else if self.frame.height == 736 {
            //println("not for 6+")
            gameSceneBackground.xScale = 1.2 // 1.2
            gameSceneBackground.yScale = 1.6 //1.6
        }
            
            //Scale for iPhone 5
        else if self.frame.height == 568 {
            //println("not for 5")
            gameSceneBackground.xScale = 0.9 // 1.2
            gameSceneBackground.yScale = 1.3 //1.6
        }
            
            //scale for iPhone 4
        else if self.frame.height == 480 {
            //println("not for 4")
            gameSceneBackground.xScale = 0.9 // 1.2
            gameSceneBackground.yScale = 1.0 //1.6
        }
        
        self.gameSceneBackground.position.x = self.frame.width / 2
        self.gameSceneBackground.position.y = self.frame.height / 2
        
        self.mainMenuButton.position.x = self.frame.width / 2
        self.mainMenuButton.position.y = self.frame.width / 4
        self.mainMenuButton.zPosition = 100
        
        self.previousBestLabel.text = "High Score: \(self.mHighScore)"
        self.currentScoreLabel.text = "You Scored: \(self.mCurrentScore)"
        
        self.previousBestLabel.position.x = self.frame.width / 2
        self.currentScoreLabel.position.x = self.frame.width / 2
        
        self.previousBestLabel.position.y = self.frame.height / 2
        self.currentScoreLabel.position.y = self.frame.height / 3
        
        self.previousBestLabel.zPosition = 100
        self.currentScoreLabel.zPosition = 100
        
        addChild(gameSceneBackground)
        addChild(previousBestLabel)
        addChild(currentScoreLabel)
        addChild(mainMenuButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if mainMenuButton.frame.contains(location) {
                goToMainScreen()
                
            }
        }
    }
    
    func isNewHighScore() {
        
        if defaults.objectForKey("MYHIGHSCORE") == nil{
            self.mHighScore = 0
        }
            
        else {
            self.mHighScore = defaults.objectForKey("MYHIGHSCORE") as! Int
        }
        
        if self.mCurrentScore > self.mHighScore {
            defaults.setInteger(self.mCurrentScore, forKey: "MYHIGHSCORE")
        }
        
        //defaults.objectForKey("MYHIGHSCORE") as! Int
    }
    
    func goToMainScreen() {
        let mainScene = MainMenu(size: self.size)
        let transition : SKTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        self.scene?.view?.presentScene(mainScene, transition: transition)
    }
    
}

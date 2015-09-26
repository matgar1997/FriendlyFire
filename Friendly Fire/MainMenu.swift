//
//  MainMenu.swift
//  Friendly Fire
//
//  Created by iD Student on 7/27/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    //replace single with other stuff image
    
    let titleBackgroundImage : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImage")
    let singlePlayerButton : SKSpriteNode = SKSpriteNode(imageNamed: "COOPButtonImage")
    let highScoreButton : SKSpriteNode = SKSpriteNode(imageNamed: "HighScoreImage")
    let rulesButton : SKSpriteNode = SKSpriteNode(imageNamed: "OtherStuffImage")
    
    func goToGame() {
        let gameScene = GameScene(size: self.size)
        let transition : SKTransition = SKTransition.doorsOpenVerticalWithDuration(0.75)
        
        self.scene?.view?.presentScene(gameScene, transition: transition)
    }
    
    func goToHighScoreScene() {
        let highScoreScene = HighScoreScene(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Up, duration: 1.0)
        self.scene?.view?.presentScene(highScoreScene, transition: transition)
        /*
        var transition : SKTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        self.scene?.view?.presentScene(highScoreScene, transition: transition)
        */
    }
    
    func goToRules() {
        let otherMenu = OtherMenuPage(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Up, duration: 1.0)
        self.scene?.view?.presentScene(otherMenu, transition: transition)
    }
    
    override func didMoveToView(view: SKView) {
        
        titleBackgroundImage.position.x = self.frame.size.width / 2
        titleBackgroundImage.position.y = self.frame.size.height / 2
        
        singlePlayerButton.position.x = self.frame.width / 2
        singlePlayerButton.position.y = self.frame.height / 2
        
        highScoreButton.position.x = self.frame.width / 2
        highScoreButton.position.y = self.frame.height / 3
        
        rulesButton.position.x = self.frame.width / 2
        rulesButton.position.y = self.frame.height / 6
        
        //scale for iPhone 6
        if self.frame.height == 667 {
            titleBackgroundImage.xScale = 1.2 // 1.2
            titleBackgroundImage.yScale = 1.6 //1.6
            
            //singlePlayerButton.xScale = 1.0
            //singlePlayerButton.yScale = 1.0
            //print(self.mRandomXCoor.count)
        }
            
            //scale for iPhone 6+
        else if self.frame.height == 736 {
            //println("not for 6+")
            titleBackgroundImage.xScale = 1.2 // 1.2
            titleBackgroundImage.yScale = 1.6 //1.6
        }
            
            //Scale for iPhone 5
        else if self.frame.height == 568 {
            //println("not for 5")
            titleBackgroundImage.xScale = 0.9 // 1.2
            titleBackgroundImage.yScale = 1.3 //1.6
        }
            
            //scale for iPhone 4
        else if self.frame.height == 480 {
            //println("not for 4")
            titleBackgroundImage.xScale = 0.9 // 1.2
            titleBackgroundImage.yScale = 1.0 //1.6
        }
        
        singlePlayerButton.zPosition = 100
        highScoreButton.zPosition = 100
        rulesButton.zPosition = 100
        
        addChild(titleBackgroundImage)
        addChild(singlePlayerButton)
        addChild(highScoreButton)
        addChild(rulesButton)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if singlePlayerButton.frame.contains(location) {
                goToGame()
                
            }
            
            if highScoreButton.frame.contains(location) {
                goToHighScoreScene()
                
            }
            
            if rulesButton.frame.contains(location) {
                goToRules()
            }
            
        }
    }
}

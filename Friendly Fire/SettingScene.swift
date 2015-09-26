//
//  SettingScene.swift
//  Friendly Fire
//
//  Created by iD Student on 7/29/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//

import SpriteKit

class SettingScene: SKScene {
    
    //Add things here such as length of game, new tank images, new targets, clear high score
    
    let titleBackgroundImage : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImage")
    let mainMenuButton : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImageButton")
    
    
    var defaults : NSUserDefaults = NSUserDefaults()
    
    override func didMoveToView(view: SKView) {
        
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
        
        self.titleBackgroundImage.position.y = self.frame.height / 2
        self.titleBackgroundImage.position.x = self.frame.width / 2
        
        self.mainMenuButton.position.x = self.frame.width / 2
        self.mainMenuButton.position.y = self.frame.height / 10
        
        self.mainMenuButton.zPosition = 100
        
        addChild(titleBackgroundImage)
        addChild(mainMenuButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if mainMenuButton.frame.contains(location) {
                goToMainMenu()
            }
        }
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        
    }
    
    func goToMainMenu() {
        let mainScene = MainMenu(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 1.0)
        self.scene?.view?.presentScene(mainScene, transition: transition)
    }
    
}

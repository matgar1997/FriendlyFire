//
//  RulesScene.swift
//  Friendly Fire
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//

import SpriteKit

class RulesScene: SKScene {
    
    let titleBackgroundImage : SKSpriteNode = SKSpriteNode(imageNamed: "RulesImage")
    let mainMenuButton : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImageButton")
    
    override func didMoveToView(view: SKView) {
        
        if self.frame.height == 667 {
            titleBackgroundImage.xScale = 1.2 // 1.2
            titleBackgroundImage.yScale = 1.6 //1.6
            
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
        
        titleBackgroundImage.position.x = self.frame.width / 2
        titleBackgroundImage.position.y = self.frame.height / 2
        
        mainMenuButton.position.x = self.frame.width / 2
        mainMenuButton.position.y = 20 + mainMenuButton.size.height / 2
        mainMenuButton.zPosition = 100
        
        addChild(titleBackgroundImage)
        addChild(mainMenuButton)
    }
    
    func goToMainMenu() {
        let mainMenu = MainMenu(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 1.0)
        self.scene?.view?.presentScene(mainMenu, transition: transition)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if mainMenuButton.frame.contains(location) {
                goToMainMenu()
                
            }
        }
    }
}

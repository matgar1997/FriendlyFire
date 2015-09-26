//
//  OtherMenuPage.swift
//  Friendly Fire
//
//  Created by iD Student on 7/29/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//

import SpriteKit

class OtherMenuPage: SKScene {
    
    //include rules button (top), setting button(bottom)
    
    let titleBackgroundImage : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImage")
    let rulesButton : SKSpriteNode = SKSpriteNode(imageNamed: "RulesButtonImage")
    //let settingsButton : SKSpriteNode = SKSpriteNode(imageNamed: "SettingImage")
    let mainMenuButton : SKSpriteNode = SKSpriteNode(imageNamed: "MainMenuImageButton")
    
    override func didMoveToView(view: SKView) {
        
        titleBackgroundImage.position.x = self.frame.size.width / 2
        titleBackgroundImage.position.y = self.frame.size.height / 2
        
        rulesButton.position.x = self.frame.width / 2
        rulesButton.position.y = self.frame.height / 2
        
        //settingsButton.position.x = self.frame.width / 2
        //settingsButton.position.y = self.frame.height / 3
        
        mainMenuButton.position.x = self.frame.width / 2
        mainMenuButton.position.y = self.frame.height / 6
        
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
        
        rulesButton.zPosition = 100
        //settingsButton.zPosition = 100
        mainMenuButton.zPosition = 100
        
        addChild(titleBackgroundImage)
        addChild(rulesButton)
        //addChild(settingsButton)
        addChild(mainMenuButton)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if rulesButton.frame.contains(location) {
                goToRules()
                
            }
            
            /*
            if settingsButton.frame.contains(location) {
                goToSettings()
                
            }
            */
            if mainMenuButton.frame.contains(location) {
                goToMainMenu()
                
            }
        }
        
    }
    
    func goToRules() {
        let rulesScene = RulesScene(size: self.size)
        let transition : SKTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        self.scene?.view?.presentScene(rulesScene, transition: transition)
    }
    
    func goToSettings() {
        let settingScene = SettingScene(size: self.size)
        let transition : SKTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        self.scene?.view?.presentScene(settingScene, transition: transition)
    }
    
    func goToMainMenu() {
        let mainScene = MainMenu(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 1.0)
        self.scene?.view?.presentScene(mainScene, transition: transition)
    }
    
}

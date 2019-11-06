//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by mitchell hudson on 9/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
    // spaeShip
    var spaceShip = SKSpriteNode()
    
    //making frames
  
    
    override func didMove(to view: SKView) {
       
        spaceShip = SKSpriteNode(imageNamed: "spaceship")
        spaceShip.size = CGSize(width: 100, height: 100)
        spaceShip.position = CGPoint(x: 10, y: 50)
        addChild(spaceShip)
        
       
    }
    
        
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // dis runs when touches began
        
        let rightWard = SKAction.move(to: CGPoint(x: 390, y: 50), duration: 1.9)
        let lefttWard = SKAction.move(to: CGPoint(x: 10, y: 50), duration: 1.9)
        let sequency = SKAction.sequence([ rightWard, lefttWard])
        let loop = SKAction.repeatForever(sequency)

        spaceShip.run(loop)
      

    }
    
    
  
  
}



 // Called when the scene has been displayed
        
//        let object = SKSpriteNode(color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), size: CGSize(width: 100, height: 100))
//        object.position = CGPoint(x: 0, y: 0)
//        self.addChild(object)
//
//        // move upward
//        let moveForard = SKAction.moveBy(x: 50, y: 500, duration: 1.5)
//
//
//        // leftWard
//        let leftWard = SKAction.moveBy(x: 50, y: 0, duration: 1.5)
//
//        // downWard
//        let downWard = SKAction.moveBy(x: 0, y: -500, duration: 1.5)
//
//        // group is when you whant all effect to happen at the same time
//
//        // sequence
//        let objectSequence = SKAction.sequence([moveForard, leftWard, downWard])
//        let loop = SKAction.repeatForever(objectSequence)
//
//        object.run(loop)
        

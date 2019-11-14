//
//  GameScene.swift
//  SushiNeko
//
//  Created by Macbook Pro 15 on 11/11/19.
//  Copyright © 2019 MohammedDrame. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
//MARK: Properties
    let punch = SKAction(named: "punch")!
    var sushiTower: [SushiPiece] = []
    var sushiBasePiece: SushiPiece!
    var character: Character!
    var state: GameState = .title /* Game management */
    var playButton: MSButtonNode!
    
//MARK: App LifeCycle
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        sushiBasePiece = childNode(withName: kBASESUSHI) as? SushiPiece
        sushiBasePiece.connectChopsticks()
        character = childNode(withName: kCHARACTER) as? Character
        addTowerPiece(side: .none)
        addRandomPieces(total: 10)
        playButton = childNode(withName: kPLAYBUTTON) as? MSButtonNode
        playButton.selectedHandler = {
            self.state = .ready
        }
    }
    
//MARK: Update
    override func update(_ currentTime: TimeInterval) {
        moveTowerDown()
    }
    
//MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .gameOver || state == .title { return }
        if state == .ready { state = .playing }
        let touch = touches.first!
     
        let location = touch.location(in: self)
        
        if location.x > size.width / 2 {
            character.side = .right
        } else {
            character.side = .left
        }
        if let firstPiece = sushiTower.first as SushiPiece? { /* Grab sushi piece on top of the base sushi piece, it will always be 'first' */
            if character.side == firstPiece.side { /* Check character side against sushi piece side (this is our death collision check)*/
                gameOver()
                return
            /* Remove from sushi tower array */
            sushiTower.removeFirst()
            firstPiece.flip(character.side)
            addRandomPieces(total: 1)
        }
    }
    
//MARK: Helper Methods
    func gameOver() {
        state = .gameOver
        /* Create turnRed SKAction */
        let turnRed = SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.50)
       
        sushiBasePiece.run(turnRed)
        for sushiPiece in sushiTower {
            sushiPiece.run(turnRed)
        }
        character.run(turnRed)
        playButton.selectedHandler = {
            let skView = self.view as SKView?
            guard let scene = GameScene(fileNamed: "GameScene") as GameScene? else {
                return
            }
            scene.scaleMode = .aspectFill /* Ensure correct aspect mode */
            skView?.presentScene(scene) /* Restart GameScene */
        }
    }
    
    func moveTowerDown() {
        var n: CGFloat = 0
        for piece in sushiTower {
            let y = (n * 55) + 215
            piece.position.y -= (piece.position.y - y) * 0.5
            n += 1
        }
    }
    
    func addRandomPieces(total: Int) { /* Add random sushi pieces to the sushi tower */
      for _ in 1...total {
          let lastPiece = sushiTower.last! /* Need to access last piece properties */
          if lastPiece.side != .none {
             addTowerPiece(side: .none)
          } else {
          
             let rand = arc4random_uniform(100)
             if rand < 45 {
               
                addTowerPiece(side: .left)
             } else if rand < 90 {
            
                addTowerPiece(side: .right)
             } else {
            
                addTowerPiece(side: .none)
             }
          }
      }
    }
    
    func addTowerPiece(side: Side) {
       let newPiece = sushiBasePiece.copy() as! SushiPiece
       newPiece.connectChopsticks()
       let lastPiece = sushiTower.last
     
       let lastPosition = lastPiece?.position ?? sushiBasePiece.position
       newPiece.position.x = lastPosition.x
       newPiece.position.y = lastPosition.y + 55
      
       let lastZPosition = lastPiece?.zPosition ?? sushiBasePiece.zPosition
       newPiece.zPosition = lastZPosition + 1
       /* Set side */
       newPiece.side = side
       addChild(newPiece)
       sushiTower.append(newPiece)
    }
    
}

//
//  GameScene.swift
//  FlappyBird
//
//  Created by Kunwardeep Gill on 2015-05-20.
//  Copyright (c) 2015 ProjectDGW. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  // Create a sprite node
  var bird = SKSpriteNode()
  
  
    override func didMoveToView(view: SKView) {
      /* Setup your scene here */
      var birdTexture = SKTexture(imageNamed: "flappy1")
      // assign texture to the node
      bird = SKSpriteNode(texture: birdTexture)
      bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
      
      
      // Create second texture
      var birdTexture2 = SKTexture(imageNamed: "flappy2")
      // Create animation SKAction var
      var animation = SKAction.animateWithTextures([birdTexture,birdTexture2], timePerFrame: 0.2)
      // Make the bird flap SKAction var
      var makeBirdFlap = SKAction.repeatActionForever(animation)
      bird.runAction(makeBirdFlap)
      
      // Create Physics
      bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
      
      // No Rotation
      bird.physicsBody?.allowsRotation = false
      
      addChild(bird)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

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
  var background = SKSpriteNode()
  var pipeTop = SKSpriteNode()
  var pipeBottom = SKSpriteNode()
  
  
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
      bird.physicsBody?.dynamic = true
      bird.physicsBody?.allowsRotation = false
      bird.zPosition = 5 //higher means closer to the screen - lower is further away
      //pipes are behind the bird so they should be set to 4
      //background should be set to 3
      
      // Create ground object
      var ground = SKNode()
      // Set ground position
      ground.position = CGPointMake(0, 0)
      // Set the Physics
      ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 20))
      ground.physicsBody?.dynamic = false
      ground.zPosition = 4
      addChild(ground)
      addChild(bird)
      
      //Add the Background Texture
      var backgroundImage = SKTexture(imageNamed: "bg")
      // Move the Background
      var moveBackground = SKAction.moveByX(-backgroundImage.size().width, y: 0, duration: 5)
      // Second Background
      var moveBackground2 = SKAction.moveByX(backgroundImage.size().width, y: 0, duration: 0)
      // Repeat the action
      var moveBackgroundForever = SKAction.repeatActionForever(SKAction.sequence([moveBackground,moveBackground2]))
      
      for var i:CGFloat = 0; i < 1 + self.frame.size.width / ( backgroundImage.size().width * 2 ); i++ {
        var backgroundSprite = SKSpriteNode(texture: backgroundImage)
        backgroundSprite.position = CGPoint(x: backgroundImage.size().width / 2 + backgroundImage.size().width * i, y:CGRectGetMidY(self.frame))
        backgroundSprite.size.height = self.frame.height
        
        backgroundSprite.runAction(moveBackgroundForever)
        addChild(backgroundSprite)
      }
      
      // Create Pipes
      var pipe1 = SKTexture(imageNamed: "pipe1")
      pipeTop = SKSpriteNode(texture: pipe1)
      pipeTop.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame))
      pipeTop.size.height = self.frame.size.height / 2
      pipeTop.physicsBody = SKPhysicsBody(rectangleOfSize:pipeTop.size)
      pipeTop.physicsBody?.dynamic = false
      pipeTop.physicsBody?.categoryBitMask
      var movePipeTop = SKAction.repeatActionForever(SKAction.moveByX(-100, y: 0, duration: 1))
      pipeTop.runAction(movePipeTop)
      addChild(pipeTop)
      
      var pipe2 = SKTexture(imageNamed: "pipe2")
      pipeBottom = SKSpriteNode(texture: pipe2)
      pipeBottom.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
      pipeBottom.size.height = self.frame.size.height / 2
      pipeBottom.physicsBody = SKPhysicsBody(rectangleOfSize:pipeBottom.size)
      pipeBottom.physicsBody?.dynamic = false
      var movePipeBottom = SKAction.repeatActionForever(SKAction.moveByX(-100, y: 0, duration: 1))
      pipeBottom.runAction(movePipeBottom)
      addChild(pipeBottom)
      

      
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
          
          if location == bird.position {
            //println("Flappy is touched")
          }
          
          
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

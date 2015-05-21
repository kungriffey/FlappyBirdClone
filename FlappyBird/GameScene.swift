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
      ground.position = CGPointMake(CGRectGetMidX(self.frame), 0)
      // Set the Physics
      ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 10))
      ground.physicsBody?.dynamic = false
      
      // Create sky object
      var sky = SKNode()
     sky.position = CGPointMake(10, CGRectGetMaxY(self.frame))
     sky.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 5))
      sky.physicsBody?.dynamic = false

      addChild(ground)
      addChild(sky)
      addChild(bird)
      
      //Add the Background Texture
      var backgroundImage = SKTexture(imageNamed: "bg")
      // Move the Background
      var moveBackground = SKAction.moveByX(-backgroundImage.size().width, y: 0, duration: 10)
      // Second Background
      var moveBackground2 = SKAction.moveByX(backgroundImage.size().width, y: 0, duration: 0)
      // Repeat the action
      var moveBackgroundForever = SKAction.repeatActionForever(SKAction.sequence([moveBackground,moveBackground2]))
      
      for var i:CGFloat = 0; i < 3; i++ {
        //+ self.frame.size.width / ( backgroundImage.size().width * 2 )
        var backgroundSprite = SKSpriteNode(texture: backgroundImage)
        backgroundSprite.position = CGPoint(x: backgroundImage.size().width / 2 + backgroundImage.size().width * i, y:CGRectGetMidY(self.frame))
        backgroundSprite.size.height = self.frame.height
        
        backgroundSprite.runAction(moveBackgroundForever)
        addChild(backgroundSprite)
        
      }
      //  Set up Timer
      var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
    }
  
    func makePipes() {
      
//        var pipeTop = SKSpriteNode()
//        var pipeBottom = SKSpriteNode()
    
    // Create a Gap
    var gap = bird.frame.size.height * 4
    
    // Movement amount
    var movementAmount = arc4random() %  UInt32(self.frame.size.height)
    // gap Offset
    var pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 2
    // Move Pipes
    var movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
    // Remove Pipes
    var removePipe = SKAction.removeFromParent()
    // Move and Remove Pipes
    var moveAndRemovePipes = SKAction.sequence([movePipes,removePipe])

    // Create Pipes
    var pipe1 = SKTexture(imageNamed: "pipe1")
    var pipeTop = SKSpriteNode(texture: pipe1)
    pipeTop.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeTop.size.height / 2 + gap / 2 + pipeOffset)
    pipeTop.physicsBody = SKPhysicsBody(rectangleOfSize:pipeTop.size)
    pipeTop.physicsBody?.dynamic = false
    //pipeTop.physicsBody?.categoryBitMask
    pipeTop.runAction(moveAndRemovePipes)
    self.addChild(pipeTop)
    
    var pipe2 = SKTexture(imageNamed: "pipe2")
    var pipeBottom = SKSpriteNode(texture: pipe2)
    pipeBottom.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.size.width, CGRectGetMidY(self.frame) - pipeBottom.size.height / 2 - gap / 2 + pipeOffset)
    pipeBottom.physicsBody = SKPhysicsBody(rectangleOfSize:pipeBottom.size)
    pipeBottom.physicsBody?.dynamic = false
    pipeBottom.runAction(moveAndRemovePipes)
    self.addChild(pipeBottom)
    
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

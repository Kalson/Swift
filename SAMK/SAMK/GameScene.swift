//
//  GameScene.swift
//  SAMK
//
//  Created by KaL on 9/22/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
        
    var player1 = Character()
    var player2 = Character()
    
    var sun = SKSpriteNode(imageNamed: "sun")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = UIColor(red: 0.078, green: 0.0827, blue: 0.949, alpha: 1.0)
//        self.backgroundColor = UIColor.redColor()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame) // puts a boundary on the frame
        self.physicsWorld.contactDelegate = self
        
        sun.size = CGSizeMake(SCREEN_HEIGHT, SCREEN_HEIGHT)
        sun.position = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0)
        
        self.addChild(sun)
        
        // setting background
        var bg = SKSpriteNode(imageNamed: "bg_front")
        bg.size = self.size
        bg.position = sun.position
        self.addChild(bg)
        
        // position is the center point of something
        // look up texture atlassk
        
        player1.body.position = CGPointMake(200, 200)
        self.addChild(player1.body)
//        player1.body.physicsBody?.contactTestBitMask = 1
        
        player2.body.position = CGPointMake(200, 200)
        self.addChild(player2.body)
        
        var floor = SKShapeNode(rectOfSize: CGSizeMake(SCREEN_WIDTH, 10))
        floor.fillColor = UIColor.darkGrayColor()
        floor.position = CGPointMake(SCREEN_WIDTH / 2.0, 5) // a postion on a node starts on the bottom left and its on the center point of the object, unlike with Views
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.frame.size)
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.dynamic = false
//        floor.physicsBody?.categoryBitMask = 1
        self.addChild(floor)

        var floor1 = SKSpriteNode(imageNamed: "cloud")
        floor1.size = CGSizeMake(212, 55)
        floor1.position = CGPointMake(SCREEN_WIDTH / 2.0, 120) // a postion on a node starts on the bottom left and its on the center point of the object, unlike with Views
        floor1.physicsBody = SKPhysicsBody(rectangleOfSize: floor1.frame.size)
        floor1.physicsBody?.affectedByGravity = false
        floor1.physicsBody?.dynamic = false
//        floor.physicsBody?.categoryBitMask = 1
        self.addChild(floor1)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println(contact.bodyA)
        println(contact.bodyB)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
//        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame) // puts a boundary on the frame
        self.physicsWorld.contactDelegate = self
        
        
        var floor = SKShapeNode(rectOfSize: CGSizeMake(SCREEN_WIDTH, 10))
        floor.fillColor = UIColor.darkGrayColor()
        floor.position = CGPointMake(SCREEN_WIDTH / 2.0, 5) // a postion on a node starts on the bottom left and its on the center point of the object, unlike with Views
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.frame.size)
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.dynamic = false
//        floor.physicsBody?.categoryBitMask = 1
        self.addChild(floor)

        
        player1.body.position = CGPointMake(200, 200)
        self.addChild(player1.body)
//        player1.body.physicsBody?.contactTestBitMask = 1

       
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println(contact.bodyA)
        println(contact.bodyB)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

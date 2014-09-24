//
//  Character.swift
//  SAMK
//
//  Created by KaL on 9/22/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit
import SpriteKit

class Character: NSObject {
    
    var body: SKShapeNode! // shape nodes allow to do a rectangular object
    // the body will be the character, right now the node does not have a frame size
    
    var direction: CGFloat = 1 // this is right in the aspect of right being 1 and left being -1
    
    override init() {
        super.init()
        
        body = SKShapeNode(rectOfSize: CGSizeMake(40, 70))
        body.fillColor = UIColor.whiteColor()
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.frame.size)
    }
   
    
    func moveLeft(){
        direction = -1
        body.physicsBody?.applyImpulse(CGVectorMake(-40.0, 0.0))
    }
    
    func moveRight(){
        direction = 1
        body.physicsBody?.applyImpulse(CGVectorMake(40.0, 0.0))
    }
    
    func jump(){
        body.physicsBody?.applyImpulse(CGVectorMake(0.0, 50.0))

    }
    
    func fire(){
        
        //        var kamehameha = SKShapeNode(rectOfSize: CGSizeMake(100, 100), cornerRadius: 50)
        
        // adding a particle to Sk
        var particlePath = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")
        //        var kamehameha = NSKeyedUnarchiver.unarchiveObjectWithFile(particlePath!) as SKEmitterNode
        
        
        /// longer method
        var sceneData = NSData.dataWithContentsOfFile(particlePath!, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(SKEmitterNode.self, forClassName: "SKEditorScene")
        let node = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as SKEmitterNode?
        archiver.finishDecoding()
        
        var kamehameha = node!
        
        //// longer method
        
        //        kamehameha.fillColor = UIColor.cyanColor()
        kamehameha.position = CGPointMake(body.position.x + 50 * direction, body.position.y)
        kamehameha.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        kamehameha.physicsBody?.affectedByGravity = false
        
//        scene.addChild(kamehameha)
        
        // a node should have a parent node
        body.parent?.addChild(kamehameha)
        
        kamehameha.physicsBody?.applyImpulse(CGVectorMake(200.0 * direction, 0.0))
        
        body.physicsBody?.applyImpulse(CGVectorMake(-20.0 * direction, 0.0))
        
        
    }
}

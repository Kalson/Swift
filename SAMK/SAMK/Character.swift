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
    
    var direction = 1 // right being and left being -1
    
    override init() {
        super.init()
        
        body = SKShapeNode(rectOfSize: CGSizeMake(40, 70))
        body.fillColor = UIColor.whiteColor()
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.frame.size)
    }
   
}

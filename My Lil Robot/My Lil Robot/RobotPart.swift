//
//  RobotPart.swift
//  My Lil Robot
//
//  Created by KaL on 9/5/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class RobotPart: UIView {
   
    func addPartToRobotAtPoint(robot: UIView, point: CGPoint){
        // the superclass gives the subclass object
        
        // can't add a subview to NSObject
        
        // everything is a subview
        
        // robot = robotbody
        
        robot.addSubview(self)
        self.center = point
        
    }
}

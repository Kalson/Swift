//
//  ViewController.swift
//  My Lil Robot
//
//  Created by KaL on 9/5/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // sub class is of the super class when created and methods are mostly ran on the instance, some on the superclass and subclass
                            
    override func viewDidLoad() {
        super.viewDidLoad() // called when the view is being created
        // Do any additional setup after loading the view, typically from a nib.
        
        var robotBody = UIView(frame: CGRectMake(0, 0, 320, 480))
        var roller = RoboRoller()
        
        // class () -> alloc/init
        
        roller.addPartToRobotAtPoint(robotBody, point: CGPointMake(0, 480))
        
        var arcReactor = RobotArcReactor()
        
        arcReactor.addPartToRobotAtPoint(robotBody, point: CGPointMake(160, 240))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Re.Action
//
//  Created by KaL on 9/18/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let timerBar = UIView()
    let SCREEN_HEIGTH = UIScreen.mainScreen().bounds.size.height
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width

    
    var buttons = [UIButton(),UIButton(),UIButton()]
    // the array is much faster since the array knows that their only buttons in it
    
//    var buttons = [UIButton](count: 3, repeatedValue: UIButton()) // a forloop within an array (didn't work)
    
    var scoreLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blueColor()
        
//        var i = buttons.count
        for i in 0..<buttons.count {
            
            var button = buttons[i]
            var size:CGFloat = 100.0 // bc u can't divide a float from a int
            
            var x = (SCREEN_WIDTH / 2.0) - (size / 2.0)
            var y = (SCREEN_HEIGTH / 2.0) - (size / 2.0) - (CGFloat(i - 1) * (size + 20)) // an actual number can be any time of primitive type based on the situation like the 20 or 1
            
            button.frame = CGRectMake(x, y, size, size)
            button.layer.cornerRadius = size / 2.0
            button.backgroundColor = UIColor(red: 0.349, green: 0.875, blue: 0.729, alpha: 1.0) //class methods look like this now
            self.view .addSubview(button)
            
            println(button)
            
            // the gradient can have more than two colors
            
            var topColor = 
            
           
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


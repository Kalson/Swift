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
    var timer: NSTimer?

    
    var buttons = [UIButton(),UIButton(),UIButton()]
    // the array is much faster since the array knows that their only buttons in it
    
//    var buttons = [UIButton](count: 3, repeatedValue: UIButton()) // a forloop within an array (didn't work)
    
    var scoreLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blueColor()
        
        // the gradient can have more than one colors
        
        // first color
        var topColor = UIColor(red: 0.910, green: 0.976, blue: 0.333, alpha: 1.0)
        
        // second color
        var bottomcColor = UIColor(red: 0.973, green: 0.204, blue: 0.333, alpha: 1.0)
        
        // array of colors in gradient
        var gradientColors:[AnyObject] = [topColor.CGColor, bottomcColor.CGColor]
        
        // array of locations for colors in gradient
        var gradientLocations = [0.0,1.0]
        
        // gradient layer
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        
        gradientLayer.startPoint = CGPointMake(0.6, -0.1)
        gradientLayer.endPoint = CGPointMake(0.4, 1.1)

        
        
        // add colors to gradient layer
        gradientLayer.colors = gradientColors
        
        // add locatios to gradient color
        gradientLayer.locations = gradientLocations
        
        // add gradient to view layer as background
        self.view.layer.addSublayer(gradientLayer)
        
//        var i = buttons.count
        for i in 0..<buttons.count {
            
            var button = buttons[i]
            var size:CGFloat = 100.0 // bc u can't divide a float from a int
            
            var x = (SCREEN_WIDTH / 2.0) - (size / 2.0)
            var y = (SCREEN_HEIGTH / 2.0) - (size / 2.0) + (CGFloat(i - 1) * (size + 20)) // an actual number can be any time of primitive type based on the situation like the 20 or 1
            
            button.frame = CGRectMake(x, y, size, size)
            button.layer.cornerRadius = size / 2.0
            button.backgroundColor = UIColor.whiteColor()
//            button.backgroundColor = UIColor(red: 0.349, green: 0.875, blue: 0.729, alpha: 1.0) //class methods look like this now
            
            button.tag = i // so we know which button were tapping
            button.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
            
            self.view .addSubview(button)
        }
        
        timerBar.backgroundColor = UIColor.whiteColor()
        timerBar.frame = CGRectMake(0, 0, 0, 6)
        self.view.addSubview(timerBar)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resetTimerWithSpeed(speed: Double){
//        timer.invalidate() // stops the timer
        
        if timer != nil { timer!.invalidate() } // only running the invalidate if the timer is actually there
        
        timer = NSTimer(timeInterval: speed, target: self, selector: Selector("timerDone"), userInfo: nil, repeats: false)
        
        timerBar.frame.size.width = SCREEN_WIDTH
        
        UIView.animateWithDuration(speed, animations: { () -> Void in
            
        })
        
    
    }
    
    func timerDone() {
        
    }
    
    func buttonTapped(button: UIButton){
        println(button.tag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

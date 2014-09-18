//
//  ViewController.swift
//  Re.Action
//
//  Created by KaL on 9/18/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit
import GameKit

let SCREEN_HEIGTH = UIScreen.mainScreen().bounds.size.height
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width

class ViewController: UIViewController {
    
    
    var timer: NSTimer?
    let timerBar = UIView()
    
    let scoreLabel = UILabel()
    
    var currentScore = 0
    var buttonToTap = 0
    
    var player = GKLocalPlayer.localPlayer()
    var allLeaderboards: [String:GKLeaderboard] = Dictionary()
    
    let buttons = [UIButton(),UIButton(),UIButton()]
    // the array is much faster since the array knows that their only buttons in it
    
    //    var buttons = [UIButton](count: 3, repeatedValue: UIButton()) // a forloop within an array (didn't work)
    
    
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
            
            button.alpha = 0.6
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
        
        //        self.resetTimerWithSpeed(5)
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
        // nano per sec, 64 bit int with 3 seconds
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                        self.runLevel()
        }
        
        
        // add a listener for autheication change
        var nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: Selector("authChanged"), name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
        
        if player.authenticated == false {
            // closure is a block
            // authenticatehandeler(for gameCenter) is a block
            
            player.authenticateHandler = { (viewController, error) -> Void in
                if viewController != nil {
                    self.presentViewController(viewController, animated: true, completion: nil)
                }
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resetTimerWithSpeed(speed: Double){
        //        timer.invalidate() // stops the timer
        
        if timer != nil { timer!.invalidate() } // only running the invalidate if the timer is actually there
        
        timer = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: Selector("timerDone"), userInfo: nil, repeats: false)
        
        timerBar.layer.removeAllAnimations()
        timerBar.frame.size.width = SCREEN_WIDTH
        
        // animates the timer bar
        UIView.animateWithDuration(speed, animations: { () -> Void in
            self.timerBar.frame.size.width = 0
        })
        
        UIView.animateWithDuration(speed, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.timerBar.frame.size.width = 0
            }) { (succeeded:Bool) -> Void in
                
        }
    }
    
    func timerDone() {
        println("game over")
    }
    
    func buttonTapped(button: UIButton){
        println(button.tag)
        
        if buttonToTap == button.tag {
            currentScore++
            runLevel()
        } else {
            var time = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
            // nano per sec, 64 bit int with 3 seconds
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                self.runLevel()
            }
            
            println("Fail")
            currentScore = 0
            // when u fail
        }
    }
    
    func runLevel(){
        buttonToTap = Int(arc4random_uniform(3)) // b/c it returns a unsigned int that y were converting it to a Int
        var button = buttons[buttonToTap]
        button.alpha = 1.0
        
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            button.alpha = 0.6
//        })
        
     //   if last part parameter of the block is outside, if only one parameter u don't need ()
        UIView.animateWithDuration(1.0, delay: 0, options: .CurveLinear, animations: { () -> Void in
//            self.timerBar.frame.size.width = 0
            button.alpha = 0.6

            }) { (succeeded:Bool) -> Void in
                
        }
        
        resetTimerWithSpeed(10)
    }
    
    func authChanged(){
        GKLeaderboard.loadLeaderboardsWithCompletionHandler { (leaderBoards, error) -> Void in
            
            for leaderboard in leaderBoards as [GKLeaderboard] {
                // before it was just an array of any object, now its an array of GKleaderboard
                var identifier = leaderboard.identifier
                
                // setting the leaderboard as a value based on this key
                self.allLeaderboards[identifier] = leaderboard
            }
            
        }
    }
    
    func submitScore(){
//        var player = GKPlayer()
        
        var scoreReporter = GKScore(leaderboardIdentifier: "total_taps")
        scoreReporter.value = Int64(currentScore)
        scoreReporter.context = 0
        
        GKScore.reportScores([scoreReporter], withCompletionHandler: { (error) -> Void in
            println("score reported")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


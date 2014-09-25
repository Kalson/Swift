//
//  StatusVC.swift
//  SAMK
//
//  Created by KaL on 9/22/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

class StatusVC: UIViewController {
    
    let player1HP = UIView()
    let player2HP = UIView()
    
    let timelabel = UILabel()
    
    var scene: GameScene!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
        
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50)
//        self.view.backgroundColor = UIColor.redColor()
        
        timelabel.frame = CGRectMake(0, 5, 80, 40)
//        timelabel.backgroundColor = UIColor.whiteColor()
        timelabel.center = CGPointMake(self.view.center.x, timelabel.center.y)
        timelabel.textAlignment = .Center
        timelabel.text = "00:00"
        self.view.addSubview(timelabel)
        
        player1HP.frame = CGRectMake(20, 20, (SCREEN_WIDTH - 160) / 2.0, 10)
        player1HP.backgroundColor = UIColor.greenColor()
        self.view.addSubview(player1HP)
        
        player2HP.frame = CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH - 160) / 2.0 - 20, 20, (SCREEN_WIDTH - 160) / 2.0, 10)
        player2HP.backgroundColor = UIColor.greenColor()
        self.view.addSubview(player2HP)
        
        setHealthForPlayer(MAX_HP, player: 0)
        setHealthForPlayer(MAX_HP, player: 1)

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName("healthUpdate", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            let hurtPlayer = notification.userInfo!["player"] as Character
            
            let player = (hurtPlayer == self.scene.player1) ? 0 : 1
            
            self.setHealthForPlayer(hurtPlayer.CurrentHP, player: player)
        }
    }
    
    func setHealthForPlayer(health: Int, player: Int) {
        
        let healthF = CGFloat(health)
        let maxF = CGFloat(MAX_HP)
        
        
        switch player {
        case 0 :
            for view in player1HP.subviews as [UIView]{
                view.removeFromSuperview()
            }
            // sets the frame of the health
            var lostHealth = UIView(frame: CGRectMake(0, 0, player1HP.frame.size.width / maxF * healthF , 10))
            
            lostHealth.backgroundColor = UIColor.redColor()
            player1HP.addSubview(lostHealth)
            
        default :
            for view in player2HP.subviews as [UIView]{
                view.removeFromSuperview()
            }
            
            var lostHealth = UIView(frame: CGRectMake(player2HP.frame.size.width / maxF * healthF, 0, player2HP.frame.size.width - player2HP.frame.size.width / maxF * healthF , 0))
            lostHealth.backgroundColor = UIColor.redColor()
            player2HP.addSubview(lostHealth)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

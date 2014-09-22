//
//  StatusVC.swift
//  SAMK
//
//  Created by KaL on 9/22/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

class StatusVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50)
        self.view.backgroundColor = UIColor.redColor()

        // Do any additional setup after loading the view.
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

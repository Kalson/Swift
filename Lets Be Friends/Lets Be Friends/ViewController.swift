//
//  ViewController.swift
//  Lets Be Friends
//
//  Created by KaL on 8/27/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // these are initing up here
    var loginHolder = UIView()
    var signupHolder = UIView()
    var buttonsHolder = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Parse.setApplicationId("Vs7IjCMSjlbHErBCJHF2TOLCbMfmsqDmOcO2FLwr", clientKey: "wc9zzH2gzTrftpHvjs5tRM9Syn64DVt8uG08ssJM")
        
        var signupButton = UIButton(frame: CGRectMake(10, 10, 145, 40))
        signupButton.setTitle("signup", forState: .Normal)
        signupButton.backgroundColor = UIColor(red: 1, green: 0.3, blue: 0, alpha: 1)
        signupButton.addTarget(self, action: Selector("showSignUp"), forControlEvents: .TouchUpInside)

        self.view .addSubview(signupButton)
        
        var loginButton = UIButton(frame: CGRectMake(165, 10, 145, 40))
        loginButton.setTitle("login", forState: .Normal)
        loginButton.backgroundColor = UIColor(red: 0, green: 0.4, blue: 1, alpha: 1)
//        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.addTarget(self, action: Selector("showLogin"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(loginButton)
    }
    
    // this is the same
    // func showLogin -> Void()
    func showLogin()
    {
        loginHolder.removeFromSuperview()
        
        println("show login")

        loginHolder.frame = self.view.frame;
        
        var usernameField = UITextField(frame: CGRectMake(10, 200, 300, 40))
        usernameField.placeholder = "Username"
        loginHolder.addSubview(usernameField)

        var passwordField = UITextField(frame: CGRectMake(10, 250, 300, 40))
        passwordField.placeholder = "Password"
        passwordField.secureTextEntry = true
        loginHolder.addSubview(passwordField)
        
        var submitLogin = UIButton(frame: CGRectMake(10, 300, 300, 40))
        submitLogin.setTitle("submit", forState: .Normal)
        submitLogin.backgroundColor = UIColor.lightGrayColor()
        submitLogin.addTarget(self, action: Selector("login"), forControlEvents: .TouchUpInside)
        loginHolder.addSubview(submitLogin)
        
        self.view.addSubview(loginHolder)
        
        fieldData = [
            "Username":usernameField,
            "Password":passwordField
            
        ]
    }
    
    func showSignUp()
    {
        signupHolder.frame = self.view.frame;
        
        loginHolder.removeFromSuperview()

        var emailField = UITextField(frame: CGRectMake(10, 159, 300, 40))
        emailField.placeholder = "Email"
        emailField.keyboardType = UIKeyboardType.EmailAddress
        emailField.keyboardType = .EmailAddress

        signupHolder.addSubview(emailField)
        
        var usernameField = UITextField(frame: CGRectMake(10, 200, 300, 40))
        usernameField.placeholder = "Username"
        signupHolder.addSubview(usernameField)
        
        var passwordField = UITextField(frame: CGRectMake(10, 250, 300, 40))
        passwordField.placeholder = "Password"
        passwordField.secureTextEntry = true
        signupHolder.addSubview(passwordField)
        
        var submitSignUp = UIButton(frame: CGRectMake(10, 300, 300, 40))
        submitSignUp.setTitle("submit", forState: .Normal)
        submitSignUp.backgroundColor = UIColor.lightGrayColor()
        submitSignUp.addTarget(self, action: Selector("signup"), forControlEvents: .TouchUpInside)
        signupHolder.addSubview(submitSignUp)


        
        // this is a dictionary
        fieldData = [
            "Email":emailField,
            "Username":usernameField,
            "Password":passwordField

        ]
        
        self.view.addSubview(signupHolder)
    }
    
    // this is a dictionary property
    
    // anyobject doesn't work with .text
    var fieldData: [String:UITextField]!
    
    func login()
    {
        println("you are logged in")
//        var user = PFUser.logInWithUsername(fieldData["Username"]!.text, password: fieldData["Password"]!.text)
        
        PFUser.logInWithUsernameInBackground(fieldData["Username"]!.text, password: fieldData["Password"]!.text, block: { (user: PFUser!, error: NSError!) -> Void in
            self.loginHolder.removeFromSuperview()
            
            if user != nil
            {
                println(user.objectForKey("team"))
                
                // if the user doesn't have a team, use this
                if user.objectForKey("team") == nil
                {
                    self.showTeams()
                } else {
                    // if you already have a team
                    self.attackMode()
                }
            }
        })
    }
    
    func signup()
    {
        var user = PFUser()
        user.email = fieldData["Email"]!.text
        user.password = fieldData["Password"]!.text
        user.username = fieldData["Username"]!.text
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError!) -> Void in
            if succeeded {
                println("you are signed in")
                
                // use self here for the property because of the block
                self.signupHolder.removeFromSuperview()
                self.showTeams()
                
            } else {
                println(error)
            }
        }
        
    }
    
    var teamHolder = UIView()
    let halfheight = UIScreen.mainScreen().bounds.size.height/2.0
    
    
    func showTeams()
    {
        teamHolder.frame = self.view.frame
        
        var redTeam = UIButton(frame: CGRectMake(0, 0, 320, halfheight))
        redTeam.backgroundColor = UIColor.redColor()
        redTeam.addTarget(self, action: Selector("chooseTeam:"), forControlEvents: .TouchUpInside)
        redTeam.tag = 1
        teamHolder.addSubview(redTeam)
        
        var blueTeam = UIButton(frame: CGRectMake(0, halfheight, 320, halfheight))
        blueTeam.backgroundColor = UIColor.blueColor()
        blueTeam.addTarget(self, action: Selector("chooseTeam:"), forControlEvents: .TouchUpInside)
        teamHolder.addSubview(blueTeam)
        
        self.view.addSubview(teamHolder)
    }
    
    func chooseTeam(teamButton:UIButton)
    {
        var user = PFUser.currentUser()
        
        switch teamButton.tag{
        case 1:
            user.setObject("red", forKey: "team")
            println("red team")
        default:
            user.setObject("blue", forKey: "team")
            println("blue team")
        }
        user.saveInBackground()
        teamHolder.removeFromSuperview()
        
        attackMode()
    }
    
    func attackMode()
    {
        var installation = PFInstallation.currentInstallation()
        
        installation.setObject(PFUser.currentUser(), forKey: "user")
        installation.saveInBackground()
        
        var attackButton = UIButton(frame: CGRectMake(10, 200, 300, 40))
        
        attackButton.setTitle("Attack", forState: .Normal)
        attackButton.backgroundColor = UIColor.blackColor()
        attackButton.addTarget(self, action: Selector("attack"), forControlEvents: .TouchUpInside)
        self.view.addSubview(attackButton)
    }
    
    func attack()
    {
        var user = PFUser.currentUser()
        
        // condition variable statement - if team is red, we want the blue team, else red team
        var otherteam = (user.objectForKey("team") as String == "red") ? "blue" : "red"
        
        var userQuery = PFUser.query()
        userQuery.whereKey("team", equalTo: otherteam)
//
//        userQuery.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
//            println("user\(objects)")
//        }
//        

        var deviceQuery = PFInstallation.query()
        deviceQuery.whereKey("user", matchesQuery: userQuery)
        // ^ this user refers to the column
     
        var push = PFPush()
        push.setQuery(userQuery)
        push.setMessage("You have been saved")
        push.sendPushInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


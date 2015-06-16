//
//  MessageCell.swift
//  txt4ru
//
//  Created by Rene Candelier on 9/12/14.
//  Copyright (c) 2014 Novus Mobile. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class MessageCell: UITableViewCell {

    
    var messageInfo: PFObject!{
        willSet(info){
            
            var sender = info["sender"] as! PFUser
            var me = PFUser.currentUser()
            
            println("change info")
            
            if sender.objectId == me.objectId{
                bubble.backgroundColor = UIColor (red:0.984, green:0.231, blue:0.031, alpha:1.0)
                bubble.frame = CGRectMake(5, 5, 200, 40)
                messageLabel.textAlignment = NSTextAlignment.Left
                dateLabel.textAlignment = .Left
            }else{
                bubble.backgroundColor = UIColor (red:0.071, green:0.604, blue:1.000, alpha:1.0)
                bubble.frame = CGRectMake(SCREEN_WIDTH - 205, 5, 200, 40)
                messageLabel.textAlignment = .Right
                dateLabel.textAlignment = .Right
            }
            
            
            // connects the messageLabel to the content that was created before
            messageLabel.text = info["content"] as? String
            
            var formatter = NSDateFormatter()
            formatter.dateFormat = "EEE dd, YYYY - HH:mm"
            
            var date = (info.createdAt != nil) ? info.createdAt : NSDate()
            dateLabel.text = formatter.stringFromDate(date)
            
            println(info["read"])
            
            
            var receiver = info["receiver"] as! PFUser
            
            if receiver.objectId != me.objectId{
            
                if info["read"] as! Bool == false {
                    
                    println("read")
                    
                    UIApplication.sharedApplication().applicationIconBadgeNumber--
                    info["read"] = true
                    info.saveInBackground()
                    
                    
                    var installation = PFInstallation.currentInstallation()
                    var badgeCount = installation.badge
                    if badgeCount > 0 {
                    installation.badge = badgeCount - 1
                    installation.saveInBackground()
                    }
                }
            }
        
        }
    }
    
    var bubble = UIView(frame: CGRectMake(5,5,200,40))
    var messageLabel = UILabel(frame: CGRectMake(5, 5, 190, 30))
    var dateLabel = UILabel(frame: CGRectMake(10, 45, 300, 10))

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        println("init")
        
        
        bubble.layer.cornerRadius = 10
            
        self.contentView.addSubview(bubble)
        
        
        messageLabel.textColor = UIColor.whiteColor()
        
        dateLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20)

        bubble.addSubview(messageLabel)
        
        
        dateLabel.textColor = UIColor.lightGrayColor()
        
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        
        self.contentView.addSubview(dateLabel)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

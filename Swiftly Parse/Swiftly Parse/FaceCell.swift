//
//  FaceCell.swift
//  Swiftly Parse
//
//  Created by KaL on 8/26/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class FaceCell: UITableViewCell {

    @IBOutlet weak var faceView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var someHeight = SCREEN_HEIGHT - 100
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

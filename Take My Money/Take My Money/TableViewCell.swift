//
//  TableViewCell.swift
//  Take My Money
//
//  Created by KaL on 9/25/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit
import StoreKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var product: SKProduct! {
        
        // setter method for product
        set(product){
            self.nameLabel.text = product.localizedTitle
            self.priceLabel.text = "\(product.priceLocale.objectForKey(NSLocaleCurrencySymbol)!)\(product.price)" // this is StringWithFormat
        }
        // when ur overiding setter methods in swift, u must use a getter method too
        get{
            return self.product
        }
    }
    
    @IBAction func buyProduct(sender: UIButton) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

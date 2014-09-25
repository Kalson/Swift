//
//  TableViewCell.swift
//  Take My Money
//
//  Created by KaL on 9/25/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit
import StoreKit

class TableViewCell: UITableViewCell, SKPaymentTransactionObserver {
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
        
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        
        for transaction in transactions as [SKPaymentTransaction] {
            
            println(transaction.payment.productIdentifier)
            
            switch(transaction.transactionState) {
                
            case SKPaymentTransactionState.Purchased :
                println("Purchased")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            case SKPaymentTransactionState.Purchasing :
                println("Purchasing")
                
            case SKPaymentTransactionState.Deferred :
                println("Deferred")
                
            case SKPaymentTransactionState.Restored :
                println("Restored")
                
            case SKPaymentTransactionState.Failed :
                println("Failed : \(transaction.error)")
                
                // if use a switch with all posible outcomes of an enum u don't need a default
                
            }
        }
        
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

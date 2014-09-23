//
//  PlayerConnect.swift
//  SAMK
//
//  Created by KaL on 9/22/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

let kMCSessionMaximumNumberOfPeers = 1
let kMCSessionMinimumNumberOfPeers = 1

class PlayerConnect: NSObject, MCSessionDelegate{
    
    var scene: GameScene!
    
    let serviceType = "stufffedAnimal"
    
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID! // id for ur self
    
    @IBOutlet var chatView: UITextView!
    @IBOutlet var messageField: UITextField!
    
    override init() {
        super.init() // viewDidLoad does not work on a NSOBject
        
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID) // creating a new session w/ our peer ID
        self.session.delegate = self
        
        // create the browser viewcontroller with a unique service name
        self.browser = MCBrowserViewController(serviceType:serviceType,
            session:self.session)
        
        self.browser.maximumNumberOfPeers = 1
                
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
            discoveryInfo:nil, session:self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("closeSession"), name: UIApplicationWillResignActiveNotification, object: nil)
        
    }
    
    func closeSession(){
        self.session.disconnect()
    }
    
    func sendPlayerInfo(info: NSDictionary){
        // turn the dictionary into data by archiving it
        var infoData = NSKeyedArchiver.archivedDataWithRootObject(info)
        
        // then send data to peers
        self.session.sendData(infoData, toPeers: self.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: nil)
    }
    
    // can only have 1 service type per session
    
    @IBAction func sendChat(sender: UIButton) {
        // Bundle up the text in the message field, and send it off to all
        // connected peers
        
        let msg = self.messageField.text.dataUsingEncoding(NSUTF8StringEncoding,
            allowLossyConversion: false)
        
        var error : NSError?
        
        self.session.sendData(msg, toPeers: self.session.connectedPeers,
            withMode: MCSessionSendDataMode.Unreliable, error: &error)
        
        if error != nil {
            print("Error sending data: \(error?.localizedDescription)")
        }
        
        self.updateChat(self.messageField.text, fromPeer: self.peerID)
        
        self.messageField.text = ""
    }
    
    func updateChat(text : String, fromPeer peerID: MCPeerID) {
        // Appends some text to the chat view
        
        // If this peer ID is the local device's peer ID, then show the name
        // as "Me"
        var name : String
        
        switch peerID {
        case self.peerID:
            name = "Me"
        default:
            name = peerID.displayName
        }
        
        // Add the name to the message and display it
        let message = "\(name): \(text)\n"
        self.chatView.text = self.chatView.text + message
        
    }
    
    
    func session(session: MCSession!, didReceiveData data: NSData!,
        fromPeer peerID: MCPeerID!)  {
            // Called when a peer sends an NSData to us
            
            // This needs to run on the main queue
            dispatch_async(dispatch_get_main_queue()) {
                
                // recieving info from data
                var info = NSKeyedUnarchiver.unarchiveObjectWithData(data) as NSDictionary
                
                if info["moveLeft"] != nil {
                    self.scene.player2.moveLeft()
                }
                
                if info["moveRight"] != nil {
                    self.scene.player2.moveRight()
                }
                
                if info["jump"] != nil {
                    self.scene.player2.jump()
                }
                
                if info["fire"] != nil {
                    self.scene.player2.fire()
                }
                
                // take data and move player2
            }
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession!,
        didStartReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!)  {
            
            // Called when a peer starts sending a file to us
    }
    
    func session(session: MCSession!,
        didFinishReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!,
        atURL localURL: NSURL!, withError error: NSError!)  {
            // Called when a file has finished transferring from another peer
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!,
        withName streamName: String!, fromPeer peerID: MCPeerID!)  {
            // Called when a peer establishes a stream with us
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!,
        didChangeState state: MCSessionState)  {
            // Called when a connected peer changes state (for example, goes offline)
            
            
            if state == MCSessionState.NotConnected {
                session.disconnect()
            }
            
            println(peerID.displayName)
            println(state)

            
            
    }
   
}









//
//  ViewController.swift
//  My Data
//
//  Created by KaL on 9/2/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit
import CoreData

// Core data loads the cache of the phone (especically essential if u have no wifi)

// with core data you limit the query

class ViewController: UIViewController {
    
       let API = "http://ancient-taiga-9634.herokuapp.com/"
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextField!
    
    @IBAction func postNew(sender: AnyObject) {
        
        // urlstring connecting to post
        let myPostURL = API + "posts"
        
        // ? -> a query string identifier
        let newPostURL = API + "posts?post[title]=\(titleField.text)&post[content]=\(contentField.text)"
        
        let encodedString = newPostURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        // we want to set a value for the header field
        var request = NSMutableURLRequest(URL: NSURL(string: encodedString!))
        
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        request.HTTPMethod = "POST"
        
        // makes the connection request
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            // converts the json data to object C objects
            let info: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)!
            
            //// loop through here somewhere (i think)
            
            // ? make the object optional
            // an optonal is a wrapper bool value (true or false(bool value), to check if it there or not. if there is a value (its true)
            // ! pulls it out of the optional
            
            println(info)
            
        }
    }
    
    @IBAction func getMyPosts(sender: AnyObject) {
        
        // urlstring connecting to post
        let myPostURL = API + "posts"
        
        // we want to set a value for the header field
        var request = NSMutableURLRequest(URL: NSURL(string: myPostURL))
        
        // we want to set a value for the header field -> thats why we using a mutable request (to change something on the request)
        // extra dedfinistion for a rewuest (additonal option to change a request to make more dynamic -> like a note on how u want ur mail deliveres)
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        
        // makes the connection request
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            // converts the json data to object C objects
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            println(posts)
            
        }
    }
    
    @IBAction func getAllPosts(sender: AnyObject) {
        
        let allPostsURL = API + "posts"
        
        // make the request (the actual line making the request)
        let request = NSURLRequest(URL: NSURL(string: allPostsURL))
        
        // makes the connection request
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            // converts the json data to object C objects
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            println(posts)
        }
    }
    
    // MARK: - Core Data Fetch
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appD = UIApplication.sharedApplication().delegate as AppDelegate
        
        // entity (is like a data table) holds all your data
        var entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: appD.managedObjectContext!)

        var postObject = NSEntityDescription.insertNewObjectForEntityForName("Post", inManagedObjectContext: appD.managedObjectContext!) as NSManagedObject
        
        // set the structure before, now were set the values
        postObject.setValue("jo@theironyard.com", forKey: "user")
        postObject.setValue("This is a cool title", forKey: "title")
        
        ////// new stuff
        
//        postObject.setValue(info?.objectForKey("user"), forKey: "user")

        appD.saveContext()
        
        //// fetch
        
        // creates the fetch
        var fetchRequest = NSFetchRequest()
        
        // add the entity = Post (fetch request is only looking for entity:Post)
        fetchRequest.entity = entity
        
        // query parameters
        var predicate = NSPredicate(format: "user = 'jo@theironyard.com'")
        fetchRequest.predicate = predicate
        
        // sorts returned objects based on key (posted_at)
        var sortDescriptor = NSSortDescriptor(key: "posted_at", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // fetches save data
        var fetchedObjects = appD.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil)
    
        println("fetched = \(fetchedObjects)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


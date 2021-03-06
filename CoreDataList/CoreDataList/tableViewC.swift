//
//  tableViewC.swift
//  CoreDataList
//
//  Created by KaL on 11/6/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit
import CoreData

class tableViewC: UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    var people = [NSManagedObject]() // create the manageobject based on Entity
    
    @IBAction func addButtonAction(sender: AnyObject) {
        
        let myAlert = UIAlertController(title: "New Name?", message: "Add new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action:UIAlertAction) -> Void in
            let textField = myAlert.textFields!.first
            textField?.delegate = self
            self.saveName(textField!.text!)
            self.tableView.reloadData()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.Default) { (action:UIAlertAction) -> Void in
            
          
        }
        
        myAlert.addTextFieldWithConfigurationHandler({ (textfield: UITextField) -> Void in
            
        })
        
        myAlert.addAction(saveAction)
        myAlert.addAction(cancelAction)
        
        
        
        presentViewController(myAlert, animated: true, completion: nil)
        
        print("The people array = \(self.people)")
        
    }
    
    func saveName(name: String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // pull up the appDelegate
        let manageContext = appDelegate.managedObjectContext // reference the manageobject context
        
        // instantiate the entity with the manage object context
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: manageContext)
        
        // instantiate the managed object and insert it into the manage object context
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: manageContext)
        
        // set the value of name attribute for the manage Object
        person.setValue(name, forKey: "name")
        
        do {
            try manageContext.save() // save any changes into the context
            
            people.append(person) // insert the manage object into the people array
        } catch let error as NSError {
            print("Could not save \(error),\(error.userInfo)")
        }
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // pull up the appDelegate
        let manageContext = appDelegate.managedObjectContext // reference the manageobject context
        
        // instantiate fetch request and fetch the entity
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results = try manageContext.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError{
            print("Could not fetch \(error),\(error.userInfo))")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let person = people[indexPath.row]
        
        // Configure the cell...
        cell.textLabel?.text = person.valueForKey("name") as? String

        return cell
    }
    
   
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

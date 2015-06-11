//
//  ViewController.swift
//  The Swift List
//
//  Created by KaL on 8/22/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var niceArray = ["Helper Robots","Some Humans"]
    var naughtyArray = ["Invading Aliens","Killer Robots","Jaws"]
    
     let listNameField = UITextField(frame: CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, 40))
    let listOption = UISegmentedControl(frame: CGRectMake(10, 60, UIScreen.mainScreen().bounds.size.width - 20, 40))
    
    let tabBarC = UITabBarController()


    // var is not as fast as a let
    // let is unchangeable variable (inmutable) var = is just like a regular variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(tabBarC.view)
        self.addChildViewController(tabBarC)
        
        let niceList = UITableViewController()
        niceList.title = "Nice"
        niceList.tableView.dataSource = self
        niceList.tableView.delegate = self
        niceList.tableView.tag = 0
        // default for tag is 0
        niceList.tableView .registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        niceList.tabBarItem.image = UIImage(named: "nice")
        
        let naughtyList = UITableViewController()
        naughtyList.title = "Naughty"
        naughtyList.tableView.dataSource = self
        naughtyList.tableView.delegate = self
        niceList.tableView.tag = 1
        naughtyList.tableView .registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        naughtyList.tabBarItem.image = UIImage(named: "naughty")

        let addToList = UIViewController()
        addToList.title = "Add To List"
        
        listNameField.layer.cornerRadius = 10
        listNameField.backgroundColor = UIColor.lightGrayColor()
        addToList.view.addSubview(listNameField)
        
        listOption.tintColor = UIColor.lightGrayColor()
        listOption.insertSegmentWithTitle("Nice", atIndex: 0, animated: true)
        listOption.insertSegmentWithTitle("Naughty", atIndex: 1, animated: true)
        addToList.view.addSubview(listOption)
        
        let addButton = UIButton(frame: CGRectMake(10, 110, UIScreen.mainScreen().bounds.size.width - 20, 40))
        addButton.backgroundColor = addButton.tintColor
        addButton.tintColor = UIColor.whiteColor()
        addButton.setTitle("Add New Item", forState: .Normal)
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: Selector("addNewItem"), forControlEvents: .TouchUpInside)
        addToList.view.addSubview(addButton)

        tabBarC.viewControllers = [niceList,naughtyList,addToList]
    }
    
    func addNewItem() {
//        var itemArray = (Bool(listOption.selectedSegmentIndex)) ? naughtyArray : niceArray
        
//        itemArray += [listNameField.text]
        
        switch(listOption.selectedSegmentIndex){
        case 0:
            niceArray += [listNameField.text]
        case 1:
            naughtyArray.append(listNameField.text)
        default:
            print("default")
        }
        
        tabBarC.viewControllers[listOption.selectedSegmentIndex] as UITableViewController
//        print(itemArray)
        print(niceArray)
        print(naughtyArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return (Bool(tableView.tag)) ? naughtyArray.count : niceArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath) as UITableViewCell
        // or this -> let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath)
        
        // swift already knows that items within the array are array so then "itemArray" is consider an array
       let itemArray = (Bool(tableView.tag)) ? naughtyArray : niceArray
        
        cell.textLabel.text = itemArray[indexPath.row]

        
        return cell
    }


}


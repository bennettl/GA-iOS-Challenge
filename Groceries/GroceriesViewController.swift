//
//  GroceriesViewController.swift
//  Groceries
//
//  Created by Lee Bennett on 5/4/16.
//  Copyright © 2016 Bennett. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddGroceryDelegate, GroceryCellDelegate {

    // MARK: - Properties
    
    var groceries = [
                        Grocery(name: "Eggs", quantity: 2, description: "First step in making an awesome omelete"),
                        Grocery(name: "Bacon", quantity: 3, description: "Because bacon is life"),
                        Grocery(name: "Orange Juice", quantity: 3, description: "Can always use more Vitamin C!!!")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UITableViewDataSource

    // Return how many rows are in a given section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }

    // Return cell at index path
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        // Deqeue GroceryCell
        let cell                = tableView.dequeueReusableCellWithIdentifier("GroceryCell") as! GroceryCell
        
        // Grab the specific grocery
        let grocery             = groceries[indexPath.row]
        
        // Populate cell outlets with indexpath and grocery data
        cell.indexPath          = indexPath
        cell.updateUIWithGroceryItem(grocery)
        
        return cell
    
    }
    
    // MARK: - UITableViewDelegate
    
    // When a cell is tapped, peform the segue that leads to deatil page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("GroceryDetailSegue", sender: self)
    }
    
    // Allows for grocery item deletion with animation
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            groceries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // MARK: - AddGroceryDelegate
    
    // When a grocery item is added, push to array and reload tableview
    func groceryDidAdd(item: Grocery) {
        groceries.append(item)
        tableView.reloadData()
    }
    
    // MARK: - GroceryCellDelegate
    
    // Update the grocery object in array with index path
    func groceryDidUpdateAtIndexPath(indexPath: NSIndexPath, grocery: Grocery) {
        groceries[indexPath.row] = grocery
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        switch segue.identifier!{
            
            case "AddGrocerySegue":
                
                // Set 'GroceriesViewController' as delegate
                let agvc        = segue.destinationViewController as! AddGroceryViewController
                agvc.delegate   = self
            
            case "GroceryDetailSegue":
                
                // Provide 'GroceryDetailViewController' with property
                let gdvc            = segue.destinationViewController as! GroceryDetailViewController
                let selectedGrocery = groceries[tableView.indexPathForSelectedRow!.row]
                gdvc.grocery        = selectedGrocery
            
            default:
                ()
        }
        
    }
    

}

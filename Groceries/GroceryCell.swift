//
//  GroceryCell.swift
//  Groceries
//
//  Created by Lee Bennett on 5/4/16.
//  Copyright © 2016 Bennett. All rights reserved.
//

import UIKit

protocol GroceryCellDelegate{
    
    func groceryDidUpdateAtIndexPath(indexPath: NSIndexPath, grocery: Grocery)
}

class GroceryCell: UITableViewCell {

    // MARK: - Properties
    
    var delegate: GroceryCellDelegate?
    var grocery : Grocery!
    var indexPath: NSIndexPath!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var quantityStepper: UIStepper!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set completed button style
        completedButton.layer.cornerRadius    = completedButton.frame.width / 2.0
        completedButton.layer.borderWidth     = 1.0
        completedButton.layer.borderColor     = UIColor.grayColor().CGColor
    }
    
    // Update outlets with grocery object
    func updateUIWithGroceryItem(item: Grocery){
        
        grocery                         = item
        nameLabel.text                  = item.name
        quantityLabel.text              = "QTY: \(item.quantity)"
        completedButton.backgroundColor = item.completed ? COLOR_COMPLETED : UIColor.whiteColor()
        quantityStepper.value           = Double(item.quantity)
    }
    
    // MARK: - IBActions
    
    // When the stepper changes, update the grocery quantity, outlet, and notify the delegate
    @IBAction func stepperDidChanged(sender: UIStepper) {
        
        grocery.quantity    = Int(sender.value)
        
        quantityLabel.text  = "QTY: \(grocery.quantity)"
    
        delegate?.groceryDidUpdateAtIndexPath(indexPath, grocery: grocery)
    }
    
    // When the completed button is pressed, update the grocery completed status, outlet, and notify the delegate
    @IBAction func completedButtonDidPressed(sender: UIButton) {
        
        grocery.completed               = !grocery.completed
        
        completedButton.backgroundColor = grocery.completed ? COLOR_COMPLETED : UIColor.whiteColor()
        
        delegate?.groceryDidUpdateAtIndexPath(indexPath, grocery: grocery)
    }
    

}

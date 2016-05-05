//
//  GroceryDetailViewController.swift
//  Groceries
//
//  Created by Lee Bennett on 5/4/16.
//  Copyright © 2016 Bennett. All rights reserved.
//

import UIKit

class GroceryDetailViewController: UIViewController {

    // MARK: - Properties
    
    var grocery: Grocery!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Populate outets with grocery data
        nameLabel.text          = grocery.name
        quantityLabel.text      = "\(grocery.quantity)"
        descriptionLabel.text   = grocery.description
        completedLabel.text = grocery.completed ? "Yes" : "No"
        
    }

}

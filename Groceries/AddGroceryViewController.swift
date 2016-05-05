//
//  AddGroceryViewController.swift
//  Groceries
//
//  Created by Lee Bennett on 5/4/16.
//  Copyright © 2016 Bennett. All rights reserved.
//

import UIKit

protocol AddGroceryDelegate{
    
    // Delegate will be notify when grocery item is added
    func groceryDidAdd(item: Grocery)
}

class AddGroceryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    // MARK: - Properties
    
    let TAG_NAME_TEXTFIELD      = 0
    let TAG_QUANTITY_TEXTFIELD  = 1
    
    var delegate: AddGroceryDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    // When the text field returns, switch to the appropriate text field/view to become first responder
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.tag == TAG_NAME_TEXTFIELD{
            
            quantityTextField.becomeFirstResponder()
            
        } else if textField.tag == TAG_QUANTITY_TEXTFIELD{
            
            descriptionTextView.becomeFirstResponder()
        }
        
        return true
    }
    
    // MARK: - UITextViewDelegate
    
    // When the text view is focused, make it the first responder
    func textViewDidBeginEditing(textView: UITextView) {
        textView.becomeFirstResponder()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // Hitting "Done" will dismiss the keyboard for textview
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        
        return true
        
    }
    
    // MARK: - Actions
    
    // When the submit button is pressed, either present a validation modal or create the grocery item
    @IBAction func submitButtonDidPressed(sender: UIButton) {
        
        // If an error message exists, present a alert modal
        if let errorMessage = validate(){
            
            // Create an alert view controller
            let alertController = UIAlertController(title: "Invalid Data", message: errorMessage, preferredStyle: .Alert)
    
            // Initialize Action
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
    
            // Add Actions
            alertController.addAction(okAction)
    
            // Present Alert Controller
            presentViewController(alertController, animated: true, completion: nil)

        } else{
            
            // Create the grocery item, notify the delegate, and pop view controller
            let item = Grocery(name: nameTextField.text!, quantity: Int(quantityTextField.text!)!, description: descriptionTextView.text)
            
            delegate?.groceryDidAdd(item)
            
            navigationController?.popViewControllerAnimated(true)
        }

    }

    // MARK: - Utilities
    
    // Validates the user data. If validation fails, it will return a string with the error message
    func validate() -> String?{
        
        var errorMessage: String?
        
        // Validate name
        if nameTextField.text!.characters.count < 3{
            errorMessage = "Please enter a valid name"
        }
        
        // Validate quantity
        if let quantity = Int(quantityTextField.text!){
            
            if quantity <= 0{
                errorMessage = "Quantity must be a positive amount"
            }
            
        } else{
            errorMessage = "Invalid quantity"
        }
                
        return errorMessage
    }


}

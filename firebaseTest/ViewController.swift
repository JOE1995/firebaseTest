//
//  ViewController.swift
//  firebaseTest
//
//  Created by 矢吹祐真 on 2016/08/30.
//  Copyright © 2016年 矢吹祐真. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!

    var databaseRef:FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blackColor().CGColor
        
        // Delegateを設定する.
        nameTextField.delegate = self
        messageTextField.delegate = self
        
        
        databaseRef = FIRDatabase.database().reference()
        databaseRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let name = snapshot.value!.objectForKey("name") as? String,
                message = snapshot.value!.objectForKey("message") as? String {
                self.textView.text = "\(self.textView.text)\n\(name) : \(message)"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        let messageData = ["name": nameTextField.text!, "message": messageTextField.text!]
        databaseRef.childByAutoId().setValue(messageData)
        
        textField.resignFirstResponder()
        messageTextField.text = ""
        print("done")
        
        return true
    }

}


//
//  TodoItemCreationTableViewController.swift
//  Todolist
//
//  Created by formation on 15/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class TodoItemCreationTableViewController: UITableViewController {

    @IBOutlet weak var todoItemNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    var todoItem: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if doneButton == sender as? UIBarButtonItem
        && countElements(todoItemNameTextField.text) > 0 {
            todoItem = TodoItem(name: todoItemNameTextField.text)
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}

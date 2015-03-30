//
//  TodosTableViewController.swift
//  Todolist
//
//  Created by formation on 15/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class TodosTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    var todoItems = [TodoItem]()
    var filteredSearchResults = [TodoItem]()
    var searchIsfiltered = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchController: UISearchController = UISearchController(searchResultsController: nil) // https://developer.apple.com/library/ios/documentation/UIKit/Reference/UISearchController/index.html#//apple_ref/occ/cl/UISearchController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItems.append(TodoItem(name: "truc à faire 1"))
        todoItems.append(TodoItem(name: "truc à faire 2"))
        todoItems.append(TodoItem(name: "truc à faire 3"))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self;
        self.searchController.dimsBackgroundDuringPresentation = false;
        self.searchController.searchBar.scopeButtonTitles = ["All", "Done", "Undone"]
        self.searchController.searchBar.delegate = self
        
        //add the search bar
        self.tableView.tableHeaderView = self.searchController.searchBar;
        
        self.definesPresentationContext = true;
        
        updateSearchResultsForSearchController(searchController) // can check for searchResultsController presented state using the .active property
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        var scope : String?
        
        if let scopes = self.searchController.searchBar.scopeButtonTitles as? [String] {
            scope = scopes[self.searchController.searchBar.selectedScopeButtonIndex]
        }
        
        
        filteredSearchResults = todoItems.filter {
            item in
            
            var scopeMach = (scope == "All") || (item.completed == true && scope == "Done") || (item.completed == false && scope == "Undone")
            
            var dataMatch = searchController.searchBar.text.isEmpty || item.name.rangeOfString(searchController.searchBar.text) != nil
            
            return scopeMach && dataMatch
        }
        
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResultsForSearchController(self.searchController)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if searchIsfiltered {
        return filteredSearchResults.count
        //}
        
        //return todoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell
        
        var todoItem: TodoItem
        //        if searchIsfiltered {
        todoItem = filteredSearchResults[indexPath.row]
        //        } else {
        //            todoItem = todoItems[indexPath.row]
        //        }
        
        cell.textLabel?.text = todoItem.name
        cell.detailTextLabel?.text = todoItem.creationDate.description
        
        if todoItem.completed {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var todoItem = todoItems[indexPath.row]
        var todoItem = filteredSearchResults[indexPath.row]
        
        todoItem.completed = !todoItem.completed
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        
    }
    
    @IBAction func unwindToTodosList(segue: UIStoryboardSegue) {
        // récupérer le todo item dans le controller source
        let source = segue.sourceViewController as TodoItemCreationTableViewController
        
        if let todoItem = source.todoItem {
            todoItems.append(todoItem)
            self.updateSearchResultsForSearchController(self.searchController)
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        if editingStyle == .Delete {
    //            // Delete the row from the data source
    //            todoItems.removeAtIndex(indexPath.row)
    //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    //        } else if editingStyle == .Insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //        }
    //    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

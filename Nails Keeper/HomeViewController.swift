//
//  HomeViewController.swift
//  Nails Keeper
//
//  Created by TIM NGUYEN on 3/16/16.
//  Copyright © 2016 TIM NGUYEN. All rights reserved.
//

import UIKit
import CoreData

var transList:transactionList = transactionList(tList: nil)

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    func getFetchResultsController() -> NSFetchedResultsController {
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return dataViewController
    }
    let fetchRequest = NSFetchRequest(entityName: "Transaction")

    
    func listFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Transaction")
        let sortDescripter = NSSortDescriptor(key: "transID", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.RecentlyAddedTableView.reloadData()
    }



    @IBOutlet weak var stubNumberTxtBox: UITextField!
    @IBOutlet weak var tipCashTxtBox: UITextField!
    @IBOutlet weak var tipCardTxtBox: UITextField!
    @IBOutlet weak var amtTxtBox: UITextField!
    @IBOutlet weak var RecentlyAddedTableView: UITableView!
    
    @IBAction func addBtn(sender: UIButton) {
        
    }
    
    
    var deleteIndexPath :NSIndexPath? = nil
    
    var places = ["San Francisco","San Jose","Phoenix","Seattle","Houston","Dallas"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewController = getFetchResultsController()
        
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
        } catch _ {
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.workDate.text = places[indexPath.row]
        cell.amount.text = places[indexPath.row]
        cell.tipCard.text = places[indexPath.row]
        cell.tipCash.text = places[indexPath.row]
        cell.stuffNo.text = places[indexPath.row]
        
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteIndexPath = indexPath
            let tobeDelete = places[indexPath.row]
            confirmDelete(tobeDelete)
        }
    }
    func confirmDelete(planet: String) {
        let alert = UIAlertController(title: "Delete a City", message: "Are you sure you want to permanently delete \(places[(deleteIndexPath?.row)!])?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: deleteRequestHelper)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDelete)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func deleteRequestHelper(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteIndexPath {
            RecentlyAddedTableView.beginUpdates()
            places.removeAtIndex(indexPath.row)
            // Note that indexPath is wrapped in an array:  [indexPath]
            RecentlyAddedTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            deleteIndexPath = nil
            RecentlyAddedTableView.endUpdates()
        }
    }
    
    func cancelDelete(alertAction: UIAlertAction!) {
        deleteIndexPath = nil
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

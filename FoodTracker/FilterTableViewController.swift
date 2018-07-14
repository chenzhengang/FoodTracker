//
//  FilterTableViewController.swift
//  FoodTracker
//
//  Created by Chun Kong on 2018/4/28.
//  Copyright © 2018年 chenzhengang. All rights reserved.
//

import UIKit
import os.log

var choose = 0

class FilterTableViewController: UITableViewController {

    //MARK: Properties
    @IBOutlet weak var FilterCell: UIView!
    @IBOutlet weak var DoneButton: UIBarButtonItem!

    var condition = [Conditions]()
    var sort: Conditions?
    
    override func viewDidLoad() {
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        super.viewDidLoad()
        tableView.delegate = self
        // Load the Condition data.
        loadConditions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return condition.count
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FilterTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FilterTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FilterTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let con = condition[indexPath.row]
        
        cell.Conditions.text = con.name
        cell.selectImage.image = con.photo

        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose Condition："
    }
    
    
    //MAKR: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === DoneButton else {
            os_log("The done button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //let name = nameTextField.text ?? ""

        // Set the meal to be passed to MealTableViewController after the unwind segue.
        //meal = Meal(name: name, photo: photo, rating: rating)
        
//        guard let selectedFilterCell = sender as? FilterTableViewCell else {
//            fatalError("Unexpected sender: \(String(describing: sender))")
//        }
        
//        guard let indexPath = tableView.indexPath(for: FilterTableViewCell) else {
//            fatalError("The selected cell is not being displayed by the table")
//        }
        
        //直接去翻翻函数就行！！！
        choose = (tableView.indexPathForSelectedRow?.row)!
        
//        for i in 0...2{
//            if (condition[i].photo == UIImage(named: "selected"))
//            {
//                choose = i
//            }
//        }
          //choose = 2
          sort = condition[choose]
    }
 
    //MARK: Private Methods
    private func loadConditions() {
        
        //let selected = UIImage(named: "selected")
        let unselected = UIImage(named: "unselected")

        guard let Condition1 = Conditions(name: "Price from high", photo: unselected) else {
            fatalError("Unable to instantiate Condition1")
        }
        
        guard let Condition2 = Conditions(name: "Time from long", photo: unselected) else {
            fatalError("Unable to instantiate Condition2")
        }
        
        guard let Condition3 = Conditions(name: "Rating from high", photo: unselected) else {
            fatalError("Unable to instantiate Condition3")
        }
        
        condition += [Condition1, Condition2, Condition3]
    }
    
}

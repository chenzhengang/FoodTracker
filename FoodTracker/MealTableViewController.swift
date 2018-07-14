//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Chun Kong on 2018/4/27.
//  Copyright © 2018年 chenzhengang. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meals = [Meal]()
    var sorts = [Meal]()
    
    override func viewDidLoad() {
        //隐藏横线
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            // Load the sample data.
            loadSampleMeals()
        }
        
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
        return meals.count
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        cell.priceLabel.text = "¥ " + meal.price
        cell.timeLabel.text = meal.time + " /min"
        
        return cell
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //saveMeals
            saveMeals()
        }
        if let sourceViewController = sender.source as? FilterTableViewController, let sort = sourceViewController.sort {
            switch(sort.name){
            case "Price from high":
                print("1")
                meals = insertSort1(arr: &meals)
                tableView.reloadData()
                break
            case "Time from long":
                print("2")
                meals = insertSort2(arr: &meals)
                tableView.reloadData()
                break
            case "Rating from high":
                print("3")
                meals = insertSort3(arr: &meals)
                tableView.reloadData()
                break
            default:
                break
            }
        }
    }
    
    
    //MARK: Private Methods
    private func loadSampleMeals() {
        
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4 ,price: "32" , time: "30" ) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5 ,price: "20" , time: "20") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3 ,price: "30" , time: "50") else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3]
    }
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Meal]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }

    //MARK:- 插入排序 价格
    func insertSort1( arr: inout [Meal]) -> [Meal] {
        
        for i in 1 ..< arr.count {
            let key = arr[i]
            var j = i - 1
            while j >= 0 && arr[j].price < key.price {
                arr[j + 1] = arr[j]
                j -= 1
            }
            arr[j + 1] = key
        }
        return arr
        
    }
    
    //时间
    func insertSort2( arr: inout [Meal]) -> [Meal] {
        
        for i in 1 ..< arr.count {
            let key = arr[i]
            var j = i - 1
            while j >= 0 && arr[j].time < key.time {
                arr[j + 1] = arr[j]
                j -= 1
            }
            arr[j + 1] = key
        }
        return arr
        
    }
    
    //评价
    func insertSort3( arr: inout [Meal]) -> [Meal] {
        
        for i in 1 ..< arr.count {
            let key = arr[i]
            var j = i - 1
            while j >= 0 && arr[j].rating < key.rating  {
                arr[j + 1] = arr[j]
                j -= 1
            }
            arr[j + 1] = key
        }
        return arr
        
    }
    
    

    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        
        case "Filter":
            os_log("Filter.", log: OSLog.default, type: .debug)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //
//    private var advertiseView: UIView?
//    var adView: UIView? {
//        didSet {
//            advertiseView = adView!
//            advertiseView?.frame = self.view.bounds
//            self.view.addSubview(advertiseView!)
//            //渐变动画
//            UIView.animate(withDuration: 2, animations: { [weak self] in
//                self?.advertiseView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                self?.advertiseView?.alpha = 0
//            }) { [weak self] (isFinish) in
//                self?.advertiseView?.removeFromSuperview()
//                self?.advertiseView = nil
//            }
//        }
//    }


}

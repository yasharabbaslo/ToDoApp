//
//  CategoryViewControllerTableViewController.swift
//  ToDoApp
//
//  Created by Yashar Abbaslo on 1/23/1399 AP.
//  Copyright © 1399 Yashar Abbaslo. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()

    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         loadCategories()
        
        tableView.separatorStyle = .none

    }

    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.backgroundColor = UIColor(hexString: categoryArray?[indexPath.row].bgColor ?? "1D9BF6")
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories"
        
        return cell
        
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        
        }
        
    }
    
    // MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
            let alert = UIAlertController(title: "Add New Todo Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                // What will happen once the user clicks the Add Item button on our UIAlert
                
                let newCategory = Category()
                newCategory.name = textField.text!
                newCategory.bgColor = UIColor.randomFlat().hexValue()
                
                self.save(category: newCategory)
            }
            
            alert.addTextField { (alertTexrField) in
                alertTexrField.placeholder = "Add new category"
                textField = alertTexrField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }

    
    // MARK: - Data manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    // MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
        
    }

}



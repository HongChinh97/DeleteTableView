//
//  TableViewController.swift
//  DeleteTableView
//
//  Created by admin on 6/29/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var footerView: UIView!
    var isDone: Bool = false
    
    var number: [Int] = Array(1...5)
    var hasNoData: Bool = false {
        didSet {
               hasNoData ? (tableView.tableFooterView = noDataView) : (tableView.tableFooterView = footerView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hasNoData = (number.count == 0)
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.isEditing = editing
        
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(number[indexPath.row])
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let index  = tableView.indexPathForSelectedRow {
                if let viewTableController = segue.destination as? ViewController {
                    viewTableController.name = String(number[index.row])
                }
        }
        
    }

    @IBAction func actionDelete(_ sender: UIButton) {
        var items = [Int]()
        if let selectedRow = tableView.indexPathsForSelectedRows {
            for item in items{
                if let index = number.index(of: item) {
                    number.remove(at: index)
                    
                }
            }
            print(selectedRow)
//            tableView.endUpdates()
            tableView.deleteRows(at: selectedRow, with: .fade)
            tableView.reloadData()
        }
        
        
    }
    
    
    
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if let viewController = unwindSegue.source as? ViewController {
            if let index = tableView.indexPathForSelectedRow {
                guard let name = Int(viewController.name ?? "") else {return}
                number[index.row] = name
            } else {
                guard let name = Int(viewController.name ?? "") else {return}
                number.append(name)
            }
        }
        tableView.reloadData()
        
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            number.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
       
        hasNoData = (number.count == 0)
       tableView.reloadData()
    }
}

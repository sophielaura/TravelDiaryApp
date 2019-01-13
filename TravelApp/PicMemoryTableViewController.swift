//
//  PicＭemoryTableViewController.swift
//  TravelApp
//
//  Created by Richard on 2019/1/12.
//  Copyright © 2019年 Laura. All rights reserved.
//

import UIKit

class PicMemoryTableViewController: UITableViewController {
    
    struct pictureDetails : Codable{
        var title: String
        var location: String
        var date: String
        var diary: String
        var other: String
    }
    var dictionary=Array<Dictionary<String,String>>()
    let filePath=NSHomeDirectory()+"test.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let load=NSArray(contentsOfFile: filePath) as? Array<Dictionary<String, String>>{
            dictionary=load
            print("count=\(dictionary.count)")
            //print(dictionary)
        }
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let load=NSArray(contentsOfFile: filePath) as? Array<Dictionary<String, String>>{
            dictionary=load
            print("count=\(dictionary.count)")
            //print(dictionary)
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return dictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("checkPoint")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? picMemoryListTableViewCell else{
                print("cellFail")
                fatalError("cellFail")
        }
        
        if dictionary.count != 0{
            var product=dictionary[indexPath.row]
            cell.updateUI(product: product)
        }
        return cell
        
       
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

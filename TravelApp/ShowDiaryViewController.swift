//
//  ShowDiaryViewController.swift
//  TravelApp
//
//  Created by Richard on 2019/1/13.
//  Copyright © 2019年 Laura. All rights reserved.
//

import UIKit

class ShowDiaryViewController: UIViewController {

    var cellSelect=Dictionary<String, String>()
    var cellSelectA=Dictionary<String, String>()
    var index:Int=(-1)
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var diaryTextField: UITextView!
    @IBOutlet weak var otherTextField: UITextView!
    
    var imagePath:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if index != (-1){
            titleLabel.text=cellSelect["title"]
            locationLabel.text=cellSelect["location"]
            dateLabel.text=cellSelect["date"]
            diaryTextField.text=cellSelect["diary"]
            otherTextField.text=cellSelect["other"]
            imagePath=cellSelect["imagePath"]
            if imagePath != nil{
                imageView.image=UIImage(contentsOfFile: imagePath)
            }
        }else{
            let filePath=NSHomeDirectory()+"test.txt"
            if let loadArray=NSArray(contentsOfFile: filePath) as? Array<Dictionary<String, String>>{
                titleLabel.text=loadArray[index]["title"]
                locationLabel.text=loadArray[index]["location"]
                dateLabel.text=loadArray[index]["date"]
                diaryTextField.text=loadArray[index]["diary"]
                otherTextField.text=loadArray[index]["other"]
                imagePath=loadArray[index]["imagePath"]
                if imagePath != nil{
                    imageView.image=UIImage(contentsOfFile: imagePath)
                }
            }
            
            
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show"{
            let controller=segue.destination as! ListTableViewController
            controller.cellSelect=self.cellSelect
            controller.index=self.index
            
        }else if segue.identifier == "edit"{
            let controller=segue.destination as! PicDetailContentTableViewController
            //傳出
            //cellSelect=cellSelectA
            controller.index=index
            controller.cellSelect=cellSelect
            
            //接收
            //controller.index=self.index
            //controller.cellSelect=self.cellSelectA
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let filePath=NSHomeDirectory()+"test.txt"
        if let loadArray=NSArray(contentsOfFile: filePath) as? Array<Dictionary<String, String>>{
            titleLabel.text=loadArray[index]["title"]
            locationLabel.text=loadArray[index]["location"]
            dateLabel.text=loadArray[index]["date"]
            diaryTextField.text=loadArray[index]["diary"]
            otherTextField.text=loadArray[index]["other"]
            imagePath=loadArray[index]["imagePath"]
            if imagePath != nil{
                imageView.image=UIImage(contentsOfFile: imagePath)
            }
            cellSelect=loadArray[index]
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

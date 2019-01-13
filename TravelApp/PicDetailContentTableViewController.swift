//
//  PicDetailContentTableViewController.swift
//  TravelApp
//
//  Created by User19 on 2019/1/11.
//  Copyright © 2019 Laura. All rights reserved.
//

import UIKit

class PicDetailContentTableViewController: UITableViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var diaryTextField: UITextView!
    @IBOutlet weak var otherTextField: UITextView!
    
    var cellSelect=Dictionary<String, String>()
    var index:Int=(-1)
    
    
    var content=Dictionary<String, String>()
   
    var imagePath=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fullScreenSize=UIScreen.main.bounds.size
        
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy/MM/dd"
        
        let datePickerView=UIDatePicker(frame: CGRect(x:0,y:fullScreenSize.height * 0.3,width:fullScreenSize.width,height:150))
        
        datePickerView.datePickerMode = .date
        datePickerView.locale=NSLocale(localeIdentifier: "zh-TW") as Locale
        
        if index != (-1){
            imagePath=self.cellSelect["imagePath"]!
            titleTextField.text=self.cellSelect["title"]
            locationTextField.text=self.cellSelect["location"]
            dateTextField.text=self.cellSelect["date"]
            diaryTextField.text=self.cellSelect["diary"]
            otherTextField.text=self.cellSelect["other"]
            if imagePath != nil{
                imageView.image=UIImage(contentsOfFile: imagePath)
            }
            
            let day=formatter.date(from: cellSelect["date"]!)
            datePickerView.date=day!
        }else{
            datePickerView.date=NSDate() as Date
        }
        
        datePickerView.addTarget(self, action: #selector(PicDetailContentTableViewController.datePickerChanged), for: .valueChanged)
        
        dateTextField.inputView=datePickerView
        dateTextField.text=formatter.string(from: datePickerView.date)
        
        //self.view.addSubview(dateTextField)
        
        
        
        let tap=UITapGestureRecognizer(target: self, action: #selector(PicDetailContentTableViewController.hideKeyBoard))
        
        tap.cancelsTouchesInView=false
        
        self.view.addGestureRecognizer(tap)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
        
        
        
    }
    
    @objc func hideKeyBoard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func datePickerChanged(datePickerView:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy/MM/dd"
        
        dateTextField.text=formatter.string(from: datePickerView.date)
    }
    
    
    
    
    let picker:UIImagePickerController=UIImagePickerController()
    @IBAction func choosePicButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            
            picker.sourceType=UIImagePickerController.SourceType.photoLibrary
            picker.allowsEditing=true      //允許編輯
            picker.delegate=self
            self.present(picker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.imageView.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        var urlImage=info[UIImagePickerController.InfoKey.imageURL] as! URL
        print("urlImage=\(urlImage)")
        print("url.scheme=\(urlImage.scheme)  url.host=\(urlImage.host)  url.pathcomponent==\(urlImage.pathComponents)")
        
        imagePath=(urlImage.pathComponents).joined(separator: "/") as String
        print("imagePath=\(imagePath)")
        //var m=k.components(separatedBy: ".")
        //var type=m[1]
        
        //var n=UIImage(
        //imagePath=urlImage.lastPathComponent
        //imagePath=Bundle.main.path(forResource: k, ofType: <#T##String?#>)!
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        titleTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        diaryTextField.resignFirstResponder()
        otherTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
   
    
    @IBAction func save(_ sender: Any) {
        
        let filePath=NSHomeDirectory()+"test.txt"
        print("filePath   >>>>   \(filePath)")
        //var imageFilePath:String=""
        var count=0
        let fileManager=FileManager.default
        print(fileManager.fileExists(atPath: filePath))
        
        var dictionary=Array<Dictionary<String,String>>()
        
        if let loadArray=NSArray(contentsOfFile: filePath) as? Array<Dictionary<String, String>>{
            count=loadArray.count
            dictionary=loadArray
            print("load")
            print(loadArray)
        }
       
        
        
        print("count=\(count)")
        content["title"]=titleTextField.text
        content["location"]=locationTextField.text
        content["date"]=dateTextField.text
        content["diary"]=diaryTextField.text
        content["other"]=otherTextField.text
        content["imagePath"]=imagePath
        
        if index != (-1) {          //edit的話
            dictionary[index]=content
        }else{
            dictionary.append(content)
        }
        print("陣列=\(dictionary)")
        var arrayToSave=NSArray(array: dictionary)
        arrayToSave.write(toFile: filePath, atomically: true)
        
        print("imagePath=\(content["imagePath"])")
        //print("title=\(content["title"])")
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let controller=segue.destination as! ShowDiaryViewController
            controller.cellSelect=self.cellSelect
            controller.index=self.index
            
        }
    }
    
    
    // MARK: - Table view data source
/***自己註解掉的部分
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
***/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

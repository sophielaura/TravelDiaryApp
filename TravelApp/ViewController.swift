//
//  ViewController.swift
//  TravelApp
//
//  Created by User23 on 2019/1/9.
//  Copyright © 2019 Laura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath=NSHomeDirectory()+"test.txt"
        let fileManager=FileManager.default
        
        fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        
        
    }
    
}


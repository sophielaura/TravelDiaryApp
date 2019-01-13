//
//  picMemoryListTableViewCell.swift
//  TravelApp
//
//  Created by Richard on 2019/1/12.
//  Copyright © 2019年 Laura. All rights reserved.
//

import UIKit

class picMemoryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var diary:String!
    var other:String!
    var imagePath:String!
    
    func updateUI(product: Dictionary<String, String>){
        title.text=product["title"]
        location.text=product["location"]
        date.text=product["date"]
        diary=product["diary"]
        other=product["other"]
        imagePath=product["imagePath"]
        listImageView.image=UIImage(contentsOfFile: imagePath)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
}

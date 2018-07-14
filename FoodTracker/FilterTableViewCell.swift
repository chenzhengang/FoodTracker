//
//  FilterTableViewCell.swift
//  FoodTracker
//
//  Created by Chun Kong on 2018/4/28.
//  Copyright © 2018年 chenzhengang. All rights reserved.
//

import UIKit


class FilterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        if selected {
            //imageView?.image = UIImage(named: "chosen")
            self.selectImage.image = UIImage(named: "selected")
            //self.Conditions.text = " "
            switch (self.Conditions.text!)
            {
            case "Price from high":
                print("1")
                choose = 0
                break
            case "Time from long":
                print("2")
                choose = 1
                break
            case "Rating from high":
                print("3")
                choose = 2
                break
            default:
                break
            }
            }else {
            self.selectImage.image = UIImage(named: "unselected")
            //imageView?.image = nil
            //imageView?.image = UIImage(named: "unselected")
        }
    }


    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var Conditions: UILabel!
}

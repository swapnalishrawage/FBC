//
//  MenuTableCell.swift
//  ChatDemo
//
//  Created by sachin shinde on 10/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {
    @IBOutlet weak var menuimage: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var menu: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateCell(menulabel:String,menuimage:UIImage)
    {
        menu.text = menulabel;
        img.image = menuimage ;
        //img = UIImageView(image: menuimage);
        
    }

   
}

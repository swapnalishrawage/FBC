//
//  MessageCenterCell.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 21/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit

class MessageCenterCell: UITableViewCell {
    @IBOutlet weak var lbllastmsgtime: UILabel!
    
    @IBOutlet weak var imgteacher: UIImageView!
    @IBOutlet weak var lbllastmsg: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateCell(MsgSender:String,msgtext:String,MsgTime:String,msgSenderimage:String)
    {
        lblusername.text = MsgSender;
        lbllastmsg.text = msgtext;
        lbllastmsgtime.text=MsgTime;
        
        let v=lblusername.text
        
        let stArr = v?.components(separatedBy: " ")
        var st=""
        for s in stArr!{
            if let      str=s.characters.first{
                st+=String(str).capitalized
            }
        }
        
            if(msgSenderimage=="")
            {
                
                
                let img = ImageToText()
                let tempimg = img.textToImage(drawText: st as NSString, inImage:#imageLiteral(resourceName: "blue1") , atPoint: CGPoint(x: 20.0, y: 20.0))
                self.imgteacher.layer.borderColor = UIColor.gray.cgColor
                self.imgteacher.layer.cornerRadius = 25.7
                self.imgteacher.layer.masksToBounds = true
                imgteacher.image = tempimg

            }
    else{
                
                let imagedownload = DownloadImage()
                
                let profileimage = imagedownload.userImage(imageurlString: msgSenderimage)
                if(profileimage != nil)
                {
                    self.imgteacher.layer.borderColor = UIColor.gray.cgColor
                    self.imgteacher.layer.cornerRadius = 25.7
                    self.imgteacher.layer.masksToBounds = true
                    imgteacher.image = profileimage
                }
                else
                {
                    let img = ImageToText()
                    let tempimg = img.textToImage(drawText: st as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
                    self.imgteacher.layer.borderColor = UIColor.gray.cgColor
                    self.imgteacher.layer.cornerRadius = 25.7
                    self.imgteacher.layer.masksToBounds = true
                    imgteacher.image = tempimg

                }

                
    }

    
    
    }

}

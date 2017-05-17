//
//  messageViewIncoming.swift
//  firebasechat
//
//  Created by Rz on 02/05/17.
//  Copyright © 2017 Realizer. All rights reserved.
//

import UIKit
import JSQMessagesViewController
class messageViewIncoming: JSQMessagesCollectionViewCellIncoming {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var timeLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

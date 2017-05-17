//
//  ForgotPasswordPopupVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 14/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit

class ForgotPasswordPopupVC: UIViewController {
    
    @IBOutlet weak var PwdRecoveryPanel: UIView!
    @IBOutlet weak var FWbtnsubmit: UIButton!
    
    @IBOutlet weak var FWradiomagic: UIButton!
    
    @IBOutlet weak var FWradioEmail: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
        PwdRecoveryPanel.layer.borderColor=UIColor.black.cgColor
        PwdRecoveryPanel.layer.borderWidth=1
        FWradioEmail.setImage(#imageLiteral(resourceName: "selected"), for: UIControlState.normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func FWradiomagicClick(_ sender: AnyObject) {
        
        
        if(FWradiomagic.currentImage == #imageLiteral(resourceName: "selected.jpg"))
        {
            FWradioEmail.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            FWradiomagic.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
        }
        else
        {
            FWradiomagic.setImage(#imageLiteral(resourceName: "selected.jpg"), for:UIControlState.normal)
            if(FWradioEmail.currentImage==#imageLiteral(resourceName: "selected"))
            {
                FWradioEmail.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            }
        }
    }
    
    @IBAction func FWbtnradioEmailclick(_ sender: AnyObject) {
        
        
        if(FWradioEmail.currentImage == #imageLiteral(resourceName: "selected.jpg"))
        {
            FWradiomagic.setImage(#imageLiteral(resourceName: "unselect"),for:UIControlState.normal)
            
            FWradioEmail.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            
        }
        else
        {
            FWradioEmail.setImage(#imageLiteral(resourceName: "selected.jpg"), for:UIControlState.normal)
            if(FWradioEmail.currentImage==#imageLiteral(resourceName: "selected"))
            {
                FWradiomagic.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            }
            
        }
        
    }
    
    
    
    @IBAction func CancelClick(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func SubmitClick(_ sender: AnyObject) {
        if(FWradioEmail.currentImage==#imageLiteral(resourceName: "selected"))
        {
            performSegue(withIdentifier: "SgueVerifyMailVC", sender: nil)
        }
        else{
            performSegue(withIdentifier: "SgueVerifyMagicVC", sender: nil)
        }
        
        
        
        
        
    }
    }

//
//  VerifyMagicWordVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 15/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
class VerifyMagicWordVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var VerifyMagicwordView: UIView!
    private var _userid:String!
    @IBOutlet weak var txtUserId: UITextField!
            @IBOutlet weak var txtverifyMagicword: UITextField!
    var userid:String
    {
    get{
    return _userid
    }
    set{
    _userid=newValue
    }
    }

    @IBAction func VerifyMagicsubmitClick(_ sender: AnyObject) {
        
       
             let userid=txtUserId.text
        
        UserDefaults.standard.set(userid, forKey: "UserSetID")
        if(txtUserId.text=="" ){
            let Verifyuserid = UIAlertController(title: "Error", message: "Please enter User ID", preferredStyle: .alert )
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:nil)
            
            
            Verifyuserid.addAction(cancelAction)
            
            present(Verifyuserid, animated: true, completion: {  })
            
            
            
        }
            else if( !((txtUserId.text?.characters.count)! >= 6) || !((txtUserId.text?.characters.count)! <= 10) )
        {
            let Verifyuserid = UIAlertController(title: "Error", message: "Please enter User ID with 6-10 length", preferredStyle: .alert )
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:nil)
            
            
            Verifyuserid.addAction(cancelAction)
            
            present(Verifyuserid, animated: true, completion: {  })

        }
        else   if(txtverifyMagicword.text=="")
        {
            let VerifyMagic = UIAlertController(title: "Error", message: "Please enter Magic Word", preferredStyle: .alert )
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:nil)
            
            
            VerifyMagic.addAction(cancelAction)
            
            present(VerifyMagic, animated: true, completion: {  })
            
        }
        else
        {
            verifymagicword {
                
            }
                   }
    }
    
    @IBAction func VerifyMagicCancleclick(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func verifymagicword(completed: DownloadComplete){
               let userid:String = txtUserId.text!
        let magicword:String=txtverifyMagicword.text!
        print(userid)
        print(magicword)
        
              Alamofire.request("http://45.35.4.250/chat/api/Security/validateMagicWord/\(userid)/\(magicword)",method: .get ).responseJSON{ response in
                        let result=response.result
            if let dict = result.value  as?  Dictionary<String,AnyObject>
                
            {
               // let res=dict["Success"] as? Int
                let res:AnyObject = dict["Success"]!
          
                
                let r:Int=Int(res as! NSNumber)
       
                if (r == 1)
                {
                    
                    
                    if let uid = dict["userId"] as? String {
                        self._userid=uid
                        let uID:String = self._userid
                                                UserDefaults.standard.setValue(uID, forKey: "UID")
                        self.performSegue(withIdentifier: "SgueMgicWordSubmit", sender: nil)
                        
 
                        
                        
                    }
                    
                    
                    
                    
                }
                else{
                    
                  
                    let passwordcheck = UIAlertController(title: "Error", message: "Please check User Id or MagicWord", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    
                    
                    
                    passwordcheck.addAction(cancelAction)
                    
                    
                    self.present(passwordcheck, animated: true, completion: {  })
                    
                }
            }
            
            print(response)
            
            
        }
        
        
         completed()
        
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VerifyMagicwordView.layer.borderColor=UIColor.black.cgColor
        VerifyMagicwordView.layer.borderWidth=1
       
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VerifyMagicWordVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
       
        view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    
   }

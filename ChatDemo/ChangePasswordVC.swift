//
//  ChangePasswordVC.swift
//  ChatDemo
//
//  Created by sachin shinde on 12/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
class ChangePasswordVC: UIViewController {

    @IBAction func clickdissmiss(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)

    }
    @IBOutlet weak var changepass: UIView!
    @IBOutlet weak var txtconfpass: UITextField!
    @IBOutlet weak var txtnewpass: UITextField!
    @IBOutlet weak var txtoldpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       changepass.layer.borderColor=UIColor.black.cgColor
      changepass.layer.borderWidth=1


        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangePasswordVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var cancleclick: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    @IBAction func clicksubmit(_ sender: AnyObject) {
        if(txtoldpass.text=="")
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Please Enter  Your Old Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })

        }
            else if(!((txtoldpass.text?.characters.count)! >= 6) || !((txtoldpass.text?.characters.count)! <= 10))
        {
            
            let passwordcheck = UIAlertController(title: "Error", message: "Please enter  old Password which has 6-10  characters in length", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })

        }
        else if(txtnewpass.text==""){
            
            let passwordcheck = UIAlertController(title: "Error", message: "Please enter new Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })

        }
            else if(!((txtnewpass.text?.characters.count)! >= 6) || !((txtnewpass.text?.characters.count)! <= 10))
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Please enter  new Password with 6-10 characters length", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })
        }
            else if(txtnewpass.text?.contains(" ")==true)
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Whitespace does not allowed in Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })
        }
            else if(txtconfpass.text=="")
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Please enter  new Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })

        }
            else if(!((txtnewpass.text?.characters.count)! >= 6) || !((txtnewpass.text?.characters.count)! <= 10))
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Please enter  confirm Password with 6-10  length characters", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })

        }
        else if(txtconfpass.text != txtnewpass.text){
            
            let passwordcheck = UIAlertController(title: "Error", message: "Mismatch Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            self.present(passwordcheck, animated: true, completion: {  })

        }
        else{
            
            changePassword {}
            
            
            
            
             }
        }
    
        func changePassword(completed: @escaping DownloadComplete){
               let oldpassword:String = txtoldpass.text!
              let newpass:String = txtnewpass.text!
        
        let userid1:String=UserDefaults.standard.value(forKey: "UserId") as! String
         let parameters: Parameters = ["oldPassword":oldpassword,"newPassword":newpass]
       
    
        Alamofire.request("http://45.35.4.250/chat/api/security/changePassword/\(userid1)",method: .post,parameters:parameters,encoding:JSONEncoding.default ).responseString{ response in
            
            
            
            let result=response.result
            let dict:String = result.value!

            
                if (dict == "true")
                {
                    let passwordset = UIAlertController(title: "Set Password ", message: "Password change Successfully..!!", preferredStyle: .alert )
                   
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler:{action in
                        self.dismiss(animated: true) {}
                    })
                    
                    
                    passwordset.addAction(okAction)
                    
                    
                    self.present(passwordset, animated: true, completion:nil)
                    
                }
                else{
                    let passwordset = UIAlertController(title: "Error", message: "Password  not change,try again! ", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    
                    passwordset.addAction(okAction)
                    
                    
                    self.present(passwordset, animated: true, completion: {  })
                
                }
                    
                            }
             completed()
        }
        
        
    
    }
    



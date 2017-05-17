//
//  ResetPasswordVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 15/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire

class ResetPasswordVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var ResetPasswordView: UIView!
    
    @IBOutlet weak var txtuserid: UITextField!
    @IBOutlet weak var ResetPasswordtxtConfPassword: UITextField!
    @IBOutlet weak var resetpasswordtxtPassword: UITextField!
     var userid1:String = UserDefaults.standard.value(forKey: "UID") as! String
    var usersetid:String=UserDefaults.standard.value(forKey: "UserSetID")  as! String
    @IBAction func ResetPasswordSubmit(_ sender: AnyObject) {
        
        if(resetpasswordtxtPassword.text==""  ){
            let passwordcheck = UIAlertController(title: "Error ", message: "Please enter new  Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            present(passwordcheck, animated: true, completion: {  })

        }else if(!((resetpasswordtxtPassword.text?.characters.count)! >= 6) || !((resetpasswordtxtPassword.text?.characters.count)! <= 10)){
            
            let passwordcheck = UIAlertController(title: "Error ", message: "Please enter new  Password of length 6-10 characters", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            present(passwordcheck, animated: true, completion: {  })
        }
        
        if( ResetPasswordtxtConfPassword.text=="")
        {
            let passwordcheck = UIAlertController(title: "Error ", message: "Please enter confirm Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            present(passwordcheck, animated: true, completion: {  })
            
        }
            else if(resetpasswordtxtPassword.text?.contains(" ")==true)
        {
            let passwordcheck = UIAlertController(title: "Error ", message: "Whitespace does not allowed in Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            present(passwordcheck, animated: true, completion: {  })
            
        }
            
        else{
            
            if(resetpasswordtxtPassword.text==ResetPasswordtxtConfPassword.text)
            {
                
                ResetPassword {
                    
                }

                let passwordset = UIAlertController(title: "Set Password", message: "Password reset Successfully..!!", preferredStyle: .alert )
               // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                    action in  self.performSegue(withIdentifier: "squeresetpass", sender: self)
                    
                })
                
                
              //  passwordset.addAction(cancelAction)
                passwordset.addAction(okAction)
                
                
                present(passwordset, animated: true, completion: {  })
                
            }
            else{
                let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResetPasswordView.layer.borderColor=UIColor.black.cgColor
        ResetPasswordView.layer.borderWidth=1
        //var  username:String = UserDefaults.standard.value(forKey: "UserName") as! String
        txtuserid.text=String(usersetid)
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResetPasswordVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func ResetPassword(completed: DownloadComplete){
                var userid:String = txtuserid.text!
        print(userid)
        let password:String=resetpasswordtxtPassword.text!
       
            userid=userid1
        
       

        Alamofire.request("http://45.35.4.250/chat/api/security/setPassword/\(userid1)/\(password)",method: .post,encoding:JSONEncoding.default ).responseJSON{ response in
                        
            
            let result=response.result
            if let dict = result.value  as?  Dictionary<String,AnyObject>
                
            {
                let res=dict["Success"] as? Int
                
                if (res == 1)
                {
                    let passwordset = UIAlertController(title: "Set Password ", message: "Password Set Successfully..!!", preferredStyle: .alert )
                   
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                        action in
                    

                        self.dismiss(animated: true, completion:{ action in   self.performSegue(withIdentifier: "squeresetpass", sender: self)
                        })
                        
                        
                    })
                    
                    
                   
                    passwordset.addAction(okAction)
                    
                    
                    self.present(passwordset, animated: true, completion: {  })
                    
                                        }
                else{
                    
                    let passwordset = UIAlertController(title: "Error ", message: "Please try again..", preferredStyle: .alert )
                   
                    
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                   
                    passwordset.addAction(okAction)
                    
                    
                    self.present(passwordset, animated: true, completion: {  })

                    
                   }
                    
                
                }

            }
            
        
                       completed()
            }
        
    @IBAction func ResetPasswordCancleClick(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   

    
}

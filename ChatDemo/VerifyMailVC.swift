//
//  VerifyMailVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 15/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
class VerifyMailVC: UIViewController {
    
    @IBOutlet weak var VerifyMailView: UIView!
    
    @IBOutlet weak var txtuserId: UITextField!
    
    @IBOutlet weak var lblHeaderverifyMail: UILabel!
    @IBOutlet weak var txtVerifyMail: UITextField!
    
    func isValidEmail(testStr:String) -> Bool {
        
        
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
        
    @IBAction func VeriftMailSubmitClick(_ sender: AnyObject) {
        
        
        verifyEmail {
            
        }

    
        if(txtuserId.text==""  )
        {
            let emailBtn = UIAlertController(title: "Error", message: "Please enter  User ID", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            emailBtn.addAction(okAction)
            
            present(emailBtn, animated: true, completion: {  })
            
            
            
        }
        else if( !((txtuserId.text?.characters.count)! >= 6) || !((txtuserId.text?.characters.count)! <= 10)){
            let emailBtn = UIAlertController(title: "Error", message: "Please enter  User ID with 6-10 length", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            emailBtn.addAction(okAction)
            
            present(emailBtn, animated: true, completion: {  })
        }
        else if(txtVerifyMail.text=="" )
        {
            let emailBtn = UIAlertController(title: "Error", message: "Please enter  Email ID", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            emailBtn.addAction(okAction)
            
            present(emailBtn, animated: true, completion: {  })
            
            
        }
        else if (isValidEmail(testStr: txtVerifyMail.text!)) {
            
            
            
            verifyEmail {
                
            }
            
                 }
        else{
            
            let emailBtn = UIAlertController(title: "Error", message: "Incorrect Email", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler:nil)
            
            emailBtn.addAction(okAction)
            
            
            present(emailBtn, animated: true, completion: {  })
        }
        
        
    }
    
    func verifyEmail(completed: DownloadComplete){
        let userid:String = txtuserId.text!
        let email:String=txtVerifyMail.text!
        print(userid)
        print(email)
        
        let headers:[String:String] = ["emailId":email ]

        
        
        Alamofire.request("http://45.35.4.250/chat/api/Security/sendPaswordToEmail/\(userid)",method: .post,headers: headers).responseString{ response in
            print("====\(response)")
            
            let result=response.result
           
            
            let dict:String = result.value!
                
      
            
                
                if (dict == "true")
                {
                    
                    let passwordcheck = UIAlertController(title: "Set Password", message: "Password sent to your Email Address", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:{
                        action in  self.performSegue(withIdentifier: "squePasswordset", sender: self)
                        
                    })
                    
                    
                    
                    passwordcheck.addAction(cancelAction)
                    
                    
                    self.present(passwordcheck, animated: true, completion: {  })
                    

                    
                        
                        
                    }
                
                else{
                    
                    
                    let passwordcheck = UIAlertController(title: "Error", message: "Please Check User ID or Email Id", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:{
                        action in  self.performSegue(withIdentifier: "squePasswordset", sender: self)
                        
                    })
                    
                    
                    
                    passwordcheck.addAction(cancelAction)
                    
                    
                    self.present(passwordcheck, animated: true, completion: {  })
                    
                }
      
            
                       
            
        }
        
        
        completed()
        
        
        
    }
    

    @IBAction func verifymailCancleclick(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @IBOutlet weak var lblentervalidmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VerifyMailView.layer.borderColor=UIColor.black.cgColor
        VerifyMailView.layer.borderWidth=1
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VerifyMailVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
}

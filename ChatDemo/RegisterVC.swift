//
//  RegisterVC.swift
//  Chat
//
//  Created by sachin shinde on 01/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import FirebaseMessaging

class RegisterVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var txtmail: UITextField!
    
    var strBase64:String = ""
    
    @IBOutlet weak var txtdob: UITextField!
    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var txtpass1: UITextField!
    @IBOutlet weak var txtmagic: UITextField!
    @IBOutlet weak var btnradiofemale: UIButton!
    @IBOutlet weak var btnradiomale: UIButton!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtmobileno: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtuserid: UITextField!
    @IBOutlet weak var uploadimage: UIImageView!
    
    @IBAction func closeclick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() == true{
            
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            
            let uialert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            uialert.addAction(okAction)
            
            present(uialert, animated: true, completion: {  })
            
            hideActivityIndicator()
        }

        txtmagic.delegate=self
        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        navigationController?.navigationBar.isHidden=false
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.white
        let myColor : UIColor = UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        txtfirstname.layer.borderColor = myColor.cgColor
        txtlastname.layer.borderColor = myColor.cgColor
        txtaddress.layer.borderColor=myColor.cgColor
        txtmail.layer.borderColor = myColor.cgColor
      txtpass1.layer.borderColor = myColor.cgColor
     txtmagic.layer.borderColor=myColor.cgColor

        
       
       txtuserid.layer.borderColor = myColor.cgColor
     txtmobileno.layer.borderColor=myColor.cgColor
        txtconfirmpass.layer.borderColor=myColor.cgColor

        
       txtconfirmpass.layer.borderWidth = 1.0
       txtmobileno.layer.borderWidth = 1.0
        txtuserid.layer.borderWidth = 1.0
        txtpass1.layer.borderWidth = 1.0
                txtmagic.layer.borderWidth = 1.0
       txtmail.layer.borderWidth = 1.0
        txtaddress.layer.borderWidth = 1.0
        txtlastname.layer.borderWidth = 1.0
        txtfirstname.layer.borderWidth = 1.0
        
        
        
        
        
        txtfirstname.layer.cornerRadius=5
        txtlastname.layer.cornerRadius=5
        txtaddress.layer.cornerRadius=5
        txtuserid.layer.cornerRadius=5
        txtmail.layer.cornerRadius=5
        txtmobileno.layer.cornerRadius=5
        txtmagic.layer.cornerRadius=5
               txtpass1.layer.cornerRadius=5
        txtconfirmpass.layer.cornerRadius=5
    
        dob.maximumDate=NSDate() as Date
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
        
        
        
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        navigationController?.navigationBar.isHidden=false
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.white
    }
    @IBAction func uploadimage(_ sender: AnyObject) {
          
        
    }
    @IBOutlet weak var txtconfirmpass: UITextField!
    
  
    
        @IBAction func registerclick(_ sender: AnyObject)
    {
        
        let mb=txtmobileno.text
        let fnm=txtfirstname.text
        let lnm=txtlastname.text
        
        
        let userid=txtuserid.text
        let pass=txtpass1.text
        let magic=txtmagic.text
        
        
       dob.datePickerMode=UIDatePickerMode.date
        let dateformatter=DateFormatter()
        dateformatter.dateFormat="dd MMM yyyy"
        
        let selectedDate=dateformatter.string(from: dob.date)
        print(selectedDate)
        
        let d = NSDate()
        print(d)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter1.string(from: d as Date)
        print(dateString)

        if(txtfirstname.text=="" && txtlastname.text=="" && txtaddress.text=="" && txtmail.text==""   && txtpass1.text=="" && txtmagic.text==""  && txtmobileno.text=="" && txtuserid.text==""  && txtconfirmpass.text=="")
        {
            
            let check = UIAlertController(title: "Error ", message: "Please fill all Information..", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            check.addAction(okAction)
            
            present(check, animated: true, completion: {  })
        }
        else if(txtfirstname.text=="" || txtlastname.text=="" || txtaddress.text=="" || txtmobileno.text=="" || txtuserid.text=="" || txtpass1.text=="" || txtconfirmpass.text=="" || txtmagic.text=="" ||  txtmail.text=="" )
        {
            
            if(txtfirstname.text!=="")
            {
                let check = UIAlertController(title: "Error", message: "Please enter First Name", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()

            }
            else if((txtfirstname.text?.characters.count)! > 20 || (fnm?.containsNumbers())!)
                
                {      var fn=txtfirstname.text
                    
                    let  n=fn?.characters.count
                    if(n! > 20 )
                    {
                        let check = UIAlertController(title: "Error", message: "Please enter Name with max 20 Characters", preferredStyle: .alert )
                        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                        
                        
                        check.addAction(okAction)
                        
                        present(check, animated: true, completion: {  })
                        hideActivityIndicator()
                    }
                    
                }

  
                
        
             if(txtlastname.text=="")
            {
                let check = UIAlertController(title: "Error", message: "Please enter Last Name", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()

            }
             else   if((txtlastname.text?.characters.count)! > 20 || (lnm?.containsNumbers())!)
             {
                
                let check = UIAlertController(title: "Error", message: "Please enter Last Name of 10 charecters", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
                
             }

            if(txtaddress.text!=="")
            {
                let check = UIAlertController(title: "Error", message: "Please enter Address", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
            }
          else  if((txtaddress.text?.characters.count)! > 50)
            {
                
                var fn=txtaddress.text
                
                let  n=fn?.characters.count
                if(n! > 50)
                {
                    let check = UIAlertController(title: "Error", message: "Address  have maximum 50 Characters", preferredStyle: .alert )
                    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    
                    
                    check.addAction(okAction)
                    
                    present(check, animated: true, completion: {  })
                    hideActivityIndicator()
                }
                
            }
   
             if(txtmobileno.text  == "" )
            {
                let check = UIAlertController(title: "Error", message: "Please enter Mobile Number with 10 digit", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()

            }
            if(txtuserid.text=="")
            {
                let check = UIAlertController(title: "Error ", message: "  Please enter User Id", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
           else if( !((txtuserid.text?.characters.count)! >= 6) || !((txtuserid.text?.characters.count)! <= 10) )
            {
                let check = UIAlertController(title: "Error ", message: "  User Id Must be Range of 6-10 character in length", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                txtuserid.text=""
            }
            else if(userid?.contains(" ")==true)
            {
                let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in User Id", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }


           if(txtpass1.text==""  )
            {
                let passwordcheck = UIAlertController(title: "Error", message: " Please enter Password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
           else  if(!((txtpass1.text?.characters.count)! >= 6) || !((txtpass1.text?.characters.count)! <= 10) )
            {
                let passwordcheck = UIAlertController(title: "Error", message: " Password Must be  Range 6-10 character", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
            else if(pass?.contains(" ")==true)
            {
                let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in Password", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }

            if(txtconfirmpass.text==""  )
            {
                let passwordcheck = UIAlertController(title: "Error", message: " Please enter  Confirm Password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
         else   if(txtconfirmpass.text=="" || !((txtconfirmpass.text?.characters.count)! >= 6) || !((txtconfirmpass.text?.characters.count)! <= 10) )
            {
                let passwordcheck = UIAlertController(title: "Error", message: " Mismatch password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                hideActivityIndicator()
            }
                
                
            else{
                
                if( txtpass1.text != txtconfirmpass.text)
                {
                    if(txtconfirmpass.text=="" || !((txtpass1.text?.characters.count)! >= 6) || !((txtpass1.text?.characters.count)! <= 10))
                    {
                        let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Please enter Confirm Password", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                        
                        
                        
                        passwordcheck.addAction(cancelAction)
                        
                        
                        present(passwordcheck, animated: true, completion: {  })
                        hideActivityIndicator()
                    }
                    else if(txtpass1.text != txtconfirmpass.text)
                    {
                        let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                        
                        
                        
                        passwordcheck.addAction(cancelAction)
                        
                        
                        present(passwordcheck, animated: true, completion: {  })
                        hideActivityIndicator()
                    }
                    else if( txtconfirmpass.text != txtpass1.text)
                        
                    {
                        let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                        
                        
                        
                        passwordcheck.addAction(cancelAction)
                        
                        
                        present(passwordcheck, animated: true, completion: {  })
                        hideActivityIndicator()
                    }
                }
                
            }

            if(txtmail.text=="")
            {
                let passwordcheck = UIAlertController(title: "Error", message: "Please enter Email Id ", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                
            }
            if (!isValidEmail(testStr: txtmail.text!)) {
                
                
                let emailBtn = UIAlertController(title: "Verify Email", message: "Incorrect Email", preferredStyle: .alert )
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                
                emailBtn.addAction(cancelAction)
                emailBtn.addAction(okAction)
                
                
                present(emailBtn, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
            
            if(txtmagic.text=="")
            {
                let passwordcheck = UIAlertController(title: "Error", message: "Please enter Magic  Word ", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                
            }
            if(magic?.contains(" ")==true)
            {
                let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in Magic Word", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
            if(selectedDate==dateString)
            {
                let check = UIAlertController(title: "Error", message: "Please enter Date of Birth", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
            
            
            if(btnradiofemale.currentImage==#imageLiteral(resourceName: "selected")){
                
                UserDefaults.standard.set("male", forKey: "Gender")
            }
            else{
                UserDefaults.standard.set("female", forKey: "Gender")
                
            }
            


            
            
        }
     else  if(txtfirstname.text != "" || txtlastname.text != "" || txtaddress.text != "" || txtmail.text != ""   || txtpass1.text != "" || txtmagic.text != ""  || txtmobileno.text != "" || txtuserid.text != "" || txtconfirmpass.text != "")
        {
         
            if((txtfirstname.text?.characters.count)! > 20 || (fnm?.containsNumbers())!)
                
            {      var fn=txtfirstname.text
                
                let  n=fn?.characters.count
                if(n! > 20 )
                {
                    let check = UIAlertController(title: "Error", message: "Please enter Name with max 20 Characters", preferredStyle: .alert )
                    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    
                    
                    check.addAction(okAction)
                    
                    present(check, animated: true, completion: {  })
                          hideActivityIndicator()
                }
                
            }
           
          else if((txtlastname.text?.characters.count)! > 20 || (lnm?.containsNumbers())!)
           {
            
            let check = UIAlertController(title: "Error", message: "Please enter Last Name of 10 charecters", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            check.addAction(okAction)
            
            present(check, animated: true, completion: {  })
                  hideActivityIndicator()

                
            }
            
          else  if((txtaddress.text?.characters.count)! > 50)
            {
                
                var fn=txtaddress.text
                
                let  n=fn?.characters.count
                if(n! > 50)
                {
                    let check = UIAlertController(title: "Error", message: "Address  have maximum 50 Characters", preferredStyle: .alert )
                    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    
                    
                    check.addAction(okAction)
                    
                    present(check, animated: true, completion: {  })
                          hideActivityIndicator()
                }
                
            }

          
         else   if( (txtmobileno.text?.characters.count)! < 10 || (txtmobileno.text?.characters.count)! > 10 || !((mb?.containsNumbers())!) ||  (mb?.containsCharacters())!)
            {
                let check = UIAlertController(title: "Error", message: "Please enter Mobile Number with 10 digit", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                      hideActivityIndicator()
            }
       else if( !((txtuserid.text?.characters.count)! >= 6) || !((txtuserid.text?.characters.count)! <= 10) )
            {
                let check = UIAlertController(title: "Error ", message: "  User Id Must be Range of 6-10 character in length", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                      hideActivityIndicator()
                txtuserid.text=""
            }
            else if(userid?.contains(" ")==true)
            {
                let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in User Id", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                      hideActivityIndicator()

            }
      else  if(!((txtpass1.text?.characters.count)! >= 6) || !((txtpass1.text?.characters.count)! <= 10) )
            {
                let passwordcheck = UIAlertController(title: "Error", message: " Password Must be  Range 6-10 character", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                      hideActivityIndicator()
                
            }
            else if(pass?.contains(" ")==true)
        {
            let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in Password", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            check.addAction(okAction)
            
            present(check, animated: true, completion: {  })
                  hideActivityIndicator()

            }
         else   if(txtconfirmpass.text=="" || !((txtconfirmpass.text?.characters.count)! >= 6) || !((txtconfirmpass.text?.characters.count)! <= 10) )
            {
                let passwordcheck = UIAlertController(title: "Error", message: " Mismatch password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                      hideActivityIndicator()
            }
                
            else if (!isValidEmail(testStr: txtmail.text!)) {
                
                
                let emailBtn = UIAlertController(title: "Verify Email", message: "Incorrect Email", preferredStyle: .alert )
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                
                emailBtn.addAction(cancelAction)
                emailBtn.addAction(okAction)
                
                
                present(emailBtn, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
         else    if(magic?.contains(" ")==true)
            {
                let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in Magic Word", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
            else if(selectedDate==dateString)
            {
                let check = UIAlertController(title: "Error", message: "Please enter Date of Birth", preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                check.addAction(okAction)
                
                present(check, animated: true, completion: {  })
                hideActivityIndicator()
                
            }
            
            
            
            
            

            else{
                if(btnradiofemale.currentImage==#imageLiteral(resourceName: "selected")){
                    
                    UserDefaults.standard.set("male", forKey: "Gender")
                }
                else{
                    UserDefaults.standard.set("female", forKey: "Gender")
                    
                }
                
            
               if( txtpass1.text != txtconfirmpass.text)
                {
                    if(txtconfirmpass.text=="" || !((txtpass1.text?.characters.count)! >= 6) || !((txtpass1.text?.characters.count)! <= 10))
                    {
                        let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Please enter Confirm Password", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                        
                        
                        
                        passwordcheck.addAction(cancelAction)
                        
                        
                        present(passwordcheck, animated: true, completion: {  })
                              hideActivityIndicator()
                    }
                    else if(txtpass1.text != txtconfirmpass.text)
                    {
                    let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    
                    
                    
                    passwordcheck.addAction(cancelAction)
                    
                    
                    present(passwordcheck, animated: true, completion: {  })
                              hideActivityIndicator()
                   }
                    else if( txtconfirmpass.text != txtpass1.text)
                    
                    {
                        let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                        
                        
                        
                        passwordcheck.addAction(cancelAction)
                        
                        
                        present(passwordcheck, animated: true, completion: {  })
                              hideActivityIndicator()
                    }
                 
                }
            
                
                post()
              
                //downloadLoginDetails {}


            }
            
            
            
    }
        else{
            if( txtconfirmpass.text != txtpass1.text)
                
            {
                let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                present(passwordcheck, animated: true, completion: {  })
                      hideActivityIndicator()
            }

//            downloadLoginDetails {
//                
//            }
            post()
           
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    func post()
    {
        let fname:String=txtfirstname.text!
        let lname:String=txtlastname.text!
        let userid:String=txtuserid.text!
        let pass:String=txtpass1.text!
        let phno:String=txtmobileno.text!
        
        let emailid:String=txtmail.text!
        
        
        
        
        dob.datePickerMode=UIDatePickerMode.date
                let dateformatter=DateFormatter()
                dateformatter.dateFormat="dd MMM yyyy"
        
                let selectedDate=dateformatter.string(from: dob.date)
                print(selectedDate)
        
        
                let d0 = NSDate()
                print(d0)
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "dd MMM yyyy"
                let dateString = dateFormatter1.string(from: d0 as Date)
                print(dateString)
        
        var g :String="female"
                if(btnradiofemale.currentImage==#imageLiteral(resourceName: "selected")){
        
                    g="female"
                           }
                else{
                    g="male"
                    
                    
                }

                if(selectedDate==dateString)
                {
                    let check = UIAlertController(title: "Error", message: "Please enter Date of Birth", preferredStyle: .alert )
                    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
        
        
                    check.addAction(okAction)
                    
                    present(check, animated: true, completion: {  })
                          hideActivityIndicator()
                }
        
        let image=NSUUID().uuidString
        let st=FIRStorage.storage().reference().child("ProfilePics").child("\(image).png")
        if let uploaddta=UIImagePNGRepresentation(self.uploadimage.image!){
            st.put(uploaddta, metadata: nil, completion: {
            
            
            (metadata,error) in
                if error != nil{
                    print(error)
                    return
                }
                
                
                
            print(metadata)
                
                
                if let profileimage=metadata?.downloadURL()?.absoluteString{
                    
                    let register:[String:AnyObject]=["fname":fname as AnyObject ,"lname":lname as AnyObject ,"userid":userid as AnyObject  ,"emailid":emailid as AnyObject  ,"password":pass as AnyObject,"phno":phno as AnyObject,"DOB":selectedDate as AnyObject ,"Gender":g as AnyObject,"profileimage":profileimage as AnyObject]
                    
                    self.registreruser(values:register)
                }
                
//                let dataref=FIRDatabase.database().reference()
//                
//                // let chref=FIRDatabase.database().reference(withPath: "Registration")
//                dataref.child("UserRegistration").childByAutoId().setValue(register)
//                let key=dataref.key
//                print(key)
            })
        }
        
    
//      let register:[String:AnyObject]=["fname":fname as AnyObject ,"lname":lname as AnyObject ,"userid":userid as AnyObject  ,"emailid":emailid as AnyObject  ,"password":pass as AnyObject,"phno":phno as AnyObject,"DOB":selectedDate as AnyObject ,"Gender":g as AnyObject]
//        
//        let dataref=FIRDatabase.database().reference()
//        
//        // let chref=FIRDatabase.database().reference(withPath: "Registration")
//        dataref.child("UserRegistration").childByAutoId().setValue(register)
//        let key=dataref.key
//        print(key)
//        print("In post")
        
        
        
        
         let dataref=FIRDatabase.database().reference()
        //Rerive all record keys
        dataref.child("UserRegistration").observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for child in result {
                    var ID = child.key as! String
                    print(ID)
                }
            }
        }
        )
        
        
        

        
        
    }
    func registreruser(values:[String:AnyObject])
    {
        //let register:[String:AnyObject]=["fname":fname as AnyObject ,"lname":lname as AnyObject ,"userid":userid as AnyObject  ,"emailid":emailid as AnyObject  ,"password":pass as AnyObject,"phno":phno as AnyObject,"DOB":selectedDate as AnyObject ,"Gender":g as AnyObject]
        
        let dataref=FIRDatabase.database().reference()
        
        // let chref=FIRDatabase.database().reference(withPath: "Registration")
        dataref.child("UserRegistration").childByAutoId().setValue(values)
        let key=dataref.key
        print(key)
        print("In post")
        
        let register1 = UIAlertController(title: "Registration Succesfull...!", message: "Congratulations, You have Registered Sucessfully...!! ", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:{
            action in
            
            self.dismiss(animated: true, completion: nil)
            
            
        })
        
        
        
        register1.addAction(cancelAction)
        
        self.present(register1, animated: true, completion: {  })

    }

//
//    func downloadLoginDetails(completed: @escaping DownloadComplete){
//       let m = BASE_URL + "registerUser"
//    let  uuid = UUID().uuidString
//        print(uuid)
//        
//        showActivityIndicator()
//        var base_url:URL? = nil
//        base_url = URL(string: m )
//        let m0:String = txtfirstname.text!
//        let lnm:String=txtlastname.text!
//       let mb:String=txtmobileno.text!
//        let mail:String=txtmail.text!
//        let magic:String=txtmagic.text!
//        let pass1:String = txtpass1.text!
//        let userid:String = txtuserid.text!
//        
//        var g :String="female"
//        if(btnradiofemale.currentImage==#imageLiteral(resourceName: "selected")){
//            
//            g="female"
//                   }
//        else{
//            g="male"
//            
//            
//        }
//
//       dob.datePickerMode=UIDatePickerMode.date
//        let dateformatter=DateFormatter()
//        dateformatter.dateFormat="dd MMM yyyy"
//        
//        let selectedDate=dateformatter.string(from: dob.date)
//        print(selectedDate)
//
//        
//        let d0 = NSDate()
//        print(d0)
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateFormat = "dd MMM yyyy"
//        let dateString = dateFormatter1.string(from: d0 as Date)
//        print(dateString)
//
//        if(selectedDate==dateString)
//        {
//            let check = UIAlertController(title: "Error", message: "Please enter Date of Birth", preferredStyle: .alert )
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            check.addAction(okAction)
//            
//            present(check, animated: true, completion: {  })
//                  hideActivityIndicator()
//        }
//        if(txtuserid.text=="")
//        {
//            let check = UIAlertController(title: "Error ", message: "  Please enter User Id", preferredStyle: .alert )
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            check.addAction(okAction)
//            
//            present(check, animated: true, completion: {  })
//            hideActivityIndicator()
//            
//        }
//        else if(txtuserid.text!=="" || !((txtuserid.text?.characters.count)! >= 6) || !((txtuserid.text?.characters.count)! <= 10) )
//        {
//            let check = UIAlertController(title: "Error ", message: "  User Id Must be Range of 6-10 character in length", preferredStyle: .alert )
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            check.addAction(okAction)
//            
//            present(check, animated: true, completion: {  })
//            hideActivityIndicator()
//            txtuserid.text=""
//        }
//        else if(userid.contains(" ")==true)
//        {
//            let check = UIAlertController(title: "Error ", message: "  Whitespace does not allowed in User Id", preferredStyle: .alert )
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            check.addAction(okAction)
//            
//            present(check, animated: true, completion: {  })
//            hideActivityIndicator()
//            
//        }
//
//        
//        if(txtpass1.text=="" || !((txtpass1.text?.characters.count)! >= 6) || !((txtpass1.text?.characters.count)! <= 10) )
//        {
//            let passwordcheck = UIAlertController(title: "Error", message: " Password Must be  Range 6-10 character", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            
//            
//            passwordcheck.addAction(cancelAction)
//            
//            
//            present(passwordcheck, animated: true, completion: {  })
//            hideActivityIndicator()
//            
//        }
//
//        let parameters: Parameters = ["firstName":m0,"lastName":lnm,"emailId"
//            :mail,"dateofBirth":selectedDate,"phoneNo":mb,"loginId":userid,"password":pass1,"magicWord":magic,"gender":g,
//                  "thumbnailUrl":strBase64]
//        
//               Alamofire.request(base_url!,method: .post ,parameters:parameters,encoding:JSONEncoding.default).responseString{ response in
//            
//            self.hideActivityIndicator()
//             print(response)
//            let result=response.result
//            print("=======\(result.value)")
//            
//            let rs:String=result.value as String!
//         
//         
//                if(rs.contains("already register")==true)
//                {
//                    let register = UIAlertController(title: "Registration Failed..!!", message: "User Id already registered.. ", preferredStyle: .alert)
//                    let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:{action in self.txtuserid.text=""})
//                    
//                    
//                    
//                    register.addAction(cancelAction)
//                    
//                    self.present(register, animated: true, completion: {  })
//                    
//                    
//                          self.hideActivityIndicator()
//                    
//                }
//
//            if (rs == "true")
//            {
//                
//                
//                let register = UIAlertController(title: "Registration Succesfull...!", message: "Congratulations, You have Registered Sucessfully...!! ", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:{
//                    action in
//                    
//                    self.dismiss(animated: true, completion: nil)
//                   
//
//                })
//                
//                
//                
//                register.addAction(cancelAction)
//                
//                self.present(register, animated: true, completion: {  })
//           
//            }
//            else if(rs == "false")
//            {
//                let register = UIAlertController(title: "Registration Failed..!!", message: "Please try again !", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:{
//                    action in
//                    
//                    self.dismiss(animated: true, completion: nil)
//                    
//                    
//                })
//                
//                
//                
//                register.addAction(cancelAction)
//                
//                self.present(register, animated: true, completion: {  })
//            }
//            else{
//                
//                
//                
//                let register = UIAlertController(title: "Registration Failed..!!", message: "Selected image is larger in size,please select image with 1MB in size ", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//                
//                
//                
//                register.addAction(cancelAction)
//                
//                self.present(register, animated: true, completion: {  })
//                
//                
//            }
//
//            
//            self.hideActivityIndicator()
//            
//            
//        
//        completed()
//    }
//    
//}
    @IBAction func btnmaleclick(_ sender: AnyObject) {
        
        if(btnradiomale.currentImage == #imageLiteral(resourceName: "selected.jpg"))
        {
           // var m:String="Male"
            btnradiofemale.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            btnradiomale.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
        }
        else
        {
            btnradiomale.setImage(#imageLiteral(resourceName: "selected.jpg"), for:UIControlState.normal)
            if(btnradiofemale.currentImage==#imageLiteral(resourceName: "selected"))
            {
                btnradiofemale.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            }
        }
        btnradiomale.setTitle("Male", for:UIControlState.normal)
        btnradiomale.titleLabel?.isHidden=true
        
    }
    @IBAction func btnfemaleclick(_ sender: AnyObject) {
        if(btnradiofemale.currentImage == #imageLiteral(resourceName: "selected.jpg"))
        {
           btnradiomale.setImage(#imageLiteral(resourceName: "unselect"),for:UIControlState.normal)
            
          btnradiofemale.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            
        }
        else
        {
            btnradiofemale.setImage(#imageLiteral(resourceName: "selected.jpg"), for:UIControlState.normal)
            if(btnradiofemale.currentImage==#imageLiteral(resourceName: "selected"))
            {
                btnradiomale.setImage(#imageLiteral(resourceName: "unselect"), for:UIControlState.normal)
            }
            
        }
    btnradiomale.setTitle("Female", for: UIControlState.normal)
        btnradiofemale.titleLabel?.isHidden=true

    }
    func isValidEmail(testStr:String) -> Bool {
        
        
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    
    
    @IBOutlet weak var txtpass: UITextField!
    @IBAction func selectimage(_ sender: AnyObject) {
        
        
        let mypicker=UIImagePickerController()
        mypicker.delegate=self
        mypicker.sourceType=UIImagePickerControllerSourceType.photoLibrary
        self.present(mypicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let profilepic:UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!

                uploadimage.image = profilepic
        self.dismiss(animated: true, completion: nil)

       
        let image : UIImage = profilepic
        
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
         strBase64 = imageData.base64EncodedString()
        
    }
    
    
    func showActivityIndicator() {
        
               DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.orange
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        animateViewMoving(up: true, moveValue: 250)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 250)
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        
        
        
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        
        
        
        UIView.commitAnimations()
    }

    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    
    
   }

extension String
{
    func containsNumbers() -> Bool
    {
        let numberRegEx  = ".*[0-9]+.*"
        let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
}

extension String
{
    func containsCharacters() -> Bool
    {
        let numberRegEx  = ".*[a-zA-Z]+.*"
        let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
}

extension String
{
    func containsNumberCharacters() -> Bool
    {
        let numberRegEx  = ".*[0-9a-zA-Z]+.*"
        let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
}


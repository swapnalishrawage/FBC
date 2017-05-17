//
//  ViewController.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 24/10/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
import FirebaseInstanceID
import FirebaseMessaging
import Firebase
class LoginVC : UIViewController {
   
  
    @IBOutlet weak var mainview: UINavigationItem!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtuserid: UITextField!
    private var _userName:String!
    private var _deviceid:String!
    private var _userid:String!
    private var _userinitials:String!
    private var _thumbnailurl:String!
 var u=[String]()
    var dataref: FIRDatabaseReference!
    
    var _password:String!
    var _name:String!
    var _fname:String!
    var _lname:String!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    
    var userName : String{
        get {
            return _userName
            
        }
        set
        {
            _userName = newValue
        }
    }
    
    var userid:String
        {
        get{
            return _userid
        }
        set{
            _userid=newValue
        }
        
        
    }
    var deviceid : String{
        get {
            return _deviceid
            
        }
        set
        {
            _deviceid = newValue
        }
    }
    
    var userinitials:String
        {
        get{
            return _userinitials
        }
        set{
            _userinitials=newValue
        }
        
        
    }

    
    
    @IBAction func loginclick(_ sender: AnyObject) {
        
        if(txtuserid.text=="" )
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Please Enter UserName ", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            present(passwordcheck, animated: true, completion: {  })
             self.hideActivityIndicator()

        }
            else if(txtpassword.text=="")
        {
            let passwordcheck = UIAlertController(title: "Error", message: "Please Enter Password ", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            passwordcheck.addAction(cancelAction)
            
            
            present(passwordcheck, animated: true, completion: {  })
 self.hideActivityIndicator()
            
        }
//        else if(  !((txtuserid.text?.characters.count)! >= 6) || !((txtuserid.text?.characters.count)! <= 10))
//        {
//            
//            let check = UIAlertController(title: "Error ", message: "  UserId Must be Range of 6-10 digit length", preferredStyle: .alert )
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            check.addAction(okAction)
//            
//            present(check, animated: true, completion: {  })
//             self.hideActivityIndicator()
//        }
//        else if( !((txtpassword.text?.characters.count)! >= 6) || !((txtpassword.text?.characters.count)! <= 10) )
//        {
//            let passwordcheck = UIAlertController(title: "Error", message: " Password Must be  Range 6-10 digit", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//            
//            
//            
//            
//            passwordcheck.addAction(cancelAction)
//            
//            
//            present(passwordcheck, animated: true, completion: {  })
//             self.hideActivityIndicator()
//        }
        else{
            
//            FIRAuth.auth()?.createUser(withEmail: txtuserid.text!, password:txtpassword.text!) { (user, error) in
//                // ...
//                print("sucess...")
//            }
            
            
//            
//            if(FIRInstanceID.instanceID().token() != nil){
//                let token = FIRInstanceID.instanceID().token()!
//                
//                print(token)
//                UserDefaults.standard.set(token, forKey: "FCMToken")
//                connectToFcm()
                
                
                dataref=FIRDatabase.database().reference()
                UserDefaults.standard.set("1", forKey: "Login")
            
            dataref.child("UserRegistration").queryOrdered(byChild: "userid").queryEqual(toValue: txtuserid.text).observeSingleEvent(of: .value, with: { snapshot in
                if snapshot.exists()
                {
                    print(snapshot)
                    if let snapDict = snapshot.value as? [String:AnyObject] {
                        
                        for child in snapDict{
                            if let name = child.value as? [String:AnyObject]{
                                
                                self._name = name["userid"] as! String!
                                print(self._name!)
                                
                            }
                            if let password = child.value as? [String:AnyObject]{
                                
                                self._password = password["password"] as! String!
                                print(self._password)
                                
                                
                            }
                            if let fname = child.value as? [String:AnyObject]{
                                
                                self._fname = fname["fname"] as! String!
                                
                                
                            }
                            if let lname = child.value as? [String:AnyObject]{
                                
                                self._lname = lname["lname"] as! String!
                                
                                
                            }
//                            if let url=child.value as? [String:AnyObject]{
//                                self._thumbnailurl=url["profileimage"] as! String
//                            }
                            
                            
                            if(self.txtuserid.text==self._name && self.txtpassword.text==self._password){
                                // var m=user.init(name: self._name, pass: self._password)
                                UserDefaults.standard.set(self._name, forKey: "uame")
                                UserDefaults.standard.set(child.key, forKey: "KEY")
                                
                                UserDefaults.standard.set(self._password, forKey: "pass")
                                UserDefaults.standard.set(self._fname+" "+self._lname, forKey: "Name")
                                print(UserDefaults.standard.set(self._fname+" "+self._lname, forKey: "Name"))
                                self.u.append("1")
                            }
                            
                            print(child.key)
                            

                        }
                    }

                    
                    
                    

                    
                }
                
            })
            
            if(self.u.count>0)
            {
                self.hideActivityIndicator()
                print("valid")
                self.u.removeAll()
                
                
                
                
                
                UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
                UserDefaults.standard.synchronize()
                
                
                if self.revealViewController() != nil{
                    let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
                    let des=mainstorybord.instantiateViewController(withIdentifier: "ThreadListsVC") as! ThreadListsVC
                    let frontview=UINavigationController.init(rootViewController:des)
                    self.revealViewController().pushFrontViewController(frontview, animated: true)
                }
                else{
                    
                    self.dismiss(animated: true, completion:{action in self.performSegue(withIdentifier: "validuser", sender: nil)})
                }
                
                
                
                
                //self.performSegue(withIdentifier: "validuser", sender: nil)
            }
            else{
                
                self.hideActivityIndicator()
                
                let passwordcheck = UIAlertController(title: "Error", message: "Not valid ", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                passwordcheck.addAction(cancelAction)
                
                
                self.present(passwordcheck, animated: true, completion: {  })
                
                print("not valid")
            }
      
//                dataref.child("UserRegistration").observeSingleEvent(of: .value, with: { (snapshot) in
//                    
//                    
//                    if let snapDict = snapshot.value as? [String:AnyObject] {
//                        
//                        for child in snapDict{
//                            
//                            //  let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
//                            
//                            if let name = child.value as? [String:AnyObject]{
//                                
//                                self._name = name["userid"] as! String!
//                                print(self._name!)
//                                
//                            }
//                            if let password = child.value as? [String:AnyObject]{
//                                
//                                self._password = password["password"] as! String!
//                                print(self._password)
//                                
//                                
//                            }
//                            
//                            
//                            
//                            if let fname = child.value as? [String:AnyObject]{
//                                
//                                self._fname = fname["fname"] as! String!
//                           
//                                
//                            }
//                            if let lname = child.value as? [String:AnyObject]{
//                                
//                                self._lname = lname["lname"] as! String!
//                              
//                                
//                            }
//
//                            
//                            if(self.txtuserid.text==self._name && self.txtpassword.text==self._password){
//                                // var m=user.init(name: self._name, pass: self._password)
//                                UserDefaults.standard.set(self._name, forKey: "uame")
//                                UserDefaults.standard.set(child.key, forKey: "KEY")
//                                
//                                UserDefaults.standard.set(self._password, forKey: "pass")
//                                UserDefaults.standard.set(self._fname+" "+self._lname, forKey: "Name")
//                                print(UserDefaults.standard.set(self._fname+" "+self._lname, forKey: "Name"))
//                                self.u.append("1")
//                            }
//                            
//                            print(child.key)
//                            
//                            
//                        }
//                        //
//                    }
//                    
//                    if(self.u.count>0)
//                    {
//                        self.hideActivityIndicator()
//                        print("valid")
//                        self.u.removeAll()
//                        
//                        
//                        
//                        
//                        
//                        UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
//                        UserDefaults.standard.synchronize()
//                        
//                        
//                        if self.revealViewController() != nil{
//                            let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
//                            let des=mainstorybord.instantiateViewController(withIdentifier: "ThreadListsVC") as! ThreadListsVC
//                            let frontview=UINavigationController.init(rootViewController:des)
//                            self.revealViewController().pushFrontViewController(frontview, animated: true)
//                        }
//                        else{
//                            
//                            self.dismiss(animated: true, completion:{action in self.performSegue(withIdentifier: "validuser", sender: nil)})
//                        }
//
//                        
//                        
//                        
//                       //self.performSegue(withIdentifier: "validuser", sender: nil)
//                    }
//                    else{
//                        
//                        self.hideActivityIndicator()
//                        
//                        let passwordcheck = UIAlertController(title: "Error", message: "Not valid ", preferredStyle: .alert)
//                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
//                        
//                        
//                        
//                        passwordcheck.addAction(cancelAction)
//                        
//                        
//                        self.present(passwordcheck, animated: true, completion: {  })
//                        
//                        print("not valid")
//                    }
//                }) { (error) in
//                    print(error.localizedDescription)
//                }
//
//                
//                
//                
            
                
                
                
                
                
            
                
//                downloadLoginDetails {
//                    
//                }
           // }
            
       
            
        }
        
        
        
        
//        FIRAuth.auth()?.signIn(withEmail: txtuserid.text!, password: txtpassword.text!, completion: {(user,error) in
//        
//            if error != nil{
//                
//                
//                
//                self.handleErrors(err:error as! NSError,loginHandler:loginHandler)
//            
//            
//            }
//            else
//            {
//                loginhandler?(nil)
//            }
//            
//        
//        
//        })
        
        
        //work
//        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
//            if let err:Error = error {
//                print(err.localizedDescription)
//                return
//            }
//            self.performSegue(withIdentifier: "validuser", sender: nil)
//            print("perform signin")
//            
//        })
//        
        
            }
    @IBOutlet weak var loginclick: UIButton!

    
    
    
    
    @IBAction func signupclick(_ sender: Any) {
        
        performSegue(withIdentifier: "Seguesignup", sender: true)
    }
       @IBOutlet weak var SVLoginImage: UIStackView!
    @IBOutlet weak var imgLoginBG: UIImageView!
    @IBAction func forwordclick(_ sender: AnyObject) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        navigationController?.navigationBar.isHidden=false
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.white

        

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
        
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        
        
      
        
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
    }
    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        navigationController?.navigationBar.isHidden=false
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.white

        var savedData = userDefault.bool(forKey: "ISLOGGEDIN")
       
//        if(UserDefaults.standard.value(forKey: "Offlogout") as! String == "0"){
//            savedData=false
//        }
        
        //.set("0", forKey: "Offlogout"))
        if(savedData){
            
            let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let des=mainstorybord.instantiateViewController(withIdentifier: "ThreadListsVC") as! ThreadListsVC
            let frontview=UINavigationController.init(rootViewController:des)
            
            revealViewController().pushFrontViewController(frontview, animated:true)
            
            
        }else{
            print("not allow")
            
        }

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
    
    func connectToFcm() {
        FIRMessaging.messaging().connect{ (error) in
            if(error != nil){
                print("Unable to connect\(error)")
            }
            else{
                print("Connected to FCM")
            }
            
        }

        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return;
        }

    
    
    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
}

}

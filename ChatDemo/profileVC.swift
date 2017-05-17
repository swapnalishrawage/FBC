//
//  profileVC.swift
//  ChatDemo
//
//  Created by sachin shinde on 10/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseCore
import FirebaseDatabase
class profileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate  {
    @IBOutlet weak var lblphone: UILabel!
    private var _userId:String!
    private var _firstName:String!
    @IBOutlet weak var lblname: UILabel!
    private var _lastName:String!
    @IBOutlet weak var lbldtbth: UILabel!
    private var _emailId:String!
    @IBOutlet weak var lblemailid: UILabel!
    private var _dateofBirth:String!
    private var _phoneNo:String!
    private var _loginId:String!
    private var _password:String!
    private var _magicWord:String!
    private var _deviceId1:String!
    private var _registrationId1:String!
    private var _deviceId2:String!
    private var _registrationId2:String!
    private var _deviceId3:String!
    private var _registrationId3:String!
    private var _createTS:String!
    private var _cr:Bool!
    private var _name:String!
    private var _thumbnailUrl:String!
    var strBase64:String=""
    var vc=MenuVC()
    @IBOutlet weak var menu: UIBarButtonItem!
    var uinitial:String=""//UserDefaults.standard.value(forKey: "UserInitials") as! String
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var uid:String!
    var loadingView: UIView = UIView()
   var dataref: FIRDatabaseReference!
    var userId : String{
        get {
            return _userId
            
        }
        set
        {
            _userId = newValue
        }
    }
    
    var firstName:String
        {
        get{
            return _firstName
        }
        set{
            _firstName=newValue
        }
        
        
    }
    var lastName:String
        {
        get{
            return _lastName
        }
        set{
            _lastName=newValue
        }
        
        
    }
    var emailId:String
        {
        get{
            return _emailId
        }
        set{
            _emailId=newValue
        }
        
        
    }
    
    var dateofBirth:String
        {
        get{
            return _dateofBirth
        }
        set{
            _dateofBirth=newValue
        }
        
        
    }
    var phoneNo:String
        {
        get{
            return _phoneNo
        }
        set{
            _phoneNo=newValue
        }
        
        
    }
    var loginId:String{
        get {
            return _loginId
        }
        set{
            _loginId=newValue
        }
    }
    var password:String{
        get {
            return _password
        }
        set{
            _password=newValue
        }
    }
    
    var magicWord:String{
        get {
            return _magicWord
        }
        set{
            _magicWord=newValue
        }
    }
    
    var deviceId1:String{
        get {
            return _deviceId1
        }
        set{
            _deviceId1=newValue
        }
    }
    
    var registrationId1:String{
        get {
            return _registrationId1
        }
        set{
            _registrationId1=newValue
        }
    }
    
    var deviceId2:String{
        get {
            return _deviceId2
        }
        set{
            _deviceId2=newValue
        }
    }
    
    var registrationId2:String{
        get {
            return _registrationId2
        }
        set{
            _registrationId2=newValue
        }
    }
    var deviceId3:String{
        get {
            return _deviceId3
        }
        set{
            _deviceId3=newValue
        }
    }
    var registrationId3:String{
        get {
            return _registrationId3
        }
        set{
            _registrationId3=newValue
        }
    }
    var createTS:String{
        get {
            return _createTS
        }
        set{
            _createTS=newValue
        }
    }
       var thumbnailUrl:String{
        get {
            return _thumbnailUrl
        }
        set{
            _thumbnailUrl=newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden=false
        menu.target=self.revealViewController()
        
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        

//        downloadLoginDetails {
//            
//        }
          uid=UserDefaults.standard.value(forKey: "KEY") as! String
         dataref=FIRDatabase.database().reference()
        dataref.child("UserRegistration").observeSingleEvent(of: .value, with: { (snapshot) in
            //            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
            //                for child in result {
            //                    //do your logic and validation here
            //                    child.value["username"] as! AnyObject
            //                }
            //            } else {
            //                print("no results")
            //            }
            
            
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for child in snapDict{
                    var ID = child.key as! String
                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                    print(snapshot.key)
                    
                    
                    print(shotKey)
                    if(ID==self.uid){
                        
                        if let fname = child.value as? [String:AnyObject]{
                            
                            self._firstName = fname["fname"] as! String!
                   
                            
                        }
                        if let lname = child.value as? [String:AnyObject]{
                            
                            self._lastName = lname["lname"] as! String!
                       
                            
                        }
                        if let phno = child.value as? [String:AnyObject]{
                            
                            self._phoneNo = phno["phno"] as! String!
                            
                            
                        }
                        if let dob = child.value as? [String:AnyObject]{
                            
                            self._dateofBirth = dob["DOB"] as! String!
                            
                            
                        }
                        if let dob = child.value as? [String:AnyObject]{
                            
                            self._emailId = dob["emailid"] as! String!
                            
                            
                        }
                        
                        self.lblname.text=self._firstName+" "+self._lastName
                        
                        self.lbldtbth.text=self._dateofBirth
                        self.lblphone.text=self._phoneNo
                        
                        self.lblemailid.text=self._emailId
                    }
                    
                }
                //                    if(un==_uname && pass==_pass)
                //                    {
                //                        self.lblname.text=_name
                //                        self.lblusername.text=_uname
                //                        self.lblemail.text=_pass
                //                    }
                
                
                
                
                //                    self.dataref.child("Registration").observe(.value, with: { (snapshot) in
                //                        if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                //
                //                            for child in result {
                //                                var ID = child.key as! String
                //
                //                                if(ID==uid)
                //                                {
                //                                    self.lblname.text=_name
                //                                    self.lblusername.text=_uname
                //                                    self.lblemail.text=_pass
                //                                }
                //                                print(ID)
                //                            }
                //                        }
                //                    }
                //                    )
                //
                
                
                
            }
            
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
      
        let navigationBarAppearace = UINavigationBar.appearance()
        let vc=MenuVC()
        vc.loadView()

        navigationBarAppearace.tintColor = UIColor.white//uicolorFromHex(0xffffff)
        
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        navigationController?.navigationBar.isHidden=false
        

    }
    @IBOutlet weak var imagebutton: UIButton!
    @IBAction func picclick(_ sender: AnyObject) {
        let mypicker=UIImagePickerController()
        mypicker.delegate=self
        
            mypicker.sourceType=UIImagePickerControllerSourceType.photoLibrary
        
        
        self.present(mypicker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let profilepic:UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    
        
        self.dismiss(animated: true, completion: nil)
        imagebutton.setImage(profilepic, for:UIControlState.normal)
      //  self.showActivityIndicator()
        let image : UIImage = profilepic
        print(image)
    
        let imageData:NSData!
        
        if((UIImagePNGRepresentation(image)) != nil)
        {
            imageData=UIImagePNGRepresentation(image)! as NSData
        }
        else{
            
            imageData=UIImageJPEGRepresentation(image, 1.0)!  as NSData
            
        }
        strBase64 = imageData.base64EncodedString()
    
        let u:String=UserDefaults.standard.value(forKey: "UserId") as! String
        print("==user single===\(u)")
    let parameters: Parameters = ["userId":u,"thumbanil":strBase64]

        Alamofire.request("http://45.35.4.250/chat/api/Chat/udpdateThumbanil",method: .put,parameters:parameters,encoding:JSONEncoding.default).responseJSON{ response in
            
            //self.showActivityIndicator()
        let result = response.result
            print(result)
            print(response)
        
           if let dict = result.value  as?  Dictionary<String,AnyObject>
                
            {
                var res:AnyObject!
             
                

                if (dict["Success"] as? AnyObject) != nil{
                       res=dict["Success"]!
                }
                else{
               
                    res=0 as AnyObject!
                    let check = UIAlertController(title: "Error ", message: "Selected image is larger in size please select image with  less than 1MB in size", preferredStyle: .alert )
                    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    check.addAction(okAction)
                    
                    self.present(check, animated: true, completion: {  })

                }
                print(dict)
                
                let r:Int=Int(res as! NSNumber)
                
               if (r==1)
                    
                {
                         
                    let check = UIAlertController(title: "Photo Upload ", message: "You have upload photo sucessfully", preferredStyle: .alert )
                    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                    check.addAction(okAction)
                    
                     self.present(check, animated: true, completion: {  })
                    
                    
                     self.hideActivityIndicator()
                    
                    

               }
                
             
            
           else{
         

             self.hideActivityIndicator()
            
            let check = UIAlertController(title: "Error ", message: "Selected image is larger in size please select image with  less than 1MB in size", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            check.addAction(okAction)
            
            self.present(check, animated: true, completion: {  })
          
            
            }
    }
                  }
        hideActivityIndicator()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        //showActivityIndicator()
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
    func hideActivityIndicator() {
        self.loadingView.removeFromSuperview()

        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }


    func downloadLoginDetails(completed: @escaping DownloadComplete){
        
        
              let u:String=UserDefaults.standard.value(forKey: "UserId") as! String
        
        Alamofire.request("http://45.35.4.250/chat/api/Chat/userList?userId=\(u)",method: .get ).responseJSON{ response in
            self.hideActivityIndicator()
            
            let result = response.result
            
            
            
        if let dict = result.value  as?  [Dictionary<String,AnyObject>]
                
            {
                                for userdic in dict {

                if let userid = userdic["userId"] as? String {
                        self._userId=userid
                        let Uid:String = self._userId
                        let cuid=contactList()
                    cuid.userId = Uid
                                           }
                    if let fn=userdic["firstName"] as? String{
                        self._firstName=fn
                        let fnm:String = self.firstName
                    UserDefaults.standard.set(fnm, forKey: "FirstName")
                        
                        
                        
                    }
                    
                    if let ln=userdic["lastName"] as? String{
                        self._lastName=ln
                        let lstnm:String=self.lastName
                         UserDefaults.standard.set(lstnm, forKey: "LastName")
                    }
                    if let email=userdic["emailId"] as? String{
                        self._emailId=email
                self.lblemailid.text = email
                        print(email)
                        
                    }
                    if let phoneno=userdic["phoneNo"] as? String{
                        self._phoneNo=phoneno
                        self.lblphone.text=phoneno
                        print(phoneno)
                        
                    }
                    if let dob=userdic["dateofBirth"] as? String{
                        self._dateofBirth = dob
                        let dateformat1 = DateFormatter()
                        dateformat1.dateFormat = "yyyy-MM-dd"
                        dateformat1.locale = .current
                        
                        
                        
                                               
                        
                        let d1 = dob.components(separatedBy: "T")[0]
                    
                        
                        
                        
                        let dateinput1 = dateformat1.date(from: d1)
                        let dateip = dateformat1.string(from: dateinput1!)

                        self.lbldtbth.text = dateip
                      
                                            }
                    if let thumburl=userdic["thumbnailUrl"] as? String{
                        self._thumbnailUrl=thumburl
                        
                       if(thumburl.isEmpty)
                        {
                            
                            
                            let img = ImageToText()
                            let tempimg = img.textToImage(drawText: self.uinitial as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
                            self.imagebutton.layer.borderColor =
                         UIColor.gray.cgColor
                           self.imagebutton.layer.cornerRadius = 40.7
                            self.imagebutton.layer.masksToBounds = true
                            self.imagebutton.setImage(tempimg, for: UIControlState.normal)
                           
                            
                        }
                        else if(self.imagebutton.image(for: UIControlState.normal)==nil)
                       {
                        let img = ImageToText()
                        let tempimg = img.textToImage(drawText: self.uinitial as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
                        self.imagebutton.layer.borderColor =
                            UIColor.gray.cgColor
                        self.imagebutton.layer.cornerRadius = 40.7
                        self.imagebutton.layer.masksToBounds = true
                        self.imagebutton.setImage(tempimg, for: UIControlState.normal)
                        

                       }
                        else{
                        
                        
                        let imagedownload = DownloadImage()
                        
                        let profileimage = imagedownload.userImage(imageurlString: self._thumbnailUrl)
                        
                        if(profileimage==nil)
                        {
                            let img = ImageToText()
                            let tempimg = img.textToImage(drawText: self.uinitial as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
                            self.imagebutton.layer.borderColor =
                                UIColor.gray.cgColor
                            self.imagebutton.layer.cornerRadius = 40.7
                            self.imagebutton.layer.masksToBounds = true
                            self.imagebutton.setImage(tempimg, for: UIControlState.normal)
                            

                        }
                        else
                        {
                        self.imagebutton.layer.cornerRadius = 40.7
                        self.imagebutton.layer.masksToBounds = true
                        
                             self.imagebutton.setImage(profileimage, for: UIControlState.normal)
                        
                        }
                        }

                    }
                    let fnm:String=UserDefaults.standard.value(forKey: "FirstName") as! String
                    let lsnm:String=UserDefaults.standard.value(forKey: "LastName") as! String
                    self.lblname.text=fnm+" "+lsnm
                }
                
               
               print(response)
            }
            
                       completed()
        
        
        }
        
        
    
        
    
    

    }



}

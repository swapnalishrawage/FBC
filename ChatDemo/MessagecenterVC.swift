//
//  SelectTeacherTestVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 18/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import JSQMessagesViewController
import FirebaseStorage
import Firebase
class MessageCenterVC: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var textmsg: UITextField!
    @IBOutlet weak var hidelabel: UILabel!
    @IBOutlet weak var textviewmsg: UITextView!
    @IBOutlet weak var initiatenewthreadbtn: UIButton!
    @IBOutlet var initiatethreadClick: UIView!
    @IBOutlet weak var selectteacherbtn: UIButton!
    @IBOutlet weak var selectTecherpicker: UIPickerView!
    
    
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    
    var database: FIRDatabase!
    var storage: FIRStorage!

    // Initialize Database, Auth, Storage
  //  database = FIRDatabase.database()
    //storage = FIRStorage.storage()
    
    var contacts:[String] = []
  var clist=[contactList]()
    var userid:String!
    var username:String!
    private var _userId:String!
    private var _firstName:String!
    private var _lastName:String!
    private var _emailId:String!
    private var _dateofBirth:Date!
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
    private var _isActive:Bool!
    private var _gender:String!
    private var _thumbnailUrl:String!
    
    var _thid:String!
    var thID:String!
    
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
    
    var dateofBirth:Date
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
    var isActive:Bool{
        return _isActive
    }
    var gender:String{
        get {
            return _gender
        }
        set{
            _gender=newValue
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
    
    
    
    
    
    //New changes
     var dataref: FIRDatabaseReference!
    var _fname:String!
    var _lname:String!
    @IBAction func backclick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var backclick: UIBarButtonItem!
   
    @IBAction func selectteacherclick(_ sender: AnyObject) {
          showActivityIndicator()
        selectTecherpicker.isHidden=false
       hideActivityIndicator()
       hidelabel.isHidden=true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textmsg.delegate=self
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white        
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

       textmsg.layer.borderColor=UIColor.black.cgColor
        textmsg.layer.borderWidth=1
      textmsg.layer.cornerRadius=5
      //  downloadUserList {}
        self.hideActivityIndicator()
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MessageCenterVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
        
        
        
        
        let metaData = FIRStorageMetadata()
        let storage = FIRStorage.storage()
        
        
        
        dataref=FIRDatabase.database().reference()
        
             
        dataref.child("UserRegistration").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for child in snapDict{
                    let cuid=contactList()
                    var ID = child.key as! String
                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                    
                    
                   
                  //  let downloadURL = metaData.downloadURL()!.absoluteString
                    //store downloadURL at database
                  //  self.dataref.child("UserRegistration").child(child.key).updateChildValues(["profileimage": downloadURL])
               
                    
//                    
//                    let storageRef = storage.reference(forURL: "https://firebasestorage.googleapis.com/v0/b/medicalpatientapp-7fd45.appspot.com/o/iconimages%2Ffile-medical-icons.png?alt=media&token=c95b9c51-67ae-4e93-b63c-62091015a9ff")
//                    // Download the data, assuming a max size of 1MB (you can change this as necessary)
//                    storageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
//                        // Create a UIImage, add it to the array
//                        let pic = UIImage(data: data!)
//                        self.photo1 = pic!

                    
                    
                    
                    
//                    let storageRef = storage.reference(withPath: "Profile.png")//storage.reference("Profile.png")
//                    // Download the data, assuming a max size of 1MB (you can change this as necessary)
//                    storageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
//                        // Create a UIImage, add it to the array
//                        let pic = UIImage(data: data!)
//                        FeedImage.image = pic
//                    })
//                    
//                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    if let fname = child.value as? [String:AnyObject]{
                        
                        self._fname = fname["fname"] as! String!
                        print(self._fname!)
                        
                        
                        
                        
                    }
                    
                    if let lname = child.value as? [String:AnyObject]{
                        
                        self._lname = lname["lname"] as! String!
                        print(self._lname!)
                        
                        
                        
                        
                    }
                    if let image = child.value as? [String:AnyObject]{
                        
                        self._thumbnailUrl = image["profileimage"] as! String!
                    
                        if(self._thumbnailUrl == nil)
                        {
                          self._thumbnailUrl=""
                        }
                        
                        
                        
                    }
                    
                    let t=storage.reference(withPath: "UserRegistration").child(child.key).child("profileimage")
                    
                    let uid:String=UserDefaults.standard.value(forKey: "KEY") as! String
                    
                    cuid.userId=child.key
                    if(cuid.userId==uid)
                    {
                        
                    }
                    else
                    {
                        self.contacts.append(self._fname+" "+self._lname)
                        cuid.username=self._fname+" "+self._lname
                        
                        print(t)
                        
                        cuid.userId=child.key
                        cuid.thumbnailurl=self._thumbnailUrl
                          self.clist.append(cuid)
                    }
                 
                    //self.name1.append(self._fname+" "+self._lname)
                    
                }
                
                
                if(self.clist.count > 0){
                                    self.selectTecherpicker.dataSource=self
                                    self.selectTecherpicker.delegate=self
                                    self.hideActivityIndicator()
                                }
               
                            else{
                                self.hidelabel.isHidden=false
                                self.selectTecherpicker.isHidden=true
                                
                            }

                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    //let dataref=FIRDatabase.database().reference()
    func sendMessgae(senderID:String,senderName:String,text:String,threadid:String,time:String,threadname:String,image:String){
        
        
        
        
        let msg:[String:AnyObject]=["senderId":senderID as AnyObject ,"senderName":senderName as AnyObject ,"msg":text as AnyObject ,"threadId":threadid as AnyObject,"timestamp":time as AnyObject ,"threadname":threadname as AnyObject,"thumbnail":image as AnyObject ]
        
        
        
        dataref.child("ThreadList").childByAutoId().setValue(msg)
        
        
 
        
    }
    
func updatethresadlist(text:AnyObject,time:AnyObject,sendername:AnyObject)
{
    let dataref=FIRDatabase.database().reference()
    
    let key:String=(UserDefaults.standard.value(forKey: "ChildKey") as? String)!
    print(key)
    let userReference = dataref.child("ThreadList").child(key)
   // var t1:String!
    //
    //        if(time.contains(" "))
    //        {
    //            t1=time.components(separatedBy: " ")[1]
    //        }
    //
    //        print(t1)
    
    
    //var thid:String=UserDefaults.value(forKey: "ThreadID") as! String//.standard.setValue(LastMsg.ThreadId, forKey: "ThreadID")
    let values = ["msg": text] as [String : Any]
    let t = ["timestamp": time] as [String : Any]
    let sn = ["senderName": sendername] as [String : Any]
    
    print(sendername)
    // Update the "email" value in the database for the logged in user
    userReference.updateChildValues(values, withCompletionBlock: { (err, dataref) in
        if err != nil {
            return
        }
        print("Successfully saved user to database.")
        
        //self.dismiss(animated: true, completion: nil)
    })
    
    
    
    dataref.child("ThreadList").child(key).child("msg").setValue(text)
    
    
    dataref.child("ThreadList").child(key).child("senderName").setValue(sendername)
    
dataref.child("ThreadList").child(key).child("timestamp").setValue(time)
    
    print(time)
    //        if(time.components(separatedBy: " ").count>0)
    //        {
    //        print(time.components(separatedBy: " ")[1])
    //        }
    //   print(time.components(separatedBy: " ")[1])
    
    
    //dataref.child("ThreadList").child(key).child("timestamp").setValue("pratik")
    
    // dataref.child("ThreadList").child(key).child("timestamp").setValue(time)
    
    
    
    //        userReference.updateChildValues(t, withCompletionBlock: { (err, dataref) in
    //            if err != nil {
    //                return
    //            }
    //            print("Successfully saved user to database.")
    //
    //            //self.dismiss(animated: true, completion: nil)
    //        })
    //        userReference.updateChildValues(sn, withCompletionBlock: { (err, dataref) in
    //            if err != nil {
    //                return
    //            }
    //            print("Successfully saved user to database.")
    //
    //            //self.dismiss(animated: true, completion: nil)
    //        })
    
}

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        animateViewMoving(up: true, moveValue: 240)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 240)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dismissKeyboard()
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
       //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func initialtethreadClick(_ sender: AnyObject) {
        
       
        
        if(textmsg.text == "")
        {
            
            let initiateNewThread = UIAlertController(title: "Error", message: "Please enter message", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            initiateNewThread.addAction(cancelAction)
            
            
            self.present(initiateNewThread, animated: true, completion: {  })
            
                  }
            else if(selectteacherbtn.titleLabel?.text == "Select Users")
            {
                dismissKeyboard()
                
                let initiateNewThread1 = UIAlertController(title: "Error", message: "Please select at least one user", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
                
                
                
                initiateNewThread1.addAction(cancelAction)
                
                
                self.present(initiateNewThread1, animated: true, completion: {  })
                
            }
        else{
            
            
            
            
            
            
            let m0 = userid
           
                                let date = Date()
                    let dateformatter = DateFormatter()
            
                    dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                    let d:String=dateformatter.string(from: date)
            
                    let msg:String = textmsg.text!
                  //  let msgsenderid:String = UserDefaults.standard.value(forKey: "UserId") as! String
           let uid:String=UserDefaults.standard.value(forKey: "KEY") as! String
            let uname:String=UserDefaults.standard.value(forKey: "Name") as! String
            
            UserDefaults.standard.set("1", forKey: "set")//.value(forKey: "set")
            
            var isalready:Bool=Alreadyavailable(thid1: uid+","+userid,thid0:userid+","+uid)

            
            print(isalready)
            
            var test:String = UserDefaults.standard.value(forKey: "set") as! String
            
         
//if(test=="0")
//{ 
            UserDefaults.standard.set("0", forKey: "MS")
            if(isalready==true)
            {
             updatethresadlist(text: msg as AnyObject, time: d as AnyObject, sendername: username as AnyObject)
                
                
              
            }
            else{
            
            
                 //updatethresadlist(text: msg as AnyObject, time: d as AnyObject, sendername: username as AnyObject)
               
               
//                if(test=="0")
//                {
                sendMessgae(senderID: uid, senderName: username, text: msg, threadid: uid+","+userid, time: d, threadname: uname+","+username,image:thumbnailUrl)
                //}
            
           }
    
            
            
        //  use
            MessageHandler.instance.sendMessgae(senderID: uid, senderName: username, text: msg, threadid: uid+","+userid,time:d,url:thumbnailUrl)
            
    self.dismiss(animated: true) {}

           
           
            
            
            
         
         // messgaeReceived(senderID: uid, senderName:"", text: msg,date:d)
            
            
            
        }
            
        
    }
    func Alreadyavailable(thid1:String,thid0:String) ->Bool
    {
        var thread=thid1
        
        var m:Bool=false
        
        dataref=FIRDatabase.database().reference()
        
        
       
        dataref.child("ThreadList").observe(FIRDataEventType.childChanged, with: { (snapshot) in
            UserDefaults.standard.set("0", forKey: "set")
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for child in snapDict{
                    var ID = child.key as! String
                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                    
                    
                    
                    
//                    
//                    if let thid = child.value as? [String:AnyObject]{
//                        
//                        self._thid = thid["threadId"] as! String!
//                        
//                        
//                    }
                    
                    
                    
                    
                    if let thid = child.value as? [String:AnyObject]{
                        
                        
                        
                        
                        if(thid["threadId"] as! String != nil){
                            self.thID = thid["threadId"] as! String
                            
                            
                            if(  self.thID==thid1 || self.thID==thid0){
                                
                                print("Yes Available")
                                m=true
                           break
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                 
                    
                    
                    
                }
                
                
                
                
                
                
            }
            
            
        }) {
                            (error) in
            UserDefaults.standard.set("1", forKey: "set")

            print(error.localizedDescription)
        }
        
        
   
    return m
        
        
    }
 
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contacts.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contacts[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectteacherbtn.setTitle(contacts[row], for: UIControlState())
        userid=clist[row].userId
        username=clist[row].username
        thumbnailUrl=clist[row].thumbnailurl
        selectTecherpicker.isHidden=true
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let  myView = UIView(frame: CGRect(x: 0, y: 0, width:pickerView.bounds.width-30 ,height: 30))
     
        let imgview:UIImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let metaData = FIRStorageMetadata()
        let storage = FIRStorage.storage()

        
       // let downloadURL = metaData.downloadURL()!.absoluteString
        //store downloadURL at database
       // self.dataref.child("UserRegistration").child(child.key).updateChildValues(["profileimage": downloadURL])
        
        
        //
        //                    let storageRef = storage.reference(forURL: "https://firebasestorage.googleapis.com/v0/b/medicalpatientapp-7fd45.appspot.com/o/iconimages%2Ffile-medical-icons.png?alt=media&token=c95b9c51-67ae-4e93-b63c-62091015a9ff")
        //                    // Download the data, assuming a max size of 1MB (you can change this as necessary)
        //                    storageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
        //                        // Create a UIImage, add it to the array
        //                        let pic = UIImage(data: data!)
        //                        self.photo1 = pic!
        
        
        
        
        
        
        
        //work
        
        var pic:UIImage!
//       
//        
//        let storageRef = storage.reference(withPath: "s1.png")//
//        
//        
//        
//        // Download the data, assuming a max size of 1MB (you can change this as necessary)
//        
//      //  storageRef.child("Profile.png").getDownloadUrl().getResult();
//        storageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
//            // Create a UIImage, add it to the array
//            
//            
//            if (error != nil) {
//                print(error.debugDescription)
//           } else {
//             pic = UIImage(data: data!)
//                
//                let imageData:NSData = UIImagePNGRepresentation(pic)! as NSData
//                
//                imgview.image=pic
//                print(pic)
//                
//                
//              let strBase64:String = imageData.base64EncodedString()//.base64EncodedData(options:)
//                
//                
//                
//               // var imageData = UIImageJPEGRepresentation(pic, 1)
//               //// var base64String = Base64Convertor.encodeBase64WithData(imageData)
//             self.clist[row].thumbnailurl=strBase64
//            }
//            
//            
//        }
        
        
        
        
        
        
        
        //////other use
        
//        let dataref=FIRDatabase.database().reference()
//        let dbRef = FIRDatabase.database().reference().child("UserRegistration")
//        dbRef.observe(.value, with: { (snapshot) in
            // Get download URL from snapshot
          //  let downloadURL = snapshot.value as! String
            // Create a storage reference from the URL
        
            var m=self.clist.count-1
            let storageRef = FIRStorage.storage().reference(withPath:"s1.png")
            // Download the data, assuming a max size of 1MB (you can change this as necessary)
   
            storageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
                
                
                
                // Do something with downloaded data...
                
                if (error != nil) {
                    print(error.debugDescription)
                } else {
                    pic = UIImage(data: data!)
                    
                    let imageData:NSData = UIImagePNGRepresentation(pic)! as NSData
                    
                    imgview.image=pic
                    print(pic)
                    
                    
                    let strBase64:String = imageData.base64EncodedString()//.base64EncodedData(options:)
                    
                    
                    
                    // var imageData = UIImageJPEGRepresentation(pic, 1)
                    //// var base64String = Base64Convertor.encodeBase64WithData(imageData)
                    self.clist[row].thumbnailurl=strBase64
                }
            }
    
       // })
      
        
        
        
        
        
        
        
        
        
        
        
        
        
        //////////
//        let ref = Firebase(url: "gs://pushmynotice-55d27.appspot.com/Profile.png")
//        
//        ref.observeEventType(.Value, withBlock: { snapshot in
//            
//            self.base64String = snapshot.value as! NSString
//            let decodedData = NSData(base64EncodedString: self.base64String as String, options: NSDataBase64DecodingOptions())
//            //Next line is giving the error
//            var decodedImage = UIImage(data: decodedData!)
//            
//            self.image.image = decodedImage
//        }, withCancelBlock: { error in
//            print(error.description)
//        })
//        

        
       
        
        let v = contacts[row]
        let stArr = v.components(separatedBy: " ")
        var st=""
        for s in stArr{
            if let      str=s.characters.first{
                st+=String(str).capitalized
            }
        }
        
               if(clist[row].thumbnailurl.isEmpty)
        {
            let img = ImageToText()
            let tempimg = img.textToImage(drawText: st as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
            imgview.layer.borderColor = UIColor.gray.cgColor
            imgview.layer.cornerRadius = 15.7
            imgview.layer.masksToBounds = true
            imgview.image = tempimg
            
        }
        else{
            
            let imagedownload = DownloadImage()
            
            let profileimage = imagedownload.userImage(imageurlString: clist[row].thumbnailurl)
            if(pic != nil)
            {
                imgview.layer.borderColor = UIColor.gray.cgColor
                imgview.layer.cornerRadius = 15.7
                imgview.layer.masksToBounds = true
                imgview.image = pic
                
            }
            else
            {
                let img = ImageToText()
                let tempimg = img.textToImage(drawText: st as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
                imgview.layer.borderColor = UIColor.gray.cgColor
                imgview.layer.cornerRadius = 15.7
                imgview.layer.masksToBounds = true
                imgview.image = tempimg
                
            }
            
        }

        
               let uname = contacts[row]
        
        let myLabel=UILabel(frame:(CGRect(x:100, y: 0, width: 200, height: 30)))
        
        
        myLabel.text = uname
        
        myView.addSubview(myLabel)
        
        myView.addSubview(imgview)
        return myView
        
        
        
        
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
         
       @IBAction func backbtnClicked(_ sender: AnyObject) {
        
        self.dismiss(animated: true) { 
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsWhenKeyboardAppears = false
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

    }
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
}


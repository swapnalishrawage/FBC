 //
//  ThreadListsVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 19/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import FirebaseDatabase
import FirebaseMessaging
import Firebase

class ThreadListsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MessageReceivedDelegate {
    @IBOutlet weak var hidelabel: UILabel!
    @IBOutlet var chatview: UIView!
    @IBOutlet weak var hideview: UIView!
      var name1=[String]()
    var uniquethid=[String]()
    @IBOutlet var mainview: UIView!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet var threadview: UIView!
    @IBOutlet weak var menuview: UIView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    var menushow=false
    var c:Int=0
    @IBOutlet weak var rightmenu: UIBarButtonItem!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    var _fname:String!
    var _lname:String!
    var uid:String!
    var _senderid:String!
    var _msg:String!
    var _thid:String!
    var _time:String!
     var dataref: FIRDatabaseReference!
    
    
        var LastMsgList=[LastMsgDtls]()
    var lastMsg=[LastMsgDtls]()

       @IBOutlet var menudisply: UIView!
    
    @IBAction func click(_ sender: Any) {
        performSegue(withIdentifier: "squeselectuser", sender: nil)
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad()
    {
         super.viewDidLoad()
         UserDefaults.standard.set("TH", forKey: "PAGE")
        
MessageHandler.instance.delegate=self
        
        tableview.reloadData()
        tableview.isHidden=false
        hidelabel.isHidden=true
        hideview.isHidden=true
//        if(LastMsgList.count==0)
//        {
//            tableview.isHidden=true
//            hidelabel.isHidden=false
//            hideview.isHidden=false
//        }
       
    NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)),name:NSNotification.Name(rawValue: "loadThread"), object: nil)
        LastMsgList.removeAll()
       navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
    navigationController?.navigationBar.isHidden=false

        
    self.navigationController?.navigationBar.tintColor=UIColor.white

        
              self.hideActivityIndicator()
        
        
                self.hideActivityIndicator()
        
        let all2 = FIRDatabase.database().reference(withPath:"ThreadList")
        all2.keepSynced(true)
        
        
          UserDefaults.standard.set("1", forKey: "MS")
        
        
        
        
               
      
     MessageHandler.instance.observerThreadlist()
  
     // MessageHandler.instance.observemesage(receiver: "")
        
        

    }
    func messgaeReceived(senderID: String, senderName: String, text: String, date: Date) {
        
    // updatethresadlist(text: text as AnyObject, time: date as AnyObject, sendername: senderName as AnyObject)
        
       
      // viewWillAppear(true)
        
        
        var th:String=UserDefaults.standard.value(forKey: "ThreadID") as! String
        var a:String!
        var b:String!
        if(th=="")
        {
            a=""
            b=""
        }
        else{
            a=th.components(separatedBy: ",")[0]
            b=th.components(separatedBy: ",")[1]
            
        }
//        let thread0=LastMsgDtls(LastMsgSender: self._lname, Lastmsgtext: self._msg, LastMsgTime: self._time, LastmsgSenderimage: "", ThreadName: self._fname,ThreadId:self._thid/*self.uid+","+ID*/,reciverId: "",childkey:"")
//        
//        
//        self.LastMsgList.append(thread0)
        
        
        //let date = Date()
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let d:String=dateformatter.string(from: date)
        
let t=datefile ()
        var m=t.getDate(date: d, FLAG: "D", t: d)
        
        
        if(LastMsgList.count>0)
        {
        for i in 0...LastMsgList.count-1
        {
            if(LastMsgList[i].ThreadId==th || LastMsgList[i].ThreadId==b+","+a)
            {
                LastMsgList[i].LastMsgSender=senderName
                LastMsgList[i].Lastmsgtext=text
                LastMsgList[i].LastmsgSenderimage=""
                LastMsgList[i].LastMsgTime=m
                
            }
        }
        }
        else{
           threadlistloadatchange()
        }
        tableview.reloadData()
        tableview.dataSource=self
        tableview.delegate=self
    }
    func mediaReceived(senderID: String, senderName: String, url: String) {
       
    }
    func threadUpdate(senderID: String, senderName: String, text: String, date: Date) {
      updatethresadlist(text: text as AnyObject, time: date as AnyObject, sendername: senderName as AnyObject)
       
        let all2 = FIRDatabase.database().reference(withPath:"ThreadList")
        all2.keepSynced(true)
        
        
        
        
        
        
        
        
        
        
        var th:String=UserDefaults.standard.value(forKey: "ThreadID") as! String
        var a:String!
        var b:String!
        if(th=="")
        {
            a=""
            b=""
        }
        else{
            a=th.components(separatedBy: ",")[0]
            b=th.components(separatedBy: ",")[1]
            
        }
                
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let d:String=dateformatter.string(from: date)
        
        let t=datefile ()
        var m=t.getDate(date: d, FLAG: "D", t: d)
        
        
        if(LastMsgList.count>0)
        {
            for i in 0...LastMsgList.count-1
            {
                if(LastMsgList[i].ThreadId==th || LastMsgList[i].ThreadId==b+","+a)
                {
                    LastMsgList[i].LastMsgSender=senderName
                    LastMsgList[i].Lastmsgtext=text
                    LastMsgList[i].LastmsgSenderimage=""
                    LastMsgList[i].LastMsgTime=m
                    
                }
            }
        }
        else{
            threadlistloadatchange()
        }
        tableview.reloadData()
        tableview.dataSource=self
        tableview.delegate=self

        
       
            }
    
    
    
    
    
   
    
    func loadList(notification: NSNotification){
      
              
                if(!LastMsgList.isEmpty)
                {
                    LastMsgList.removeAll()
                    
                }
        
                    
                       loadingView.isHidden=false
                   // downloadthreadlistDetails {}
        loadingView.removeFromSuperview()
        loadingView.isHidden=true
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        spinner.backgroundColor=UIColor.white
       
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination=segue.destination as? SelectMessageCenterListVC{
            if let msg=sender as?  LastMsgDtls{
                print("open")
            }
        }
    }
    


    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        
        tableview.isHidden=false
        LastMsgList.removeAll()
        let all2 = FIRDatabase.database().reference(withPath:"ThreadList")
        all2.keepSynced(true)
        tableview.reloadData()
     //        if(LastMsgList.count==0)
//        {
//            tableview.isHidden=true
//            hidelabel.isHidden=false
//             hideview.isHidden=false
//        }
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
        
        
        if self.revealViewController() != nil{
            menu.target=self.revealViewController()
            
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
            mainview.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        self.navigationController?.isNavigationBarHidden=false;
        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        navigationController?.navigationBar.isHidden=false
        
        self.navigationController?.navigationBar.tintColor=UIColor.white
        
        if(!LastMsgList.isEmpty)
        {
            LastMsgList.removeAll()
            tableview.reloadData()
            
        }
        else{
            
            
            
            
            
            dataref=FIRDatabase.database().reference()
            
            uid=UserDefaults.standard.value(forKey: "KEY") as! String
            
            ////
//            dataref.child("UserRegistration").observeSingleEvent(of: .value, with: { (snapshot) in
//                
//                
//                
//                if let snapDict = snapshot.value as? [String:AnyObject] {
//                    
//                    for child in snapDict{
//                        var ID = child.key as! String
//                        let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        if let fname = child.value as? [String:AnyObject]{
//                            
//                            self._fname = fname["fname"] as! String!
//                            print(self._fname!)
//                            
//                            
//                            
//                            
//                        }
//                        
//                        if let lname = child.value as? [String:AnyObject]{
//                            
//                            self._lname = lname["lname"] as! String!
//                            print(self._lname!)
//                            
//                            
//                            
//                            
//                        }
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        if(ID==self.uid)
//                        {
//                            print("user itself")
//                        }
//                        else{
//                            //self.name1.append(self._fname+" "+self._lname)
//                            
//                            
//                            
//                            
//                            
//                            
//                            let thread0=LastMsgDtls(LastMsgSender: "", Lastmsgtext: "...", LastMsgTime: "10:30 AM", LastmsgSenderimage: "", ThreadName: self._fname+" "+self._lname,ThreadId:self.uid+","+ID,reciverId: "",childkey:ID)
//                            
//                            
//                            
//                            
//                            
//                            
////                            self.dataref.child("Messages").observeSingleEvent(of: .value, with: { (snapshot) in
////                                
////                                
////                                
////                                if let snapDict = snapshot.value as? [String:AnyObject] {
////                                    
////                                    for child in snapDict{
////                                        var ID = child.key as! String
////                                        let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
////                                        
////                                        
////                                        
////                                        
////                                        
////                                        
////                                        
////                                        if let th = child.value as? [String:AnyObject]{
////                                            
////                                            self._thid = th["threadId"] as! String!
////                                            print(self._thid)
////                                            
////                                            
////                                        }
////                                        
////                                        if let msg = child.value as? [String:AnyObject]{
////                                            
////                                            self._msg = msg["msg"] as! String!
////                                            
////                                            
////                                        }
////                                        if let time = child.value as? [String:AnyObject]{
////                                            
////                                            self._time = time["timestamp"] as! String!
////                                            
////                                            
////                                        }
////                                        if let senderid = child.value as? [String:AnyObject]{
////                                            
////                                            self._senderid = senderid["senderId"] as! String!
////                                            
////                                            
////                                        }
////                                        
////
////                                        
////                                        if(thread0.ThreadId==self._thid)
////                                        {
////                                            
////                                            let th1=LastMsgDtls(LastMsgSender: "", Lastmsgtext: self._msg, LastMsgTime: self._time, LastmsgSenderimage: "")
////                                            self.lastMsg.append(th1)
////                                            
////                                            
////                                        }
////                                    
////                                    
////                                    
////                                    
////                                    
////                                    
////                                    
////                                    }
////                                
////                                print(self.lastMsg)
////                                
////                                
////                                }})
////                            
//                            
//                            
//                            
//                            
//                            
//                            
//                            
//                            
//                            
//                           
//                            self.LastMsgList.append(thread0)
//                        }
//                        
//                        
//                    }
//                    self.tableview.dataSource=self
//                    self.tableview.delegate=self
//                    self.tableview.reloadData()
//                    
//                    
//                    
//                    
//                }
//            }) { (error) in
//                print(error.localizedDescription)
//            }
            
            
            
            
            
            
            //Threadlist table
            
//            
//                        dataref.child("ThreadList").observeSingleEvent(of: .value, with: { (snapshot) in
//        
//            
//                            if(snapshot.childrenCount==0)
//                            {
//                                self.tableview.isHidden=true
//                                self.hidelabel.isHidden=false
//                            }
//                            else{
//                            if let snapDict = snapshot.value as? [String:AnyObject] {
//            
//                                for child in snapDict{
//                                    var ID = child.key as! String
//                                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
//            
//            
//            
//            
//            
//            
//            
//                                    if let fname = child.value as? [String:AnyObject]{
//            
//                                        self._fname = fname["threadname"] as! String!
//                                       
//            
//            
//            
//            
//                                    }
//            
//                                    if let msg = child.value as? [String:AnyObject]{
//            
//                                        self._msg=msg["msg"] as! String!
//            
//            
//            
//            
//                                    }
//            
//            
//                                    if let time = child.value as? [String:AnyObject]{
//            
//                                        self._time = time["timestamp"] as! String!
//            
//            
//            
//            
//            
//                                    }
//                         if let thid = child.value as? [String:AnyObject]{
//            
//                                                    self._thid = thid["threadId"] as! String!
//            
//            
//            
//            
//            
//                                                }
//            
//            
//            
//                                    if let lname = child.value as? [String:AnyObject]{
//
//                                        self._lname = lname["senderName"] as! String!
//                                        
//                                        
//                                        
//                                        
//                                        
//                                    }
//            
//                                    if(self._thid != nil){
//                                        if(self._thid.contains(self.uid))
//                                        {
//                                            
//                                            
//                                            
//                                            
//                                            
//                                            let thread0=LastMsgDtls(LastMsgSender: self._lname, Lastmsgtext: self._msg, LastMsgTime: self._time, LastmsgSenderimage: "", ThreadName: self._fname,ThreadId:self._thid/*self.uid+","+ID*/,reciverId: "",childkey:ID)
//                                            
//                                            
//                                            self.LastMsgList.append(thread0)
//                                            
//                                            
//                                        }
//                                        else{
//                                            
//                                            
//                                            
//                                            
//                                            
//                                            //self.name1.append(self._fname+" "+self._lname)
//                                        }
//                                    }
//                                        
//                                    else{
//                                        
//                                    }
//                                
//                                    
//                                }
//                                if(self.LastMsgList.count != 0)
//                                            {
//                                                self.tableview.isHidden=false
//                                                
//                                               
//                                
//                                                if (self.tableview.contentSize.height < self.tableview.frame.size.height) {
//                                                    self.tableview.isScrollEnabled = false;
//                                                    if(self.LastMsgList.count>6)
//                                                    {
//                                                        self.tableview.isScrollEnabled = true;
//                                                    }
//                                                    
//                                                    
//                                                }
//                                                else {
//                                                    self.tableview.isScrollEnabled = true;
//                                                }
//                                                
//                                                
//                                            }
//                                            else
//                                            {
//                                                self.tableview.isHidden=true
//                                                self.hidelabel.isHidden=false
//                                                self.hideview.isHidden=false
//                                                
//                                            }
//
//                                self.tableview.dataSource=self
//                                self.tableview.delegate=self
//                                self.tableview.reloadData()
//                                
//                                
//                                
//                                
//                            }
//                            }
//                        }) { (error) in
//                            print(error.localizedDescription)
//                        }
//            
          
            threadlistload()
            print(name1)
            self.tableview.dataSource=self
            self.tableview.delegate=self
            self.tableview.reloadData()
//            MessageHandler.instance.delegate=self
//               MessageHandler.instance.observerThreadlist()
            // downloadthreadlistDetails {}
            
        }

        
        
    }
    
    
    func threadlistload()
    {
        LastMsgList.removeAll()
         dataref=FIRDatabase.database().reference()
        dataref.child("ThreadList").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if(snapshot.childrenCount==0)
            {
                self.tableview.isHidden=true
                self.hidelabel.isHidden=false
            }
            else{
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for child in snapDict{
                        var ID = child.key as! String
                        let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                        
                        
                        
                        
                        
                        
                        
                        if let fname = child.value as? [String:AnyObject]{
                            
                            self._fname = fname["threadname"] as! String!
                            
                            
                            
                            
                            
                        }
                        
                        if let msg = child.value as? [String:AnyObject]{
                            
                            self._msg=msg["msg"] as! String!
                            
                            
                            
                            
                        }
                        
                        
                        if let time = child.value as? [String:AnyObject]{
                            
                            self._time = time["timestamp"] as! String!
                          
                            
                            
                            
                            
                            
                        }
                        if let thid = child.value as? [String:AnyObject]{
                            
                            self._thid = thid["threadId"] as! String!
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        if let lname = child.value as? [String:AnyObject]{
                            
                            self._lname = lname["senderName"] as! String!
                            
                            
                            
                            
                            
                        }
                        
                        if(self._thid != nil){
                            if(self._thid.contains(self.uid))
                            {
                                
                                
                                
//                                
//                               if( self._time.contains(" ")
//                                )
//                               {
//                                self._time=self._time.components(separatedBy: " ")[1]
//                                
//                                
//                                }
                               let dateobj = datefile()
//                                let dateformatter = DateFormatter()
//                                dateformatter.dateFormat = "yyyy-dd-MM HH:mm:ss"
//                                //let d:String=dateformatter.string(from: date)
//                                let d=dateformatter.date(from: self._time)
//                                let d1:String=dateformatter.string(from: d!)
//                                let t=datefile ()
                                
                                
                                print(self._time)
                                
                                var m:String!
                           m=dateobj.getDate(date: self._time, FLAG: "D", t: self._time)
                                
                                print(m)
                          
                                                               let thread0=LastMsgDtls(LastMsgSender: self._lname, Lastmsgtext: self._msg, LastMsgTime: m, LastmsgSenderimage: "", ThreadName: self._fname,ThreadId:self._thid/*self.uid+","+ID*/,reciverId: "",childkey:ID)
                                
                                
                               
                                self.LastMsgList.append(thread0)
                                
                       
                            }
                            else{
                                
                                
                                
                                
                                
                                //self.name1.append(self._fname+" "+self._lname)
                            }
                        }
                            
                        else{
                            
                        }
                        
                        
                    }
                    if(self.LastMsgList.count != 0)
                    {
                        self.tableview.isHidden=false
                        
                    

                        
                        if (self.tableview.contentSize.height < self.tableview.frame.size.height) {
                            self.tableview.isScrollEnabled = false;
                            if(self.LastMsgList.count>6)
                            {
                                self.tableview.isScrollEnabled = true;
                            }
                            
                            
                        }
                        else {
                            self.tableview.isScrollEnabled = true;
                        }
                        
                        
                    }
                    else
                    {
                        self.tableview.isHidden=true
                        self.hidelabel.isHidden=false
                        self.hideview.isHidden=false
                        
                    }
                    
                    self.tableview.dataSource=self
                    self.tableview.delegate=self
                    self.tableview.reloadData()
                    
                    
                    
                    
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        

    }
    func threadlistloadatchange(){
      
        dataref=FIRDatabase.database().reference()
        dataref.child("ThreadList").observeSingleEvent(of: .childChanged, with: { (snapshot) in
            
            
            if(snapshot.childrenCount==0)
            {
                self.tableview.isHidden=true
                self.hidelabel.isHidden=false
            }
            else{
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for child in snapDict{
                        var ID = child.key as! String
                        let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                        
                        
                        
                        
                        
                        
                        
                        if let fname = child.value as? [String:AnyObject]{
                            
                            self._fname = fname["threadname"] as! String!
                            
                            
                            
                            
                            
                        }
                        
                        if let msg = child.value as? [String:AnyObject]{
                            
                            self._msg=msg["msg"] as! String!
                            
                            
                            
                            
                        }
                        
                        
                        if let time = child.value as? [String:AnyObject]{
                            
                            self._time = time["timestamp"] as! String!
                            
                            
                            
                            
                            
                            
                        }
                        if let thid = child.value as? [String:AnyObject]{
                            
                            self._thid = thid["threadId"] as! String!
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        if let lname = child.value as? [String:AnyObject]{
                            
                            self._lname = lname["senderName"] as! String!
                            
                            
                            
                            
                            
                        }
                        
                        if(self._thid != nil){
                            if(self._thid.contains(self.uid))
                            {
                                
                                
                                
                                //
                                //                               if( self._time.contains(" ")
                                //                                )
                                //                               {
                                //                                self._time=self._time.components(separatedBy: " ")[1]
                                //
                                //
                                //                                }
                                let dateobj = datefile()
                                // self._time=dateobj.getDate(date: self._time, FLAG: "D", t: self._time)
                                
                                
                                ///////////////
                                
                               // let thread0=LastMsgDtls(LastMsgSender: self._lname, Lastmsgtext: self._msg, LastMsgTime: self._time, LastmsgSenderimage: "", ThreadName: self._fname,ThreadId:self._thid/*self.uid+","+ID*/,reciverId: "",childkey:ID)
                                
                                
                               // self.LastMsgList.append(thread0)
                                
                                
                            }
                            else{
                                
                                
                                
                                
                                
                                //self.name1.append(self._fname+" "+self._lname)
                            }
                        }
                            
                        else{
                            
                        }
                        
                        
                    }
                    if(self.LastMsgList.count != 0)
                    {
                        self.tableview.isHidden=false
                        
                        
                        
                        if (self.tableview.contentSize.height < self.tableview.frame.size.height) {
                            self.tableview.isScrollEnabled = false;
                            if(self.LastMsgList.count>6)
                            {
                                self.tableview.isScrollEnabled = true;
                            }
                            
                            
                        }
                        else {
                            self.tableview.isScrollEnabled = true;
                        }
                        
                        
                    }
                    else
                    {
                        self.tableview.isHidden=true
                        self.hidelabel.isHidden=false
                        self.hideview.isHidden=false
                        
                    }
                    
//                    self.tableview.dataSource=self
//                    self.tableview.delegate=self
//                    self.tableview.reloadData()
                    
                    
                    
                    
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func updatethresadlist(text:AnyObject,time:AnyObject,sendername:AnyObject)
    {
        let dataref=FIRDatabase.database().reference()
        
        let key:String=(UserDefaults.standard.value(forKey: "ChildKey") as? String)!
        print(key)
        let userReference = dataref.child("ThreadList").child(key)
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
        
        //dataref.child("ThreadList").child(key).child("timestamp").setValue(time)
        
        print(time)
        let all2 = FIRDatabase.database().reference(withPath:"ThreadList")
        all2.keepSynced(true)
        
        
        
//        self.tableview.dataSource=self
//        self.tableview.delegate=self
//        self.tableview.reloadData()
        
    }
    
    
    
    
    
    

    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      
        if self.revealViewController() != nil{
            
            menu.target=self.revealViewController()
            
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
            mainview.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        if( UserDefaults.standard.value( forKey: "MS") as! String=="0"){
     MessageHandler.instance.delegate=self
      MessageHandler.instance.observerThreadlist()
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return LastMsgList.count
    }
    
    @IBOutlet weak var initialName: UILabel!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LastMessageTableCell",for:indexPath) as? LastMessageTableCell
        {
            
            let LastMsg=LastMsgList[indexPath.row]
            
            
            //  let item = name1[indexPath.row]
            
            let dateformat1 = DateFormatter()
            dateformat1.dateFormat = "yyyy-MM-dd"
            dateformat1.locale = .current
            
            
            
            
            
            
            
            
            
            
           var new=LastMsg.LastMsgTime

            let dateobj = datefile()
       
            
            let d1 = LastMsg.LastMsgTime.components(separatedBy: " ")[0]
//
//
//    

            var dateinput1 = dateformat1.date(from: d1)
            
            
            
            if(dateinput1==nil)
            {
            
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let showDate = inputFormatter.date(from: LastMsg.LastMsgTime)
                let resultString = outputFormatter.string(from: showDate!)
                
                print(resultString)
            
               dateinput1=showDate
            }
          
            
            let dateip = dateformat1.string(from: dateinput1!)
            let dateinput = dateobj.getDate(date: dateip, FLAG: "D",t:LastMsg.LastMsgTime)
            let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:.none, timeStyle: .short)//
            print(dateinput)
            print(timestamp)
            
            
            
            
            
            
            
            
            
            
            
            
     
            
           // let uname:String=UserDefaults.standard.value(forKey: "Name") as! String
            
//var a=LastMsg.ThreadName.components(separatedBy: ",")[0]
//            var b=LastMsg.ThreadName.components(separatedBy: ",")[0]
//            if(a==uname )
//            {
//                LastMsg.ThreadName=a
//            }
//            else{
//                 LastMsg.ThreadName=b
//            }
            
            
            
           // var m=dateobj.getDate(date: LastMsg.LastMsgTime, FLAG: "D", t: LastMsg.LastMsgTime)
            
            
            
            
//            let d1 = LastMsg.LastMsgTime.components(separatedBy: "T")[0]
//            
//            
//            
//            
//            let dateinput1 = dateformat1.date(from: d1)
//            let dateip = dateformat1.string(from: dateinput1!)
//            let dateinput = dateobj.getDate(date: dateip, FLAG: "D",t:LastMsg.LastMsgTime)
            //let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:.none, timeStyle: .short)//
           // print(dateinput)
           // print(timestamp)
            
          
          UserDefaults.standard.set("2", forKey: "THREAD")
            
            
          print(dateinput)
         
            
                cell.updateCell(threadname: LastMsg.ThreadName, lastMsgtext: "\(LastMsg.LastMsgSender):\(LastMsg.Lastmsgtext)", lastMsgSenderImg: "", LastMsgTime: dateinput/*LastMsg.LastMsgTime*/)
           

            return cell
            
            
            
        }
        else{
        }
        return UITableViewCell()
           
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let LastMsg=LastMsgList[indexPath.row]
        
        
        UserDefaults.standard.setValue(LastMsg.ThreadId, forKey: "ThreadID")
        UserDefaults.standard.setValue(LastMsg.receiverId, forKey: "ParticipantList")
        UserDefaults.standard.set(LastMsg.ThreadName, forKey: "ThreadName")

     UserDefaults.standard.set(LastMsg.ChildKey, forKey: "ChildKey")
//
//        dataref.child("ThreadList").observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            
//            
//                            if let snapDict = snapshot.value as? [String:AnyObject] {
//            
//                                for child in snapDict{
//                                    var ID = child.key as! String
//                                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
//            
//            
//            
//            
//            
//            
//            
//                                    if let fname = child.value as? [String:AnyObject]{
//            
//                                        self._fname = fname["threadname"] as! String!
//                                        print(self._fname!)
//            
//            
//            
//            
//                                    }
//            
//                                    if let msg = child.value as? [String:AnyObject]{
//            
//                                        self._msg=msg["msg"] as! String!
//            
//            
//            
//            
//                                    }
//            
//            
//                                    if let time = child.value as? [String:AnyObject]{
//            
//                                        self._time = time["timestamp"] as! String!
//            
//            
//            
//            
//            
//                                    }
//                         if let thid = child.value as? [String:AnyObject]{
//            
//                                                    self._thid = thid["threadId"] as! String!
//            
//            
//            
//            
//            
//                                                }
//            
//            
//            
//            
//            
//            
//                                    if(self._thid==LastMsg.ThreadId)
//                                    {
//                                        //let thread0=LastMsgDtls(LastMsgSender: "", Lastmsgtext: self._msg, LastMsgTime: self._time, LastmsgSenderimage: "", ThreadName: self._fname,ThreadId:self.uid+","+ID,reciverId: "")
//            
//            
//                                        //self.LastMsgList.append(thread0)
//                                        
//                                        
//                                        //self.performSegue(withIdentifier: "SgueMessageCenter", sender: LastMsg)
//
//            
//                                    }
//                                    else{
//                                        
//                                        print("not create any initiation")
////                                        let passwordcheck = UIAlertController(title: "Mismatch Password", message: "Password does not match", preferredStyle: .alert)
////                                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
////                                        
////                                        
////                                        
////                                        passwordcheck.addAction(cancelAction)
////                                        
////                                        
////                                        self.present(passwordcheck, animated: true, completion: {  })                                                                }
//                                    
//                                    
//                                }
//                               
//                                
//                                
//                                
//                            }
//            }
//                        }) { (error) in
//                            print(error.localizedDescription)
//                        }
//        
//            
//        
//        
//        
        
        
        
        
        
        
     performSegue(withIdentifier: "SgueMessageCenter", sender: LastMsg)
        
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
        //self.spinner.backgroundColor=UIColor.white
        self.spinner.stopAnimating()
        self.loadingView.removeFromSuperview()
               DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }

}


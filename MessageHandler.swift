//
//  MessageHandler.swift
//  firebasechat
//
//  Created by Rz on 28/04/17.
//  Copyright © 2017 Realizer. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase


protocol MessageReceivedDelegate:class {
    func messgaeReceived(senderID:String,senderName:String,text:String,date:Date)
  func threadUpdate(senderID:String,senderName:String,text:String,date:Date)
    
    func mediaReceived(senderID:String,senderName:String,url:String)
}

class MessageHandler{
    private static let _instance=MessageHandler()
    private init(){}
     var LastMsgList=[LastMsgDtls]()
    //let SID:String=UserDefaults.standard.value(forKey: "KEY") as! String
    weak var delegate:MessageReceivedDelegate?
    static var instance:MessageHandler{
        return _instance
    }
    
     let dataref=FIRDatabase.database().reference()
    func sendMessgae(senderID:String,senderName:String,text:String,threadid:String,time:String,url:String){
    
    
       
        
        let msg:[String:AnyObject]=["senderId":senderID as AnyObject ,"senderName":senderName as AnyObject ,"msg":text as AnyObject ,"threadId":threadid as AnyObject,"timestamp":time as AnyObject,"thumbnail":url as AnyObject]
    
        dataref.child("Messages").childByAutoId().setValue(msg)
        
        
        
        

    
    
    
    }
    
    
    func observerThreadlist()
    {
//        dataref.child("ThreadList").observe(FIRDataEventType.childAdded) {(snapshot:FIRDataSnapshot) in
//            
//            
//            if let data=snapshot.value as? NSDictionary{
//                if let thid=data["threadId"] as? String{
//                   
//                                                   //                    if(senderID==UserDefaults.standard.value(forKey: "KEY") as! String || ){
//                            if let sendername=data["senderName"] as? String{
//                                if let text=data["msg"] as? String {
//                                    
//                                    
//                                    if let time=data["timestamp"] as? AnyObject{
//                                        
//                                        
//                                        print(time)
//                                        
//                                        let dateformatter = DateFormatter()
//                                        dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
//                                        //let d:String=dateformatter.string(from: time)
//                                        var d1:Date!
//                                        if(time == nil ){
//                                            d1=(NSDate() as? Date)!
//                                        }
//                                        else
//                                        {
//                                            
//                                            if(time is String==true){
//                                                if(time.contains("M")){
//                                                    d1=(NSDate() as? Date)!
//                                                }
//                                                else{
//                                                    d1=(NSDate() as? Date)!
////                                                    d1=dateformatter.date(from: NSDate() as? Date)!
//                                                }
//                                                
//                                            }
//                                            else{
//                                                d1=(NSDate() as? Date)!
//                                            }
//                                            
//                                        }
//                                        print(d1)
//                                        self.delegate?.messgaeReceived(senderID: "",senderName: sendername, text: text,date:d1)
//                                        self.delegate?.threadUpdate(senderID: "", senderName: sendername, text: text, date: d1)
//                                    }
//                                    else{
//                                        self.delegate?.messgaeReceived(senderID: "",senderName: sendername, text: text,date:(NSDate() as? Date)!)
//                                        
//                                        self.delegate?.threadUpdate(senderID: "", senderName: sendername, text: text, date: (NSDate() as? Date)!)
//                                    }
//                                }
//                                
//                            }
//                            
//                        
//                        
//                        
//                    
//                    //}
//                    
//                }
//            }}
//        
        
        
        
        var p:String=UserDefaults.standard.value(forKey: "PAGE") as! String
        print(p)
        
        
        var t:String!
        if(UserDefaults.standard.value(forKey: "THREAD") as? String
            == nil){
            print("nil data on messags")
        }
        else{
           t=UserDefaults.standard.value(forKey: "THREAD") as! String
            print(t)
        }
        //UserDefaults.standard.set("2", forKey: "THREAD")
        
        dataref.child("ThreadList").observe(FIRDataEventType.childChanged) {(snapshot:FIRDataSnapshot) in
            
            
            if let data=snapshot.value as? NSDictionary{
                if let thid=data["threadId"] as? String{
                    
                    //                    if(senderID==UserDefaults.standard.value(forKey: "KEY") as! String || ){
                    if let sendername=data["senderName"] as? String{
                        if let text=data["msg"] as? String {
                            
                            
                            if let time=data["timestamp"] as? AnyObject{
                                
                                
                                print(time)
                                
                                let dateformatter = DateFormatter()
                                dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                                //let d:String=dateformatter.string(from: time)
                                var d1:Date!
                                if(time == nil ){
                                    d1=(NSDate() as? Date)!
                                }
                                else
                                {
                                    
                                    if(time is String==true){
                                        if(time.contains("M")){
                                            d1=(NSDate() as? Date)!
                                        }
                                        else{
                                            // d1=dateformatter.date(from: String(describing: time))!
                                            d1=(NSDate() as? Date)!
                                        }
                                        
                                    }
                                    else{
                                        d1=(NSDate() as? Date)!
                                    }
                                    
                                }
                                //use
                                
//                                if(p=="MS")
//                                {
                             self.delegate?.messgaeReceived(senderID: "",senderName: "ABC", text: text,date:d1)
                               self.delegate?.threadUpdate(senderID: "", senderName:sendername, text: text, date: d1)
//                              }
//                                else {
//                                    print("work of sMessagecenter")
//                                }
                            }
                            else{
                                self.delegate?.messgaeReceived(senderID: "",senderName: sendername, text: text,date:(NSDate() as? Date)!)
                                
                                self.delegate?.threadUpdate(senderID: "", senderName: sendername, text: text, date: (NSDate() as? Date)!)
                            }
                        }
                        
                    }
                    
                    
                    
                    
                    
                    //}
                    
                    
                }}
        }

    }
    
    
    func sendMediaMessage(senderID:String,senderName:String,url:String,thid:String)
    {
        let data:[String:AnyObject]=["senderID":senderID as AnyObject,"SenderName":senderName as AnyObject,"Url":url as AnyObject,"ThreadId":thid as AnyObject]
        dataref.child("MediaMessage").childByAutoId().setValue(data)
    }
    func sendMedia(image:Data?,video:URL?,senderID:String,senderName:String,thid:String)
    {
        if(image != nil){
            
            
            
            //let msg:[String:AnyObject]=["senderId":senderID as AnyObject ,"senderName":senderName as AnyObject ,"msg":text as AnyObject ,"threadId":threadid as AnyObject,"timestamp":time as AnyObject  ]
            
           // dataref.child("Messages").childByAutoId().setValue(msg)

            
            
            
            let image1=NSUUID().uuidString
            let st=FIRStorage.storage().reference().child("MediaImage").child(senderID+"\(image).png").put(image!, metadata: nil){
                (metadata:FIRStorageMetadata?,err:Error?)
                in
                
                if err != nil{
                    //problem to uplod
                }
                else{
                    
                     if let img=metadata?.downloadURL()?.absoluteString{
                    self.sendMediaMessage(senderID: senderID, senderName: senderName, url:img,thid:thid)
                    }
                }
                
                
            }

            
        }else{
                 let vd1=NSUUID().uuidString
            let st1=FIRStorage.storage().reference().child("MediaVideo").child(senderID+"\(vd1)").putFile(video!, metadata: nil)
            {
                (metadata:FIRStorageMetadata?,error:Error?)
                in
                
                if error != nil{
                  //video uploading fail
                }
                else{
                     self.sendMediaMessage(senderID: senderID, senderName: senderName, url:String(describing: metadata?.downloadURL()!),thid:thid)
                
            }
            
        }
    }
    }
    
    func observemesage(receiver:String)
    {
     

        var a:String!
        var b:String!
        if(receiver=="")
        {
            a=""
            b=""
        }
        else{
             a=receiver.components(separatedBy: ",")[0]
             b=receiver.components(separatedBy: ",")[1]

        }
//        if(UserDefaults.standard.value(forKey: "PAGE") as! String=="MS"){
        dataref.child("Messages").observe(FIRDataEventType.childAdded) {(snapshot:FIRDataSnapshot) in
            
            
            if let data=snapshot.value as? NSDictionary{
                if let thid=data["threadId"] as? String{
                    if(thid==receiver || thid==b+","+a)
                    {
                if let senderID=data["senderId"] as? String{
//                    if(senderID==UserDefaults.standard.value(forKey: "KEY") as! String || ){
                        if let sendername=data["senderName"] as? String{
                            if let text=data["msg"] as? String {
                                
                                
                                if let time=data["timestamp"] as? AnyObject{
                                    
                                    
                                    print(time)
                                    
                                    let dateformatter = DateFormatter()
                                    dateformatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                                    //let d:String=dateformatter.string(from: time)
                                    var d1:Date!
                                    if(time == nil ){
                                          d1=(NSDate() as? Date)!
                                                                          }
                                        else
                                        {
                                            
                                            if(time is String==true){
                                                if(time.contains("M")){
                                                d1=(NSDate() as? Date)!
                                                }
                                                else{
                                                d1=(NSDate() as? Date)!//dateformatter.date(from: time as! String)!
                                                    }
                                            
                                            }
                                            else{
                                                d1=(NSDate() as? Date)!
                                            }

                                        }
                               self.delegate?.messgaeReceived(senderID: senderID,senderName: sendername, text: text,date:d1)
                                    //use
                                 self.delegate?.threadUpdate(senderID:senderID,senderName: sendername, text: text, date: d1)
                                    
                                    //ThreadListsVC.updatethresadlist()
                                   // updatethresadlist(text: text as AnyObject, time: date as AnyObject, sendername: senderName as AnyObject)
                                    
                                    let all2 = FIRDatabase.database().reference(withPath:"ThreadList")
                                    all2.keepSynced(true)
                                    
                                 
                                    
                                    
                                }
                                else{
                                   self.delegate?.messgaeReceived(senderID: senderID,senderName: sendername, text: text,date:(NSDate() as? Date)!)
                                    
                                   //  self.delegate?.threadUpdate(senderID:senderID,senderName: sendername, text: text, date: (NSDate() as? Date)!)
                                }
                            }
                            
                        }
                    }
                    
                   
                    
                   
               
            //}
        
        }
            }}
        }
        
        
        
        //observethreadlist
        
        
     
    
//        dataref.child("ThreadList").observe(FIRDataEventType.childChanged) {(snapshot:FIRDataSnapshot) in
//            
//            
//            if let data=snapshot.value as? NSDictionary{
//                if let thid=data["threadId"] as? String{
//                    
//                    //                    if(senderID==UserDefaults.standard.value(forKey: "KEY") as! String || ){
//                    if let sendername=data["senderName"] as? String{
//                        if let text=data["msg"] as? String {
//                            
//                            
//                            if let time=data["timestamp"] as? AnyObject{
//                                
//                                
//                                print(time)
//                                
//                                let dateformatter = DateFormatter()
//                                dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
//                                //let d:String=dateformatter.string(from: time)
//                                var d1:Date!
//                                if(time == nil ){
//                                    d1=(NSDate() as? Date)!
//                                }
//                                else
//                                {
//                                    
//                                    if(time is String==true){
//                                        if(time.contains("M")){
//                                            d1=(NSDate() as? Date)!
//                                        }
//                                        else{
//                                           // d1=dateformatter.date(from: String(describing: time))!
//                                            d1=(NSDate() as? Date)!
//                                        }
//                                        
//                                    }
//                                    else{
//                                        d1=(NSDate() as? Date)!
//                                    }
//                                    
//                                }
//                              //use
//                                
//                             
//                                self.delegate?.messgaeReceived(senderID: "",senderName: sendername, text: text,date:d1)
//                                self.delegate?.threadUpdate(senderID: "", senderName: sendername, text: text, date: d1)
//                            }
//                            else{
//                                self.delegate?.messgaeReceived(senderID: "",senderName: sendername, text: text,date:(NSDate() as? Date)!)
//                                
//                                self.delegate?.threadUpdate(senderID: "", senderName: sendername, text: text, date: (NSDate() as? Date)!)
//                            }
//                        }
//                        
//                    }
//                    
//                    
//                    
//                    
//                    
//                    //}
//                    
//               
//            }}
//        }
    
    }
    
    
    func observeMediaMessage(receiver:String)
    {
        var a:String!
        var b:String!
        if(receiver=="")
        {
            a=""
            b=""
        }
        else{
            a=receiver.components(separatedBy: ",")[0]
            b=receiver.components(separatedBy: ",")[1]
            
        }
        
        dataref.child("MediaMessage").observe(FIRDataEventType.childAdded) {(snapshot:FIRDataSnapshot) in
            
            
            if let data=snapshot.value as? NSDictionary{
                if let threadid=data["ThreadId"] as? String{
                    if(threadid==receiver || threadid==b+","+a)
                    {

                if let id=data["senderID"] as? String{
                    if let sendername=data["SenderName"] as? String{
                        if let url=data["Url"] as? String{
                            
                            
                            self.delegate?.mediaReceived(senderID: id, senderName: sendername, url: url)
                        }
                    }
                }
                }
            }
            }
            
        }
    }
    
    
    func LASTobservemesage(receiver:String)
    {
        
        
        
        var a=receiver.components(separatedBy: ",")[0]
        var b=receiver.components(separatedBy: ",")[1]
        
        dataref.child("Messages").observe(FIRDataEventType.childAdded) {(snapshot:FIRDataSnapshot) in
            
            
            if let data=snapshot.value as? NSDictionary{
                if let thid=data["threadId"] as? String{
                    if(thid==receiver || thid==b+","+a)
                    {
                        if let senderID=data["senderId"] as? String{
                            //                    if(senderID==UserDefaults.standard.value(forKey: "KEY") as! String || ){
                            if let sendername=data["senderName"] as? String{
                                if let text=data["msg"] as? String {
                                    
                                    
                                    if let time=data["time"] as? Date{
                                        //self.delegate?.messgaeReceived(senderID: senderID,senderName: "AMN", text: text,date:time)
                                        
                                        
                                        
                                        
                                       
                                 
                                    }
                                    else{
                                        //self.delegate?.messgaeReceived(senderID: senderID,senderName: "AMN", text: text,date:(NSDate() as? Date)!)
                                    }
                                }
                                
                            }
                        }
                        
                       
                        
                        
                    }
                    //}
                    
                }
            }}
        
    }
    
    
}

 //
//  SelectMessageCenterListVC.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 21/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import JSQMessagesViewController
import MobileCoreServices
import AVKit
import FirebaseAuth
 import FirebaseDatabase
 import FirebaseCore
 import SDWebImage

class SelectMessageCenterListVC: JSQMessagesViewController, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MessageReceivedDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var hidelabel: UILabel!
     var dataref: FIRDatabaseReference!
    @IBOutlet weak var textmsg: UITextField!
    @IBOutlet weak var usernamemenu: UIBarButtonItem!
    @IBOutlet weak var sendbutton: UIButton!
    var LastMsg=[Message]()
    var sendmsg=[Message]()
    var placeholderLabel : UILabel!
    var uid:String!
    var _fname:String!
    var _lname:String!
    var thid:String!
    var _thumbnail:String!
    
    let picker=UIImagePickerController()
    private var msg=[JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    var avatars = [String: JSQMessagesAvatarImage]()
//  private var   _lastthreadmsg:LastMsgDtls!
//    var  LastThreadMsg : LastMsgDtls{
//        get {
//            return _lastthreadmsg
//            
//        }
//        set
//        {
//            _lastthreadmsg = newValue
//        }
//    }

    @IBAction func sendMsgClick(_ sender: AnyObject) {
        
     
        if(textmsg.text == "")
        {
            
            let initiateNewThread = UIAlertController(title: "Message Center", message: "Please enter message", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            
            initiateNewThread.addAction(cancelAction)
            
            
            self.present(initiateNewThread, animated: true, completion: {  })
            hideActivityIndicator()
                   }
        else{
                       

      
            
            
            
            
            
            
        //downloadSendMsgDetails {}
            
            
                    
                   }
        
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return msg[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return msg.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell=super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let m=msg[indexPath.item]
        dismissKeyboard()
        if(m.senderId==uid){
            cell.cellBottomLabel.textAlignment = .right
            
       // cell.cellTopLabel.textAlignment = .right
        }
        else{
            cell.cellBottomLabel.textAlignment = .left
             // cell.cellTopLabel.textAlignment = .left
        }
        
        
//        
//        if avatarImage?.avatarImage == nil {
//            avatarImage?.avatarImage = SDImageCache.shared().imageFromDiskCache(forKey: message.senderId)
//        }
        
        
   

        return cell
    }
    
//    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = msg[indexPath.item]

        return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
         return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    
    
    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
//       return kJSQMessagesCollectionViewCellLabelHeightDefault
//    }
//    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
//            let message = msg[indexPath.item]
//        return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
//    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        print(date)
        
        
        let dateformatter = DateFormatter()
                       dateformatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                   let d:String=dateformatter.string(from: date)
        
        print(d)
        
      let thid:String=(UserDefaults.standard.value(forKey: "ThreadID") as? String)!
        
        
        
        
        dataref=FIRDatabase.database().reference()
        dataref.child("UserRegistration").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for child in snapDict{
                    let ID = child.key as! String
                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                    print(snapshot.key)
                    
                    
                    print(shotKey)
                    
                    if(ID==senderId){
                        
                        if let fname = child.value as? [String:AnyObject]{
                            
                            self._fname = fname["fname"] as! String!
                            
                            
                        }
                        if let lname = child.value as? [String:AnyObject]{
                            
                            self._lname = lname["lname"] as! String!
                            
                            
                        }
                        if let url = child.value as? [String:AnyObject]{
                            
                           self._thumbnail = url["profileimage"] as! String!
                            
                            
                        }
                        else{
                           self._thumbnail=""
                        }
                    }
                    
                }
                
                
                
                
            }
            
            
            MessageHandler.instance.sendMessgae(senderID: senderId, senderName: self._fname+" "+self._lname, text: text,threadid:thid,time:d,url:"")
            
             self.updatethresadlist(text: text as AnyObject, time: d as AnyObject, sendername: self._fname+" "+self._lname as AnyObject)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        
        
        
        
       
        
        
      
        
        finishSendingMessage(animated: true)
       

        dismissKeyboard()
        
    
       // finishSendingMessage()
    }

   override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        let message=msg[indexPath.item]
    
    
    if message.isMediaMessage{
        if let mediaitem=message.media as? JSQVideoMediaItem{
            let player=AVPlayer(url:mediaitem.fileURL)
            let playercontroller=AVPlayerViewController()
            
            playercontroller.player=player
            self.present(playercontroller, animated: true, completion: nil)
        }
    }
    }
    private func choiceMedia(type:CFString){
        picker.mediaTypes=[type as String]
    present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let thid:String=(UserDefaults.standard.value(forKey: "ThreadID") as? String)!
        if let pic=info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            let img = UIImageJPEGRepresentation(pic, 0.01)
            let img1 = JSQPhotoMediaItem(image: pic)
            MessageHandler.instance.sendMedia(image:img, video: nil, senderID: senderId, senderName: senderDisplayName,thid:thid)
            self.msg.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: img1))
        }
        else if let vidurl=info[UIImagePickerControllerMediaURL] as? URL
        
        {
            MessageHandler.instance.sendMedia(image: nil, video: vidurl, senderID: senderId, senderName: senderDisplayName,thid:thid)
            
            
            let vd=JSQVideoMediaItem(fileURL: vidurl, isReadyToPlay: true)
            msg.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: vd))
            
            
        }
        self.dismiss(animated: true, completion: nil)
        
        collectionView.reloadData()
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        
        
        let bubblef=JSQMessagesBubbleImageFactory();
          let message=msg[indexPath.item]

        
        
       // 1
        if message.senderId == uid { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
      
        
        let message=msg[indexPath.item]
        
        
        
        
        let placeHolderImage = #imageLiteral(resourceName: "user_icon")//UIImage(named: "usr")
        let avatarImage = JSQMessagesAvatarImage(avatarImage: nil, highlightedImage: nil, placeholderImage: placeHolderImage)
        
             if let messageID = message.senderId {
            
            dataref.child("Messages").child(messageID).observe(.value, with: { (snapshot) in
                
                print(snapshot)
                
                
                
//                if let profileURL = (snapshot.value as AnyObject!)!["thumbnail"] as! String! {
//                    
//                    let profileNSURL: NSURL = NSURL(string: profileURL)!
//                   
//                    
//                    
//                    let data = NSData(contentsOf:profileNSURL as URL)
////                    if data!= nil {
////                        imageURL.image = UIImage(data:data!)
////                    }
//                    // download avatar image here somehow!?
//            let manager = SDWebImageDownloader.shared().downloadImage(with: profileNSURL as URL!, options: [], progress: nil, completed: { (image,data,error,finished) in
//                        avatarImage!.avatarImage = image
//
//                })
//                }
//                else{
//              print("no avtar images")
//                }
            
            
            
            })
        }
        
                
                
                
                
                
        
        
        
        
        
        
        
        
        
        
        
                
                
                
                
               
                    
//                    manager.downloadImage(with: profileNSURL as URL!, options: [], progress: { (receivedSize: Int, actualSize: Int) in
//                        print(receivedSize, actualSize)
//                    }, completed: { (image, error, cached, finished, url) in
//                        avatarImage!.avatarImage = image
//                    })
//                }
//            })
       
        
        
        
        
        
        let v=message.senderDisplayName
        
        let stArr = v?.components(separatedBy: " ")
        var st=""
        for s in stArr!{
            if let      str=s.characters.first{
                st+=String(str).capitalized
            }
        }
        
//        if(=="")
//        {
//            
//            
            let img = ImageToText()
            let tempimg = img.textToImage(drawText: st as NSString, inImage:#imageLiteral(resourceName: "blue1") , atPoint: CGPoint(x: 20.0, y: 20.0))
//            self.avatarImage!.layer.borderColor = UIColor.gray.cgColor
//            self.avatarImage!.layer.cornerRadius = 25.7
//            self.avatarImage!.layer.masksToBounds = true
       
           avatarImage!.avatarImage  = tempimg
//
//        }
//        else{
//            
//            let imagedownload = DownloadImage()
//            
//            let profileimage = imagedownload.userImage(imageurlString: msgSenderimage)
//            if(profileimage != nil)
//            {
//                self.imgteacher.layer.borderColor = UIColor.gray.cgColor
//                self.imgteacher.layer.cornerRadius = 25.7
//                self.imgteacher.layer.masksToBounds = true
//                imgteacher.image = profileimage
//            }
//            else
//            {
//                let img = ImageToText()
//                let tempimg = img.textToImage(drawText: st as NSString, inImage: #imageLiteral(resourceName: "blue1"), atPoint: CGPoint(x: 20.0, y: 20.0))
//                self.imgteacher.layer.borderColor = UIColor.gray.cgColor
//                self.imgteacher.layer.cornerRadius = 25.7
//                self.imgteacher.layer.masksToBounds = true
//                imgteacher.image = tempimg
//                
//            }
//            
//            
//        }
        
        dataref.child("Messages").queryOrdered(byChild: "senderId").queryEqual(toValue: message.senderId).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists()
            {
                print(snapshot)
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for child in snapDict{
                        if let thumbnail = child.value as? [String:AnyObject]{
                            
                            self._thumbnail = thumbnail["thumbnail"] as! String!
                            
                            
                        }
                        else{
                            self._thumbnail=""
                        }
                        
                        
                        print(child.key)
                        
                        
                    }
                }
                
                
                
                
                
                
            }
            
        })
        
        
        //return avatarImage
       
       return JSQMessagesAvatarImageFactory.avatarImage(with:tempimg, diameter:30)
    }
    
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let alert=UIAlertController(title: "media message", message: "plz select media", preferredStyle: .actionSheet)
        let c=UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let p=UIAlertAction(title: "photos", style: .default, handler: {(alert:UIAlertAction)  in
            
             self.choiceMedia(type: kUTTypeImage)
            
            
        })
        let v=UIAlertAction(title: "videos", style: .default, handler: {(alert:UIAlertAction)  in
            
            
            self.choiceMedia(type: kUTTypeMovie)
            
        })
        
alert.addAction(p)
        alert.addAction(c)
       alert.addAction(v)
        
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectMessageCenterListVC.dismissKeyboard))
        
         UserDefaults.standard.set("MS", forKey: "PAGE")
        view.addGestureRecognizer(tap)
        
picker.delegate=self
        MessageHandler.instance.delegate=self
        
           uid=UserDefaults.standard.value(forKey: "KEY") as! String
        thid=UserDefaults.standard.value(forKey: "ThreadID") as! String

        MessageCenter.isHidden=true
        
      NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)),name:NSNotification.Name(rawValue: "loadMessage"), object: nil)
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        if Reachability.isConnectedToNetwork() == true{
            
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            
            let uialert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler:nil)
            
            
            uialert.addAction(okAction)
            
            present(uialert, animated: true, completion: {  })
            
           // hideActivityIndicator()
            
            
                    }

        
        self.senderId=uid
        
        
        hidelabel.isHidden=true
        
        //FIRAuth.auth()?.currentUser?.uid//uid
        self.senderDisplayName="swapnali"
        
        
        MessageHandler.instance.observemesage(receiver:thid)
        //collectionView.reloadData()
       MessageHandler.instance.observeMediaMessage(receiver:thid)
      
        
    MessageCenter.scrollToLastRow(animated: true)
    self.textmsg.delegate = self
   
        textmsg.layer.borderColor=UIColor.black.cgColor
        textmsg.layer.borderWidth=1
        textmsg.layer.cornerRadius=5
        
        let thname:String=UserDefaults.standard.value(forKey: "ThreadName") as! String
       
        usernamemenu.title=thname
        
     
     
        
       loadingView.removeFromSuperview()
        loadingView.isHidden=true
       spinner.stopAnimating()
       spinner.hidesWhenStopped = true
        spinner.backgroundColor=UIColor.white
        //hideActivityIndicator()
        
        
         if (LastMsg.count==0){
            
          
        hidelabel.isHidden=false
            
        }
         else{
            hidelabel.isHidden=true
        }
        
    }
    
    
    func loadList(notification: NSNotification){
     
        self.showActivityIndicator()
        let t:String=UserDefaults.standard.value(forKey: "ThreadID") as! String
        let newthid=UserDefaults.standard.value(forKey: "THID") as! String
        let lstmsgSender=UserDefaults.standard.value(forKey: "SendBy") as! String
        let lstMsgTime=UserDefaults.standard.value(forKey: "Time") as! String
        let lstMsgText:String=UserDefaults.standard.value(forKey: "MSG") as! String
        let lstSenderImage:String=UserDefaults.standard.value(forKey: "SenderPic") as! String
        
        
        if(t==newthid){
            
            let msgget=Message(MsgSender: lstmsgSender, msgtext:lstMsgText, MsgTime:lstMsgTime, msgSenderimage: lstSenderImage)
            
            
            
            
            self.LastMsg.append(msgget)
                    if(LastMsg.count>0)
                    {
                    MessageCenter.dataSource=self
                    MessageCenter.delegate=self
                    MessageCenter.reloadData()
                    }
                    //self.hideActivityIndicator()
                    MessageCenter.scrollToLastRow(animated: true)
                   
                }
                else{
                    print("not done")
                  }
       // self.hideActivityIndicator()
        loadingView.isHidden=true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.senderId=uid
        
        UserDefaults.standard.set("MS", forKey: "PAGE")
        
        
        //FIRAuth.auth()?.currentUser?.uid//uid
        self.senderDisplayName="swapnali"//FIRAuth.auth()?.currentUser?.displayName

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectMessageCenterListVC.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)

    // MessageHandler.instance.observemesage(receiver:thid)
 //collectionView.reloadData()
        
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
               view.endEditing(true)

      // textmsg.resignFirstResponder()
        
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "SomeTitle");
        //  let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(getter: NSInvocation.selector));
        //navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
        
        
        
        
        //        navigationController?.navigationBar.barTintColor=UIColor(red: 2/255, green: 174/255, blue: 239/255, alpha: 1)
        //
        //
        //
        //        self.navigationController?.navigationBar.tintColor=UIColor.white
        
        
        
        self.view.addSubview(navBar);
        
        
        
        
        
        
        
        //////////
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        
        
        
        
        
   
        
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
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

   
    
    //Delegation func
    
    
    func messgaeReceived(senderID: String, senderName: String, text: String,date:Date) {
 
        
        
        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
//        
//        
//        
//        let d:String=dateformatter.string(from: date)
        
       
        
        

        
        //use
      //
        
          UserDefaults.standard.set("MS", forKey: "PAGE")      
        if(senderName == "ABC" ){
        thupdate(senderID: senderID, senderName: senderName, text: text, date:date)
        }
        else{
            msg.append(JSQMessage(senderId: senderID, senderDisplayName: senderName, date: date, text: text)
            )
            
            
            thupdate(senderID: senderID, senderName: senderName, text: text, date:date)
        }
        
        
      // updatethresadlist(text: text as AnyObject, time: date as AnyObject, sendername: name as AnyObject)
        
        
                   collectionView.reloadData()
    
        let item = self.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndex = IndexPath(item: item, section: 0)//IndexPath(forItem: item, inSection: 0)
        collectionView.scrollToItem(at: lastItemIndex, at: UICollectionViewScrollPosition.bottom, animated: true)
    }
    func threadUpdate(senderID: String, senderName: String, text: String, date: Date) {
      // thupdate(senderID: senderID, senderName: senderName, text: text, date: date)
    }
    
    
    func thupdate(senderID:String, senderName: String, text: String,date:Date)
    {
        dataref=FIRDatabase.database().reference()
        dataref.child("UserRegistration").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for child in snapDict{
                    let ID = child.key as! String
                    let shotKey = snapshot.children.nextObject() as! FIRDataSnapshot
                    print(snapshot.key)
                    
                    
                    print(shotKey)
                    
                    if(ID==senderID){
                        
                        if let fname = child.value as? [String:AnyObject]{
                            
                            self._fname = fname["fname"] as! String!
                            
                            
                        }
                        if let lname = child.value as? [String:AnyObject]{
                            
                            self._lname = lname["lname"] as! String!
                            
                            
                        }
                        
                        
                        
                        self.updatethresadlist(text: text as AnyObject, time: date as AnyObject, sendername: self._fname+" "+self._lname as AnyObject)
                    }
                    
                }
                
                
                
                
            }
            
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    func mediaReceived(senderID: String, senderName: String, url: String) {
        if let mediaurl=URL(string: url)
        
        {
        do{
            
            let data=try Data(contentsOf: mediaurl)
            
            if let i=UIImage(data: data){
                let _=SDWebImageDownloader.shared().downloadImage(with: mediaurl, options: [], progress: nil, completed: {(image,data,error,finished) in
                
                   DispatchQueue.main.async {
                        let photo=JSQPhotoMediaItem(image:i)
                        
                        if (self.senderId) != nil{
                            photo?.appliesMediaViewMaskAsOutgoing=true
                            
                        }else{
                            photo?.appliesMediaViewMaskAsOutgoing=false
                        }
                        
                        
                        self.msg.append(JSQMessage(senderId: senderID, displayName: senderName, media: photo))
             
                        self.collectionView.reloadData()
                    }
                
                })
            }
            else{
                let video=JSQVideoMediaItem(fileURL: mediaurl, isReadyToPlay: true)
                if (self.senderId) != nil{
                    video?.appliesMediaViewMaskAsOutgoing=true
                }
                else{
                    video?.appliesMediaViewMaskAsOutgoing=false
                }
                
                self.msg.append(JSQMessage(senderId: senderID, displayName: senderName, media: video))
                
                self.collectionView.reloadData()
            }
            
        }catch{
            
        }
        }
 
    }
    func threadlistinsertion(senderID: String, senderName: String, text: String,date:Date)
    {
        
        
let dataref=FIRDatabase.database().reference()
        //var thid:String=(UserDefaults.standard.value(forKey: "ThreadID") as? String)!
        let msg:[String:AnyObject]=["senderId":senderID as AnyObject ,"senderName":senderName as AnyObject ,"msg":text as AnyObject ,"threadId":"" as AnyObject,"timestamp":time as AnyObject ,"threadname":"" as AnyObject ]
        
        dataref.child("ThreadListNew").childByAutoId().setValue(msg)

    }
    
    
    func updatethresadlist(text:AnyObject,time:AnyObject,sendername:AnyObject)
    {
        let dataref=FIRDatabase.database().reference()
        
        let key:String=(UserDefaults.standard.value(forKey: "ChildKey") as? String)!
        print(key)
        let userReference = dataref.child("ThreadList").child(key)
       // var t1:String!
        
        
        
        
        print(time)
//        
//        if(time.contains(" "))
//        {
//            t1=time.components(separatedBy: " ")[1]
//        }
//        
//        print(t1)
        
        
         //var thid:String=UserDefaults.value(forKey: "ThreadID") as! String//.standard.setValue(LastMsg.ThreadId, forKey: "ThreadID")
        
        
        
       
        
        
let s = String(describing: time)
        let dateformatter = DateFormatter()
               dateformatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        print(dateformatter.date(from: s))
        
        
        
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
        
        
        
        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let d:Date=dateformatter.date(from: s)!
//        
//        print(d)
//        
//        let dateformatter1 = DateFormatter()
//        dateformatter1.dateFormat = "dd/MM/yyyy HH:mm:ss"
//        
//        
//        let d1:String=dateformatter1.string(from: d)
//        print(d1)
        
    // dataref.child("ThreadList").child(key).child("timestamp").setValue(s)
        
       
        
    }
    
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {

              // navigationController?.hidesBarsWhenKeyboardAppears = false
       
    }

       @IBOutlet weak var MessageCenter: UITableView!
    
    @IBOutlet weak var backbtn: UIBarButtonItem!
    @IBOutlet weak var lblmsgtime: UILabel!
    @IBOutlet weak var lblmsg: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var imgsender: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    @IBOutlet weak var sendbtn: UIButton!
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LastMsg.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCenterCell",for:indexPath) as? MessageCenterCell
        {
       
            let LastMsgtest=LastMsg[indexPath.row]
            let dateformat1 = DateFormatter()
            dateformat1.dateFormat = "yyyy-MM-dd"
            let dateobj = datefile()
    
            
            let d1=LastMsgtest.MsgTime.components(separatedBy: "T")[0]
            
           
            let dateinput1=dateformat1.date(from: d1)
            print(d1)
            
            print(dateinput1)
            
            var dateinput:String!
            var dtinput:String!
            if(dateinput1 != nil)
            {
                dateinput=dateformat1.string(from: dateinput1!)
                print(dateinput)
                
                
                
                dtinput=dateobj.getDate(date: dateinput, FLAG: "D",t:LastMsgtest.MsgTime)
                
            }
            else{
                
                dtinput=dateobj.getDate(date: LastMsgtest.MsgTime, FLAG: "D",t:LastMsgtest.MsgTime)
                
                print(dtinput)
               }
           
            cell.updateCell(MsgSender: LastMsgtest.MsgSender, msgtext: LastMsgtest.msgtext, MsgTime: dtinput, msgSenderimage: LastMsgtest.msgSenderimage)
            
            
  
            
          
            

            return cell
            
        }
        self.spinner.backgroundColor=UIColor.white
        return UITableViewCell()
        
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
    
    @IBAction func backbtnpresed(_ sender: AnyObject) {
    
      
        self.dismiss(animated: true) {}
        
        
        
        
        

       
    }
    
    
    
    
    func hideActivityIndicator() {
        self.spinner.backgroundColor=UIColor.white
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    

}
 
 extension UICollectionView{
   
 }
extension UITableView {
    func setOffsetToBottom(animated: Bool) {
        self.setContentOffset(CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height), animated: true)
    }
    

    func scrollToLastRow(animated: Bool) {
        
      
   
        if self.numberOfRows(inSection: 0) > 0 {
            self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: 0) - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
                    }
        
        
        
        
        
       
}
    func scrollToMiddle(animated: Bool) {
        
        
        
        if self.numberOfRows(inSection: 0) > 0 {
            self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: 0) - 1, section: 0), at: UITableViewScrollPosition.top, animated: true)
        }
        
    }

}

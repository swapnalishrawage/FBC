//
//  AppDelegate.swift
//  MakeMePopular
//
//  Created by sachin shinde on 10/01/17.
//  Copyright © 2017 Realizer. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging

import FirebaseCore
import FirebaseInstanceID
import FirebaseAnalytics

import FirebaseDatabase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        let gcmMessageIDKey = "gcm.message_id"
    
       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
                 let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
       // IQKeyboardManager.sharedManager().enable = true
        //IQKeyboardManager.sharedManager().enableAutoToolbar=false
       
//        UINavigationController.init().hidesBarsOnTap=false
//        UINavigationController.init().hidesBarsOnSwipe=false
//        UINavigationController.init().hidesBarsWhenKeyboardAppears=false
//        
    
        let isUserLoggedIn:Bool = UserDefaults.standard.bool(forKey: "ISLOGGEDIN")
    let vc:SWRevealViewController=SWRevealViewController()
        print(isUserLoggedIn)
        if(isUserLoggedIn) {
            
            
            
            let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let des=mainstorybord.instantiateViewController(withIdentifier: "ThreadListsVC") as! ThreadListsVC
            let frontview=UINavigationController.init(rootViewController:des)
            vc.pushFrontViewController(frontview, animated: true)
            

             

        }
        else {
            let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
            let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let frontview=UINavigationController.init(rootViewController:loginViewController)
            vc.pushFrontViewController(frontview, animated: true)

           // window!.rootViewController?.navigationController?.navigationBar.isTranslucent=true
            //window!.rootViewController?.navigationController?.navigationBar.isHidden=false
            //window!.rootViewController = loginViewController
            //window!.makeKeyAndVisible()
            
            
        }

        
        if #available(iOS 8.0, *){
            let settings:UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        else{
            let types:UIRemoteNotificationType = [.alert, .badge, .sound]
            application.registerForRemoteNotifications(matching: types)
        }
        
        FIRApp.configure()
        
        FIRDatabase.database().persistenceEnabled = true
        let all = FIRDatabase.database().reference(withPath:"UserRegistration")
        all.keepSynced(true)
        
        
        let all1 = FIRDatabase.database().reference(withPath:"Messages")
        all1.keepSynced(true)
        
        
        let all2 = FIRDatabase.database().reference(withPath:"ThreadList")
        all2.keepSynced(true)
        
        return true
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print("\(userInfo)")
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
              if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
          
        }

        

       
   
        print(userInfo)
        
        var message:String!
        var sendby:String!
        var thid:String!
        var time:String!
        var participateid:String!
        var image:String!
        var msgid:Any!
        if let messageID1 = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID1)")
            msgid = messageID1
            print(msgid)
        }
        if let img=userInfo["senderThumbanilUrl"] as? String{
         image=img
            UserDefaults.standard.set(image, forKey: "SenderPic")
        }

        if let threadid=userInfo["threadId"] as? String{
            thid=threadid
            UserDefaults.standard.set(thid, forKey: "THID")
        }
        if let partiid=userInfo["participantId"] as? String{
            participateid=partiid
            UserDefaults.standard.set(participateid, forKey: "ParticipateID")

        }
       
        if let timestam=userInfo["timeStamp"] as? String{
            time=timestam
            UserDefaults.standard.set(time, forKey: "Time")

        }
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let alertMessage = alert["body"] as? String {
                    message = alertMessage
                     UserDefaults.standard.set(message, forKey: "MSG")
                }
                if let title = alert["title"] as? String {
                    sendby = title
                    UserDefaults.standard.set(sendby, forKey: "SendBy")
                    
                }
                
            }
        }
        print(message)
        print(sendby)
 
        let alert0 : AnyObject?=userInfo["aps"] as AnyObject?
        print(alert0!)
        let a:AnyObject=alert0 as AnyObject
        print(a)
         
         
         
         
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadThread"), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMessage"), object: nil)
        
              
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        FIRMessaging.messaging().disconnect()
        print("did enter background")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        connectToFcm()
    }
    func applicationWillTerminate(_ application: UIApplication) {
       
    }

 
    func connectToFcm(){
        
        FIRMessaging.messaging().connect{ (error) in
            if(error != nil){
                print("Unable to connect\(error)")
            }
            else{
                print("Connected to FCM")
            }
            
        }
    }
    
    
}


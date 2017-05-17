//
//  Constants.swift
//  ChatDemo
//
//  Created by sachin shinde on 05/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import Foundation
import CoreData


let BASE_URL = "http://45.35.4.250/chat/api/Chat/"
let URL_Security="http://45.35.4.250/chat/api/"
let Username = "s-farhan/"
let Password = "test/"
let Device_Id = "6534786383"
let SenderID=UserDefaults.standard.value(forKey: "KEY") as! String
let SenderName="swapnali"
 let  MEDIA_MESSAGE="Media_messages"
let IMAGE_STORAGE="image_storage"
let VIDEO_STORAGE="video_storage"

typealias DownloadComplete = () -> ()

let Current_Url = "\(BASE_URL)\(Username)\(Password)\(Device_Id)"
/*func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}*/
class constants{
    static let SENDERID="sender_id"
    static let SENDERNAME="sender_name"
    static let URL=""
    static let TEXT="text"
    
    
    let  MEDIA_MESSAGE="Media_messages"
    let IMAGE_STORAGE="image_storage"
    let VIDEO_STORAGE="video_storage"

}

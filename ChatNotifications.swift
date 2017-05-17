//
//  ChatNotification.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 05/01/17.
//  Copyright © 2017 Realizer. All rights reserved.
//

import Foundation

class ChatNotification{
    
    func setChat(userInfo: [AnyHashable: Any]) -> LastMsgDtls {
        var from:String = ""
       // var to:String = ""
        var sendername:String = ""
        //var senderurl:String = ""
        var senttime:String = ""
        var msgtext:String = ""
        
        if let fromid = userInfo["From"] as? String {
            
            from = fromid
        }
       /* if let toid = userInfo["To"] as? String {
            
            to = toid
        }*/
        if let sender = userInfo["SenderName"] as? String {
            
            sendername = sender
        }
        /*if let pic = userInfo["Subject"] as? String {
         
         senderurl = pic
         }*/
        if let stime = userInfo["SendTime"] as? String {
            
            senttime = stime
        }
        if let msg = userInfo["MsgText"] as? String {
            
            msgtext = msg
        }
        
        
       // let msgObj = ConversationModel()
        
       // msgObj.setMessage(chatId: "", fromteacher: true, schoolCode: "", fromId: from, toId: to, message: msgtext, msgTime: senttime, profilePic: "", senderN: sendername)
        
       // let chatMethods = ChatMethods()
        //let chatinitmethods = ChatInitiateMethods()
        
        let chatobj = LastMsgDtls(LastMsgSender: sendername, Lastmsgtext: msgtext, LastMsgTime: senttime, LastmsgSenderimage: "", ThreadName: sendername, ThreadId: from, reciverId: from,childkey:"")
        
                //chatMethods.storeMessage(chatObj: msgObj)
        
        
        return chatobj
    }
}

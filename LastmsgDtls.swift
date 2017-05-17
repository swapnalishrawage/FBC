//
//  LastMsgDtls.swift
//  School-GenieVer1.0
//
//  Created by sachin shinde on 19/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import Foundation
class LastMsgDtls
{
    private var _LastMsgTime:String!
    private var _LastMsgSender:String!
    private var _Lastmsgtext:String!
    private var _LastmsgSenderimage:String!
    private var _ThreadName:String!
    private var _UnreadCount:String!
    private var _ThreadId:String!
    private var _receiverId:String!
    private var _childKey:String!
    
    var LastMsgTime : String{
        get {
            return _LastMsgTime
            
        }
        set
        {
            _LastMsgTime = newValue
        }
    }
    var ChildKey : String{
        get {
            return _childKey
            
        }
        set
        {
            _childKey = newValue
        }
    }
    var receiverId : String{
        get {
            return _receiverId
            
        }
        set
        {
            _receiverId = newValue
        }
    }

    var ThreadId : String{
        get {
            return _ThreadId
            
        }
        set
        {
            _ThreadId = newValue
        }
    }

    var UnreadCount : String{
        get {
            return _UnreadCount
            
        }
        set
        {
            _UnreadCount = newValue
        }
    }

    var ThreadName : String{
        get {
            return _ThreadName
            
        }
        set
        {
            _ThreadName = newValue
        }
    }
    
    var LastMsgSender:String
    {
        get {
            return _LastMsgSender
            
        }
        set
        {
            _LastMsgSender = newValue
        }

        
       // return _LastMsgSender
        
    }
    var Lastmsgtext:String
    {
        get{
            return _Lastmsgtext
            
        }set{
            _Lastmsgtext=newValue
        }

        //return _Lastmsgtext
        
    }
    var LastmsgSenderimage:String
    {
        get{
            return _LastmsgSenderimage

        }set{
        _LastmsgSenderimage=newValue
        }
        
    }
    init(LastMsgSender:String,Lastmsgtext:String,LastMsgTime:String,LastmsgSenderimage:String,ThreadName:String,ThreadId:String,reciverId:String,childkey:String)
    {
        _LastMsgSender=LastMsgSender
        _Lastmsgtext=Lastmsgtext
        _LastMsgTime=LastMsgTime
        _LastmsgSenderimage=LastmsgSenderimage
        _ThreadName=ThreadName
        _ThreadId=ThreadId
        _receiverId=reciverId
        _childKey=childkey
    }
    init(LastMsgSender:String,Lastmsgtext:String,LastMsgTime:String,LastmsgSenderimage:String)
    {
        _LastMsgSender=LastMsgSender
        _Lastmsgtext=Lastmsgtext
        _LastMsgTime=LastMsgTime
        _LastmsgSenderimage=LastmsgSenderimage
    }
    
    
}

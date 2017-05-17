//
//  UserListGet.swift
//  ChatDemo
//
//  Created by sachin shinde on 06/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import Foundation
import Alamofire


class UserListGet
{
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
    init(userId:String,firstName:String,lastName:String,emailId:String,dateofBirth:Date,phoneNo:String,loginId:String,password:String,magicWord:String,deviceId1:String,registrationId1:String,deviceId2:String,registrationId2:String,deviceId3:String,registrationId3:String,createTS:String,isActive:Bool,gender:String,thumbnailUrl:String)
    {
        _userId=userId
        _firstName=firstName
        _lastName=lastName
        
        _emailId=emailId
       _dateofBirth=dateofBirth
        _phoneNo=phoneNo
        
        
        _loginId=loginId
        _password=password
        _magicWord=magicWord
        _deviceId1=deviceId1
        _registrationId1=registrationId1
        _deviceId2=deviceId2
        _registrationId2=registrationId2
        _deviceId3=deviceId3
        _registrationId3=registrationId3
        _createTS=createTS
        _isActive=isActive
     _gender=gender
        _thumbnailUrl=thumbnailUrl
    }
 /*   func downloadUserList(result:Dictionary<String,AnyObject>)
    {
        if let dict = result   as?  [Dictionary<String,AnyObject>]
            
        {
           
            for userdic in dict {
                if let userid = userdic["userId"] as? String {
                    self._userId=userid
                    print("===============")
                    print(self._userId)
                }
                if let fn=userdic["firstName"] as? String{
                    self._firstName=fn
                    let fnm:String = self.firstName
                    print("===========\(fnm)=======")
                    
                }
                if let ln=userdic["lastName"] as? String{
                    self._lastName=ln
                }
                if let email=userdic["lastName"] as? String{
                    self._emailId=email
                }
                if let loginid=userdic["loginId"] as? String{
                    self._loginId=loginid
                }
                if let magic=userdic["magicWord"] as? String{
                    self._magicWord=magic
                }
                if let thumburl=userdic["thumbnailUrl"] as? String{
                    self._thumbnailUrl=thumburl
                }
                
                
            }
            
            //UserList.downloadUserList(dict)
            //print(dict)
            
        }
}*/
}

//
//  contactList.swift
//  ChatDemo
//
//  Created by sachin shinde on 06/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import Foundation
class contactList{
    private var _userId:String!
    private var _username:String!
    private var _thumbnailurl:String!

    var userId : String{
        get {
            return _userId
            
        }
        set
        {
            _userId = newValue
        }
    }
    
    var username:String
        {
        get{
            return _username
        }
        set{
            _username=newValue
        }
       
    }
    var thumbnailurl : String{
        get {
            if(_thumbnailurl != nil)
            {
            return _thumbnailurl
            }
            else {return ""}
            
        }
        set
        {
            _thumbnailurl = newValue
        }
    }
    

    init ()
    {
      
            }

}

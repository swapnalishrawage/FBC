//
//  Register.swift
//  ChatDemo
//
//  Created by sachin shinde on 05/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import Foundation
class Register{
    private var _userId:String!
    private var _firstName:String!
    private var _lastName:String!
    private var _msgSenderimage:String!
    
    var userId : String{
        get {
            return _userId
            
        }
        set
        {
            _userId = newValue
        }
    }
    var firstName : String{
        get {
            return _firstName
            
        }
        set
        {
            _firstName = newValue
        }
    }
    var lastName : String{
        get {
            return _lastName
            
        }
        set
        {
            _lastName = newValue
        }
    }
    


}

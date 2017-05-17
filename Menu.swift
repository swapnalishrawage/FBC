//
//  Menu.swift

//
//  Created by sachin shinde on 30/11/16.
//  Copyright © 2016 Realizer. All rights reserved.
//



import Foundation
class Menu
{
    
    private var _menulabel:String!
    
    private var _menuimage:UIImage!
    
    
    
    
    var menulabel:String
    {
        return _menulabel
        
    }
    var menuimage:UIImage{
        get{
            return _menuimage
        }
        set{
            _menuimage=newValue
        }
        
    }
    
    
    init (menulabel:String,menuimage:UIImage)
    {
        
        _menulabel = menulabel
        
        _menuimage = menuimage
        
    }
    
}

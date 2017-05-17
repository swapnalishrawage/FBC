//
//  DownloadImage.swift
//  ChatDemo
//
//  Created by sachin shinde on 12/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class DownloadImage{
    
    
    func userImage(imageurlString: String) -> Image? {
        
        var userImg:Image? = nil
        
        if PhotosDataManager.sharedManager.cachedImage(urlString: imageurlString) != nil
        {
            userImg = PhotosDataManager.sharedManager.cachedImage(urlString: imageurlString)
        }
            
        else
        {
            let urlString = imageurlString
            _ = PhotosDataManager.sharedManager.getNetworkImage(urlString: urlString) {image in
                userImg = image
            }
            
        }
        return userImg
    }
    
}

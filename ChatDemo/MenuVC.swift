//
//  MenuVC.swift
//  ChatDemo
//
//  Created by sachin shinde on 10/12/16.
//  Copyright © 2016 Realizer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class  MenuVC : UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var menuview: UITableView!
    
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var profileimgview: UIImageView!
      var MenuArr=[Menu]()
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.loadView()
        //if (menuview.contentSize.height < menuview.frame.size.height) {
           menuview.isScrollEnabled = false;
       
        let m0=Menu(menulabel: "Chat", menuimage:#imageLiteral(resourceName: "ic_my_chat_notification"))

        let m1=Menu(menulabel: "Profile", menuimage:#imageLiteral(resourceName: "user-@1x"))
        
    let m2=Menu(menulabel: "Change Password", menuimage:#imageLiteral(resourceName: "changepass") )
        let m4=Menu(menulabel: "About Us", menuimage: #imageLiteral(resourceName: "info"))
        let m3 = Menu(menulabel: "Logout", menuimage: #imageLiteral(resourceName: "logout"))
        MenuArr.append(m0)
        MenuArr.append(m1)
        MenuArr.append(m2)
        MenuArr.append(m4)
        MenuArr.append(m3)
        
        let imagedownload = DownloadImage()
        let imageurl:String = ""//UserDefaults.standard.value(forKey: "UserProfilePic") as! String
        
        let v:String=" "//UserDefaults.standard.value(forKey: "Name") as! String
        let stArr = v.components(separatedBy: " ")
        var st=""
        for s in stArr{
            if let      str=s.characters.first{
                st+=String(str).capitalized
            }
        }
        
        var profileimage:UIImage!
        if(imageurl.isEmpty)
        {
            let img = ImageToText()
            profileimage = img.textToImage(drawText: st as NSString, inImage: #imageLiteral(resourceName: "greybg"), atPoint: CGPoint(x: 20.0, y: 20.0))
            
        }
        else{
            profileimage = imagedownload.userImage(imageurlString: imageurl)
            
            if(profileimage == nil)
            {
                let img = ImageToText()
                profileimage = img.textToImage(drawText: st as NSString, inImage: #imageLiteral(resourceName: "greybg"), atPoint: CGPoint(x: 20.0, y: 20.0))
                
            }
        }
               self.menuview.dataSource=self
        self.menuview.delegate=self

       
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell=tableView.dequeueReusableCell(withIdentifier: "MenuTableCell", for:indexPath) as? MenuTableCell
            
        {
            let menu=MenuArr[indexPath.row]
            
            cell.updateCell(menulabel: menu.menulabel, menuimage: menu.menuimage)
            return cell
            
        }
            
        else{
            
            return UITableViewCell()
            
        }
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let cell:MenuTableCell=tableView.cellForRow(at: indexPath) as! MenuTableCell
        if(cell.menu.text=="Chat"){
            
            let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let des=mainstorybord.instantiateViewController(withIdentifier: "ThreadListsVC") as! ThreadListsVC
            let frontview=UINavigationController.init(rootViewController:des)
            
            revealViewController().pushFrontViewController(frontview, animated:true)
        }
        
        if(cell.menu.text=="Profile"){
            
            let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let des=mainstorybord.instantiateViewController(withIdentifier: "profileVC") as! profileVC
            let frontview=UINavigationController.init(rootViewController:des)
            
            revealViewController().pushFrontViewController(frontview, animated:true)
        }
        if(cell.menu.text=="Change Password"){
            
            
            performSegue(withIdentifier: "squechangepass", sender: nil)
        }
        if(cell.menu.text=="About Us"){
            
            self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "sgueAboutus", sender: nil)
            
            
            
        }
        if(cell.menu.text=="Logout"){
            
            
            let appDomain = Bundle.main.bundleIdentifier
 
UserDefaults.standard.set("0", forKey: "Offlogout")
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            print("session end")
            
            let mainstorybord:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let des=mainstorybord.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let frontview=UINavigationController.init(rootViewController:des)
            
            revealViewController().pushFrontViewController(frontview, animated:true)
        }
        


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }

    

}

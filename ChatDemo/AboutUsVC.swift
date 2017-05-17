//
//  AboutUsVC.swift
//  ChatDemo
//
//  Created by sachin shinde on 17/01/17.
//  Copyright © 2017 Realizer. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       navigationController?.navigationBar.isHidden=false
        //self.navigationController?.navigationBar.barStyle=UIBarStyle.black
        
        
        
        
      // self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white.cgColor]
        // self.navigationController?.navigationBar.barTintColor=UIColor(red:36/255,green:73/255,blue:210/255,alpha:1.0)
        
       // self.navigationController?.navigationBar.tintColor=UIColor.white
    }

    @IBAction func closeclick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.navigationBar.isHidden=false
     //  self.navigationController?.navigationBar.barStyle=UIBarStyle.black
       // self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white.cgColor]

        // self.navigationController?.navigationBar.barTintColor=UIColor(red:36/255,green:73/255,blue:210/255,alpha:1.0)
        
        //self.navigationController?.navigationBar.tintColor=UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

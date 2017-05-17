//
//  FCMTokensMethods.swift
//  ChatDemo
//
//  Created by sachin shinde on 18/01/17.
//  Copyright © 2017 Realizer. All rights reserved.
//



import Foundation
import CoreData

/*class FCMTokenMethods{
    
    func storeToken (token:String) {
        let context = getContext()
        
        deleteToken()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "FCMTokenCoreData", in: context)
        
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(token, forKey: "tokenId")
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
        
        
    }
    
    
    func getToken() -> String {
        
        var tokenId:String = ""
        //create a fetch request, telling it about the entity
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FCMTokenCoreData")
        //let fetchRequest: NSFetchRequest<PupilInformation> = PupilInformation.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as! [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                
                if(trans.value(forKey: "tokenId") != nil){
                    tokenId = trans.value(forKey: "tokenId") as! String
                }                //print("\(trans.value(forKey: "fName"))")
            }
        } catch {
            print("Error with request: \(error)")
        }
        
        return tokenId
    }
    
    
    func deleteToken(){
        // Create Fetch Request
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FCMTokenCoreData")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try getContext().execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
    }
}*/


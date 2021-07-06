//
//  CoreDataFile.swift
//  ZetaProject
//
//  Created by Satyam Kumar on 21/06/21.
//

import UIKit
import CoreData
import Foundation
public var manageObjectContext: NSManagedObjectContext!
var appDelegate = UIApplication.shared.delegate as! AppDelegate

func openDatabse(email: String, name:String,password: String)
    
{
    manageObjectContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Register", in: manageObjectContext)
    let newUser = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
    saveData(ListData:newUser, email: email, name:name,password: password)
}

func saveData(ListData:NSManagedObject,email: String, name:String,password: String)
{
    if email != ""
    {
    ListData.setValue(email, forKey: "email")
    ListData.setValue(name, forKey: "name")
    ListData.setValue(password, forKey: "password")
     
    do {
        try manageObjectContext.save()
    } catch {
      
    }
    }
}


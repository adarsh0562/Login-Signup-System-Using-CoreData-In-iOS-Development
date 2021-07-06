//
//  RegistrationFormViewController.swift
//  ZetaProject
//
//  Created by Satyam Kumar on 21/06/21.
//

import UIKit
import CoreData
class RegistrationFormViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cpasswordField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    //MARK:// Variables
    var email = ""
    var emailArray:[String] = []
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        nameField!.text! = ""
        emailField!.text! = ""
        passwordField!.text! = ""
        cpasswordField!.text! = ""
    }
    
    
    
    //MARK: Alert
    func alert(title:String,mess:String){
        let alert = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertAction(title:String,mess:String){
        let alert = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: Validation
    func validationOnText()
    {
        if  nameField.text! == ""{
            alert(title: "Error", mess: "Name is required")
        }
        else if emailField!.text! == ""{
            alert(title: "Error", mess: "Email is required")
        }
        else if checkEmailAlreadyExist()
        {
            alert(title: "Error", mess: "Email is already Exist")
        }
        else if passwordField!.text! == ""{
            alert(title: "Error", mess: "password is required")
        }
        else if cpasswordField!.text! == ""{
            alert(title: "Error", mess: "confirm password is required")
        }else if passwordField!.text! != cpasswordField!.text!{
            alert(title: "Error", mess: "password and confirm password should be same")
       }
        else{
        saveCoreData()
       }
    }
   
    
    //MARK: Save data in CoreData
    func saveCoreData()
    {
        openDatabse(email: emailField!.text!, name: nameField!.text!, password: passwordField!.text!)
        alertAction(title: "Success", mess: "Register successfully")
       // alert(title: "Success", mess: "Register successfully")
    }
    //MARK: Check Email is Already Exist  or Not
    func checkEmailAlreadyExist() -> Bool
    {
        for name in emailArray
        {
            if name == email {
               // print("Found \(name) for index \(currentIndex)")
                return true
                //break
            }

            currentIndex += 1
           
        }
       return false
    }
    
    
}
    
  //MARK:- IBAction
extension RegistrationFormViewController
{
    @IBAction func registerButton(_ sender: Any) {
        email = emailField!.text!
        validationOnText()
    }
    
    @IBAction func loginBtn(_ sender:UIButton)
    {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - Fetch Data in Core Data Base
extension RegistrationFormViewController{
    func fetchData()
    {
       
       
        manageObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        request.returnsObjectsAsFaults = false
        do {
            let result = try manageObjectContext.fetch(request)
            for data in result as! [NSManagedObject]
            {
            if result.count > 0
            {
                
                let emails = data.value(forKey: "email") as! String
                    emailArray.append(emails)
                
                 
            }
            }
        } catch {
            print("Fetching data Failed")
        }
        
    }
}

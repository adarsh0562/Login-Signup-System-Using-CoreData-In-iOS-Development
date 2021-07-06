//
//  LoginFormViewController.swift
//  ZetaProject
//
//  Created by Satyam Kumar on 21/06/21.
//

import UIKit
import CoreData
class LoginFormViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var regitrationBtn:UIButton!
    var temp = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Login"
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        emailField!.text! = ""
        passwordField!.text! = ""
    }
    
    
    //MARK: Alert
    func alert(title:String,mess:String){
        let alert = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: Validation
    func validation()
    {
        if emailField!.text! == ""
        {
            alert(title: "Error", mess: "Email Required")
        }else if passwordField!.text! == ""
        {
            alert(title: "Error", mess: "Password Required")
        }else{
            fetchData()
        }
    }
}

//MARK:- IBAction
extension LoginFormViewController{
    
    @IBAction func loginButton(_ sender: Any) {
        temp = 0
        validation()
    }
    @IBAction func registrationBtn(_ sender:UIButton)
    {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationFormViewController") as! RegistrationFormViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
//MARK: - Fetch Data in Core Data Base
extension LoginFormViewController{
    func fetchData()
    {
        
        let email = emailField.text!
        let pass = passwordField.text
        manageObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        request.returnsObjectsAsFaults = false
        do {
            let result = try manageObjectContext.fetch(request)
            if result.count > 0
            {
            for data in result as! [NSManagedObject] {
            
                if data.value(forKey: "email") as! String == email
                {
                    temp = 1
                let   e = data.value(forKey: "email") as! String
                let p = data.value(forKey: "password") as! String
                if (email == e && pass == p)
                {
                    
                    alert(title: "Success", mess: "Suceessfully")
                }
                else if (email == e || pass == p)
                {
                    alert(title: "Error", mess: "Invalid credentials")
                }
//                else if (email != e && pass != p)
//                {
//
//                    alert(title: "Error", mess: "No data found")
//                }
                   // break
                }
            }
                if temp == 0
                {
                alert(title: "Error", mess: "No data found")
                }
            }
            else
            {
                alert(title: "Error", mess: "No user found")
                print("no user found")
            }
        } catch {
            print("Fetching data Failed")
        }
        
    }
}

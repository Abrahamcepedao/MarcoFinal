//
//  LoginViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 07/09/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        //check email
        guard let email = emailTF.text else {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Ingrese un email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //check password
        guard let password = passwordTF.text else {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Ingrese una contraseña", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //login with credentials
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                //an error ocurred
                print(error ?? "")
                let alert = UIAlertController(title: "Sucedió un error..", message: "Algo salío mal al iniciar sesión. Por favor inténtelo más tarde.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                self.present(alert, animated: true, completion: nil)
            } else{
                //user created successfuly
                print("Usuario: \(authResult?.user.uid ?? "ehh")")
                
              
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabarController") as! UITabBarController
                self.present(nextViewController, animated:true, completion:nil)
                
            }
        }
        
    }
    
}

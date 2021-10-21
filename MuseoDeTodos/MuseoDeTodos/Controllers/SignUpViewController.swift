//
//  SignUpViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 07/09/21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.toolbar.isHidden = true
    }
    
    @IBAction func createAcount(_ sender: UIButton) {
        
        
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

        //check confirm password
        guard let confirmPassword = confirmPasswordTF.text else {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Confirme la contraseña", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }

        //check passwords are the same
        if password != confirmPassword {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Las contraseñas no coinciden", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
        //check email validity
        } else if (!isValidEmail(email)) {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Ingrese un email válido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
        } else {


            //create user
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    //an error ocurred
                    print(error ?? "")
                    let alert = UIAlertController(title: "Sucedió un error..", message: "Algo salío mal al crear el usuario. Por favor inténtelo más tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                    self.present(alert, animated: true, completion: nil)
                } else{
                    //user created successfuly
                    print("Usuario registrado \(authResult?.user.uid ?? "ehh")")

                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "datosPerfilViewController") as! DatosPerfilViewController
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        }
    }
    
    // useful functions
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

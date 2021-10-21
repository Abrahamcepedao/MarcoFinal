//
//  DatosPerfilViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 08/09/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DatosPerfilViewController: UIViewController {
    
    //firebase
    var db: Firestore!
    
    //outlets
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var secondnameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var sexTF: UITextField!
    @IBOutlet weak var birthdateTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    //gender pickerView
    let gender = ["Hombre", "Mujer", "Otro"]
    let genderPickerView = UIPickerView()
    
    //datepciker
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup firebase
        setupFirebase()
        
        // setup pickers
        setupPicker()
        setupDatePicker()
    }
    
    func setupFirebase(){
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func setupPicker(){
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        sexTF.inputView = genderPickerView
        sexTF.text = gender[0]
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        toolbar.setItems([doneBtn], animated: true)
        sexTF.inputAccessoryView = toolbar
    }
    
    func setupDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        birthdateTF.inputAccessoryView = toolbar
        
        
        
        birthdateTF.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.addTarget(self, action: #selector(dateChanged), for: UIControl.Event.valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func dateChanged(sender: UIDatePicker){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        birthdateTF.text = formatter.string(from: sender.date)
        print(sender.date)
        birthdateTF.text = formatter.string(from: sender.date)
        //self.view.endEditing(true)
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        birthdateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func donePressed2(){
        self.view.endEditing(true)
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        print(firstnameTF.text ?? "")
        print(secondnameTF.text ?? "")
        print(lastnameTF.text ?? "")
        print(sexTF.text ?? "")
        print(birthdateTF.text ?? "")
        print(Auth.auth().currentUser?.uid ?? "")
        
        guard let uid = Auth.auth().currentUser?.uid else {
            let alert = UIAlertController(title: "Sucedió un error..", message: "No ha iniciado sesión", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let firstname = firstnameTF.text else  {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Ingrese su primer nombre", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let lastname = lastnameTF.text else  {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Ingrese sus apellidos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let sex = sexTF.text else  {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Seleccione su sexo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let birthdate = birthdateTF.text else  {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Seleccione su fecha de nacimiento", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        print("creating user in firestore db")
        db.collection("users").document(uid).setData([
            "firstname": firstname,
            "secondname": secondnameTF.text ?? "",
            "lastnames": lastname,
            "sex": sex,
            "birthdate": birthdate,
        ])
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabarController") as! UITabBarController
        self.present(nextViewController, animated:true, completion:nil)
    }
    

}


extension DatosPerfilViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTF.text = gender[row]
//        sexTF.resignFirstResponder()
    }

}

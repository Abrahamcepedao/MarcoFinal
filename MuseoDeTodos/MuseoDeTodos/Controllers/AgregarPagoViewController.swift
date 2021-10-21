//
//  AgregarPagoViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 20/10/21.
//

import UIKit
import RealmSwift
import FirebaseAuth

class AgregarPagoViewController: UIViewController {
    
    //textfields
    @IBOutlet weak var cardNumTF: UITextField!
    @IBOutlet weak var expirationTF: UITextField!
    @IBOutlet weak var vcvTF: UITextField!
    @IBOutlet weak var methodTF: UITextField!
    
    //image
    @IBOutlet weak var methodImg: UIImageView!
    let images = ["american-logo", "mastercard-logo", "visa-logo"]
    
    //button
    @IBOutlet weak var addBtn: UIButton!
    
    //methdo picker view
    let methods = ["American Express", "Mastercard", "Visa"]
    var methodPV = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPicker()
        setupTF()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            if let firstVC = presentingViewController as? PagosViewController {
                DispatchQueue.main.async {
                    firstVC.pagosTV.reloadData()
                }
            }
        }
    
    func setupPicker(){
        methodPV.delegate = self
        methodPV.dataSource = self
        
        //method
        methodTF.inputView = methodPV
        methodTF.text = methods[0]
        
        //toolbarr
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        methodTF.inputAccessoryView = toolbar
    }
    
    func setupTF(){
        //card Num
        cardNumTF.delegate = self
        
        //expriation
        expirationTF.delegate = self
        
        //VCV
        vcvTF.delegate = self
    }
    
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }

    @IBAction func addBtnTapped(_ sender: UIButton) {
        if(verify()){
            let username = Auth.auth().currentUser?.uid ?? ""
            var config = Realm.Configuration.defaultConfiguration
            config.fileURL!.deleteLastPathComponent()
            config.fileURL!.appendPathComponent(username)
            config.fileURL!.appendPathExtension("realm")
            let realm = try! Realm(configuration: config)
            
            do {
                try realm.write {
                    let newCard = Card()
                    
                    var index = 0
                    for i in 0..<methods.count {
                        if(methods[i] == methodTF.text){
                            index = i
                        }
                    }
                    
                    
                    newCard.number = cardNumTF.text!
                    newCard.expiration = expirationTF.text!
                    newCard.cvc = Int16(vcvTF.text!)!
                    newCard.image = images[index]
                    
                    realm.add(newCard)
                    
                    //alert tarjeta agregada con exito
                    let alert = UIAlertController(title: "Tarjeta", message: "Método de pago agregado exitosamente", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                print("error")
            }
        }
        
    }
    
    func verify() -> Bool{
        return true
    }
    
    //expiration validation
    func expDateValidation(dateStr:String) {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
            } else {
                print("Entered Date Is Wrong")
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   print("Entered Date Is Right")
                } else {
                   print("Entered Date Is Wrong")
                }
            } else {
                print("Entered Date Is Wrong")
            }
        } else {
           print("Entered Date Is Wrong")
        }

    }
    

}


extension AgregarPagoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == expirationTF {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }
            let updatedText = oldText.replacingCharacters(in: r, with: string)

            if string == "" {
                if updatedText.count == 2 {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
            } else if updatedText.count == 1 {
                if updatedText > "1" {
                    return false
                }
            } else if updatedText.count == 2 {
                if updatedText <= "12" { //Prevent user to not enter month more than 12
                    textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
                }
                return false
            } else if updatedText.count == 5 {
                self.expDateValidation(dateStr: updatedText)
            } else if updatedText.count > 5 {
                return false
            }
        } else if textField == vcvTF {
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 4
        } else if textField == cardNumTF {
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 16
        }
        

        return true
    }
}


extension AgregarPagoViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        methods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        methods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        methodImg.image = UIImage(named: images[row])
        
        methodTF.text = methods[row]
    }
}

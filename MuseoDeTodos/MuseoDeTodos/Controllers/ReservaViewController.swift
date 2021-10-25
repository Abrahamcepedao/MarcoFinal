//
//  ReservaViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 28/09/21.
//

import UIKit
import FirebaseAuth
import RealmSwift

class ReservaViewController: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!//  type of reservation
    
    //variables reserva
    var name: String?
    var image: String?
    var costoA: Int?
    var costoN: Int?
    var costoE: Int?
    
    //total
    var total: Int = 0
    @IBOutlet weak var totalLbl: UILabel!
    
    //variables
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var hourTF: UITextField!
    
    //adults
    @IBOutlet weak var adultsNum: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    
    //kids
    @IBOutlet weak var kidsNum: UILabel!
    @IBOutlet weak var kidsStepper: UIStepper!
    
    //especial (students, elderly)
    @IBOutlet weak var specialsNum: UILabel!
    @IBOutlet weak var specialsStepper: UIStepper!
    
    
    //button
    @IBOutlet weak var reserveBtn: UIButton!
    
    //date
    let datePicker = UIDatePicker()
    
    //hour
    let hourPicker = UIDatePicker()
    
    var totalPersons: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let title = name { titleLbl.text = "Reserva: \(title)" }
        setupStyles()
        setUpViews()
        setupDatePicker()
        setupHourPicker()
    }
    
    func setupStyles(){
        dateTF.layer.cornerRadius = 15
        hourTF.layer.cornerRadius = 15
        reserveBtn.layer.cornerRadius = 15
        
        dateTF.clipsToBounds = true
        dateTF.layer.borderWidth = 2
        dateTF.layer.borderColor = #colorLiteral(red: 0.8954718709, green: 0.1038885489, blue: 0.6602074504, alpha: 1)
        
        hourTF.clipsToBounds = true
        hourTF.layer.borderWidth = 2
        hourTF.layer.borderColor = #colorLiteral(red: 0.8954718709, green: 0.1038885489, blue: 0.6602074504, alpha: 1)
    }
    
    func setUpViews(){
        totalLbl.text = "$ \(total).0"
    }
    
    //<--------date functions--------->
    func setupDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        toolbar.setItems([doneBtn], animated: true)
        dateTF.inputAccessoryView = toolbar
        
        
        
        dateTF.inputView = datePicker
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
        
        dateTF.text = formatter.string(from: sender.date)
        print(sender.date)
        dateTF.text = formatter.string(from: sender.date)
        //self.view.endEditing(true)
    }
    
    @objc func dateDonePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //<--------hour functions--------->
    func setupHourPicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateHourPressed))
        toolbar.setItems([doneBtn], animated: true)
        hourTF.inputAccessoryView = toolbar
        
        
        
        hourTF.inputView = hourPicker
        hourPicker.datePickerMode = .time
        hourPicker.frame.size = CGSize(width: 0, height: 300)
        hourPicker.addTarget(self, action: #selector(hourChanged), for: UIControl.Event.valueChanged)
        hourPicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func hourChanged(sender: UIDatePicker){
        //formatter
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        
        print(sender.date)
        
        hourTF.text = formatter.string(from: sender.date)
        print(sender.date)
        hourTF.text = formatter.string(from: sender.date)
        //self.view.endEditing(true)
    }
    
    @objc func dateHourPressed(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        hourTF.text = formatter.string(from: hourPicker.date)
        self.view.endEditing(true)
    }
    
    //<--------stepper functions--------->
    @IBAction func adultsStepperChanged(_ sender: UIStepper) {
        let last = Int(adultsNum.text ?? "0") ?? 0
        adultsNum.text = String(Int(sender.value))
        total += (Int(sender.value) - last) * costoA!
        totalLbl.text = "$ \(total).00"
    }
    
    @IBAction func kidsStepperChanged(_ sender: UIStepper) {
        let last = Int(kidsNum.text ?? "0") ?? 0
        kidsNum.text = String(Int(sender.value))
        total += (Int(sender.value) - last) * costoN!
        totalLbl.text = "$ \(total).00"
    }
    
    @IBAction func specialStepperChanged(_ sender: UIStepper) {
        let last = Int(specialsNum.text ?? "0") ?? 0
        specialsNum.text = String(Int(sender.value))
        total += (Int(sender.value) - last) * costoE!
        totalLbl.text = "$ \(total).00"
    }
    
    
    //<--------book function--------->
    @IBAction func bookPressed(_ sender: UIButton) {
        guard let date = dateTF.text else  {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Seleccione una fecha", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let hour = hourTF.text else  {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Seleccione un horario", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        // Prepare URL
        let url = URL(string: "https://pacific-inlet-83178.herokuapp.com/reserve")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        
        let uid = Auth.auth().currentUser?.uid
        let email = Auth.auth().currentUser?.email
        let visitId = UUID()
        
        let totalPersons: Int = Int(adultsNum.text ?? "0")! + Int(kidsNum.text ?? "0")! + Int(specialsNum.text ?? "0")!
        
        if totalPersons == 0 {
            let alert = UIAlertController(title: "Sucedió un error..", message: "Seleccione mínimo una persona", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let postString = "userId=\(uid!)&userEmail=\(email!)&visitId=\(visitId)&persons=\(totalPersons)";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
            
                
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                    
                    //add booking to local database (realm)
                    let username = Auth.auth().currentUser?.uid ?? ""
                    var config = Realm.Configuration.defaultConfiguration
                    config.fileURL!.deleteLastPathComponent()
                    config.fileURL!.appendPathComponent(username)
                    config.fileURL!.appendPathExtension("realm")
                    let realm = try! Realm(configuration: config)
                    
                    do {
                        try realm.write {
                            let newBooking = Booking()
                            newBooking.date = date
                            newBooking.hour = hour
                            newBooking.type = self.name!
                            newBooking.image = self.image!
                            
                            realm.add(newBooking)
                            
                            //alert tarjeta agregada con exito
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Reserva", message: "Reservación creada exitosamente", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                        NSLog("The \"OK\" alert occured.")
                                    }))
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        }
                    } catch {
                        print("Eroor")
                    }
                }
            
                //alert succes
        }
        task.resume()
    }
    
//    func addBooking(date: String, hour: String){
//
//    }
    
    
}

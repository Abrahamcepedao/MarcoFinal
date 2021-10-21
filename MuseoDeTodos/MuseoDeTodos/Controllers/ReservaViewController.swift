//
//  ReservaViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 28/09/21.
//

import UIKit

class ReservaViewController: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!//  type of reservation
    
    //variables reserva
    var name: String?
    var costo: Int?
    var costoA: Int?
    var costoN: Int?
    var costoE: Int?
    
    //total
    var total: Int = 0
    @IBOutlet weak var totalLbl: UILabel!
    
    //variables
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var hourTF: UITextField!
    
    //persons
    @IBOutlet weak var personsLbl: UILabel!
    @IBOutlet weak var personsView: UIView!
    @IBOutlet weak var personsStepper: UIStepper!
    @IBOutlet weak var personsNum: UILabel!
    
    //adults
    @IBOutlet weak var adultsLbl: UILabel!
    @IBOutlet weak var adultsView: UIView!
    @IBOutlet weak var adultsNum: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    
    //kids
    @IBOutlet weak var kidsLbl: UILabel!
    @IBOutlet weak var kidsView: UIView!
    @IBOutlet weak var kidsNum: UILabel!
    @IBOutlet weak var kidsStepper: UIStepper!
    
    //studentes
    @IBOutlet weak var studentsLbl: UILabel!
    @IBOutlet weak var studentsView: UIView!
    @IBOutlet weak var studentsNum: UILabel!
    @IBOutlet weak var studentsStepper: UIStepper!
    
    //date
    let datePicker = UIDatePicker()
    
    //hour
    let hourPicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let title = name { titleLbl.text = "Reserva: \(title)" }
        setUpViews()
        setupDatePicker()
        setupHourPicker()
    }
    
    func setUpViews(){
        if (costo == 0 && costoA == 0 && costoN == 0  && costoE == 0) || costo != 0 {
            adultsView.isHidden = true
            kidsView.isHidden = true
            studentsView.isHidden = true
        } else {
            if (costoA != 0 || costoN != 0  || costoE != 0){ personsStepper.isEnabled = false }
            if(costoA == 0){ adultsStepper.isEnabled = false }
            if(costoN == 0){ kidsStepper.isEnabled = false }
            if(costoE == 0){ studentsStepper.isEnabled = false }
        }
        
        
        totalLbl.text = "$ \(total).00"
        
        
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
    @IBAction func personStepperChanged(_ sender: UIStepper) {
        let last = Int(personsNum.text ?? "0") ?? 0
        personsNum.text = String(Int(sender.value))
        total += (Int(sender.value) - last) * costo!
        totalLbl.text = "$ \(total).00"
    }
    
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
    
    
    @IBAction func studentsStepperChanged(_ sender: UIStepper) {
        let last = Int(studentsNum.text ?? "0") ?? 0
        studentsNum.text = String(Int(sender.value))
        total += (Int(sender.value) - last) * costoE!
        totalLbl.text = "$ \(total).00"
    }
    
    //<--------book function--------->
    
    @IBAction func bookPressed(_ sender: UIButton) {
        print(total)
    }
}

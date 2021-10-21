//
//  HistorialViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 21/10/21.
//

import UIKit
import RealmSwift
import FirebaseAuth

class HistorialViewController: UIViewController {

    @IBOutlet weak var historialTV: UITableView!
    
    //booking
    var bookings: Results<Booking>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadBookings()
        setupTV()
    }
    
    func loadBookings(){
        let username = Auth.auth().currentUser?.uid ?? ""
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(username)
        config.fileURL!.appendPathExtension("realm")
        let realm = try! Realm(configuration: config)
        
        bookings = realm.objects(Booking.self)
        historialTV.reloadData()
    }
    
    func setupTV(){
        historialTV.delegate = self
        historialTV.dataSource = self
        let nib = UINib(nibName: "BookingTableViewCell", bundle: nil)
        historialTV.register(nib, forCellReuseIdentifier: "BookingCell")
    }

}

extension HistorialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historialTV.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingTableViewCell
        
        cell.titleLbl.text = "Reserva #\(indexPath.row + 1) - \(bookings?[indexPath.row].type ?? "")"
        cell.dateLbl.text = "Fecha: \(bookings?[indexPath.row].date ?? "")"
        cell.hourLbl.text = "Hora: \(bookings?[indexPath.row].hour ?? "")"
        cell.imgView?.image = UIImage(named: bookings?[indexPath.row].image ?? "img")
        return cell
    }
    
    
}

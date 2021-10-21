//
//  ReservasViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 09/09/21.
//

import UIKit

class ReservasViewController: UIViewController {

    @IBOutlet weak var reservasTV: UITableView!
    
    var reservas: [Reserva] = [
        Reserva(title: "Restaurante", dias: "Martes a domingo", horas: "1pm a 6pm", image: "img", costoA: 0, costoN: 0, costoE: 0, costo: 0),
        Reserva(title: "Visita guiada", dias: "Lunes a domingo", horas: "10am a 6pm", image: "img2", costoA: 100, costoN: 50, costoE: 50, costo: 0),
        Reserva(title: "Visita guiada para niños ",  dias: "Lunes a domingo", horas: "10am a 6pm", image: "img2", costoA: 0, costoN: 50, costoE: 0, costo: 0),
        Reserva(title: "Boletos", dias: "Lunes  a domingo", horas: "10am a 6pm", image: "img2", costoA: 45, costoN: 30, costoE: 30, costo: 0),
        Reserva(title: "Cursos para niños",  dias: "Lunes 5 al 9 de abril", horas: "11am a 3pm", image: "img3", costoA: 0, costoN: 800, costoE: 0, costo: 0),
        Reserva(title: "Cursos para adultos ", dias: "Lunes 15 al 21 de octubre", horas: "11am a 3pm", image: "img2", costoA: 800, costoN: 0, costoE: 0, costo: 0),
        Reserva(title: "Lengua de señas mexicana", dias: "Lunes 15 al 21 de octubre", horas: "11am a 3pm", image: "img4", costoA: 0, costoN: 0, costoE: 0, costo: 800)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTable()
    }
    
    func setupTable() {
        reservasTV.delegate = self
        reservasTV.dataSource = self
        let nib = UINib(nibName: "RerservasTableViewCell", bundle: nil)
        reservasTV.register(nib, forCellReuseIdentifier: "reservaCell")
    }
    

}

extension ReservasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reservas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservaCell") as! RerservasTableViewCell
        
        let reserva = reservas[indexPath.row]
        cell.titulo.text = reserva.title
        cell.dias.text = reserva.dias
        cell.horas.text = reserva.horas
        cell.imagen.image = UIImage(named: reserva.image ?? "img")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc  = storyboard?.instantiateViewController(identifier: "ReservaViewController") as? ReservaViewController{
            vc.name = reservas[indexPath.row].title
            vc.costo = reservas[indexPath.row].costo
            vc.costoA = reservas[indexPath.row].costoA
            vc.costoN = reservas[indexPath.row].costoN
            vc.costoE = reservas[indexPath.row].costoE
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

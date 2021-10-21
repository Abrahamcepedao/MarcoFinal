//
//  Exposiciones2ViewController.swift
//  MuseoDeTodos
//
//  Created by user193339 on 9/17/21.
//

import UIKit
import WebKit

class Exposiciones2ViewController: UIViewController {
    
    @IBOutlet weak var lbl_Titulo: UILabel!
    @IBOutlet weak var lbl_StartDate: UITextView!
    @IBOutlet weak var lbl_Cerraduria: UILabel!
    @IBOutlet weak var lbl_Museografia: UILabel!
    @IBOutlet weak var lbl_Salas: UILabel!
    @IBOutlet weak var lbl_Tecnica: UILabel!
    @IBOutlet weak var lbl_Obras: UILabel!
    @IBOutlet weak var lbl_Contenido: UILabel!
    @IBOutlet weak var wkv_VideoUrl: WKWebView!
        
    var data = Exposicion(id: "", title: "", startDate: "", description: "", cerraduria: "", museografia: "", salas: "", tecnica: "", obras: "", recorridoVirtual: "", videoUrl: "", photoUrl: "")
    
    var link = "https://www.youtube.com/embed/swhrA3qoqx4"

    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_Titulo.text = data.title
        lbl_StartDate.text = String(data.startDate.prefix(10))
        lbl_Cerraduria.text = "Curaduría: " + data.cerraduria
        lbl_Museografia.text = "Museografia: " + data.museografia
        lbl_Salas.text = "Salas: " + data.salas
        lbl_Tecnica.text = "Tecnica: " + data.tecnica
        lbl_Obras.text = "Obras: " + data.obras
        lbl_Contenido.text = data.description
        wkv_VideoUrl.load(URLRequest(url: URL(string: link)!))
    }
    
}

// <iframe width="560" height="315" src="https://www.youtube.com/embed/fv1Q0SPWonk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

//<iframe width="560" height="315" src="https://www.youtube.com/embed/swhrA3qoqx4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


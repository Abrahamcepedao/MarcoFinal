//
//  Exposiciones2ViewController.swift
//  MuseoDeTodos
//
//  Created by user193339 on 9/17/21.
//

import UIKit
import AVKit
import AVFoundation
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
    
    
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var recorridoBtn: UIButton!
    
    
    var data = Exposicion(id: "", title: "", startDate: "", description: "", cerraduria: "", museografia: "", salas: "", tecnica: "", obras: "", recorridoVirtual: "", videoUrl: "", photoUrl: "")
    
    var link = "https://www.youtube.com/embed/swhrA3qoqx4"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupStyles()
    }
    
    func setup(){
        lbl_Titulo.text = data.title
        lbl_StartDate.text = String(data.startDate.prefix(10))
        lbl_Cerraduria.text = "Curaduría: " + data.cerraduria
        lbl_Museografia.text = "Museografia: " + data.museografia
        lbl_Salas.text = "Salas: " + data.salas
        lbl_Tecnica.text = "Tecnica: " + data.tecnica
        lbl_Obras.text = "Obras: " + data.obras
        lbl_Contenido.text = data.description
       
        if data.videoUrl == "" {
            videoBtn.isHidden = true
        }
        if data.recorridoVirtual == "" {
            recorridoBtn.isHidden = true
        }
    }
    
    func setupStyles(){
        videoBtn.layer.cornerRadius = 15
        recorridoBtn.layer.cornerRadius = 15
    }
    
    
    @IBAction func videoBtnPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        nextViewController.url = data.videoUrl!
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func recorridoBtnPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        nextViewController.url = data.recorridoVirtual
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}



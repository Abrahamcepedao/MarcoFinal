//
//  Noticias2ViewController.swift
//  MuseoDeTodos
//
//  Created by user193339 on 10/20/21.
//

import UIKit
import WebKit

class Noticias2ViewController: UIViewController {
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Date: UITextView!
    @IBOutlet weak var lbl_Subtitle: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var img_PhotoUrl: UIImageView!
    
    var data = Noticia(id: "", title: "", subtitle: "", date: "", description: "", photoUrl: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_Title.text = data.title
        lbl_Date.text = String(data.date.prefix(10))
        lbl_Subtitle.text = data.subtitle
        lbl_Description.text = data.description
        if let url = URL(string: data.photoUrl){
            do {
                let imagen = try Data(contentsOf : url)
                self.img_PhotoUrl.image = UIImage(data: imagen)
            
            } catch let err {
                print(" ERROR : \(err.localizedDescription)")
            }
        }
    }
}

// <iframe width="560" height="315" src="https://www.youtube.com/embed/fv1Q0SPWonk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

//<iframe width="560" height="315" src="https://www.youtube.com/embed/swhrA3qoqx4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



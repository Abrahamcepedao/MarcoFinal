//
//  ExposicionesViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 08/09/21.
//

import UIKit
import FirebaseFirestore

class ExposicionesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var exposicionesTV: UITableView!
    
    var exposiciones = [Exposicion]()
    var noticias = [Noticia]()

    var data = [[]]
    
    var p: Int!
    
    private var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exposicionesTV.delegate = self
        exposicionesTV.dataSource = self
        let nib = UINib(nibName: "ExposicionTableViewCell", bundle: nil)
        exposicionesTV.register(nib, forCellReuseIdentifier: "exposicionCell")
        
        p = 0
        
        loadExpositions()
        loadNews()
    }
    
    func loadExpositions() {
        NetworkManager.getExternalData(fileLocation: "https://pacific-inlet-83178.herokuapp.com/expositions", method:  .get, parameters: nil, stringParameters: nil) { (exposition: Exposiciones?, error) in
            if error != nil {
                print(error!)
            } else{
                if let expositionsRequest = exposition {
                    for expositionItem in expositionsRequest {
                        print(expositionItem.photoUrl)
                        let item = Exposicion(id: expositionItem.id, title: expositionItem.title, startDate: expositionItem.startDate, description: expositionItem.description, cerraduria: expositionItem.cerraduria, museografia: expositionItem.museografia, salas: expositionItem.salas, tecnica: expositionItem.tecnica, obras: expositionItem.obras, recorridoVirtual: expositionItem.recorridoVirtual, videoUrl: expositionItem.videoUrl, photoUrl: expositionItem.photoUrl)
                        self.exposiciones.append(item)
                        self.exposicionesTV.reloadData()
                    }
                }
            }
        }
    }
    
    func loadNews() {
        NetworkManager.getExternalData(fileLocation: "https://pacific-inlet-83178.herokuapp.com/news", method:  .get, parameters: nil, stringParameters: nil) { (news: Noticias?, error) in
            if error != nil {
                print(error!)
            } else{
                if let newsRequest = news {
                    for newsItem in newsRequest {
                        print(newsItem.title)
                        let item = Noticia(id: newsItem.id, title: newsItem.title, subtitle: newsItem.subtitle, date: newsItem.date, description: newsItem.description, photoUrl: newsItem.photoUrl)
                        self.noticias.append(item)
                        self.exposicionesTV.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (p == 0){
            return exposiciones.count
        }
        else {
            return noticias.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "exposicionCell") as! ExposicionTableViewCell

        //setup cell
        if (p == 0){
            let exposicion = exposiciones[indexPath.row]
            var photoUrl = exposicion.photoUrl
            if !photoUrl.contains("https"){
                photoUrl = "https" + photoUrl.dropFirst(4)
            }
            if let url = URL(string: photoUrl){
                do {
                    let imagen = try Data(contentsOf : url)
                    cell.backgroundImage.image = UIImage(data: imagen)
                
                } catch let err {
                    print(" ERROR : \(err.localizedDescription)")
                }
            }
            
            cell.tituloLbl.text = exposicion.title
            cell.fechaLbl.backgroundColor = UIColor(red: 239/255, green: 20/255, blue: 150/255, alpha: 1.0)
            cell.fechaLbl.text = String(exposicion.startDate.prefix(10))
        }
        else {
            let noticia = noticias[indexPath.row]
            if let url = URL(string: noticia.photoUrl){
                do {
                    let imagen = try Data(contentsOf : url)
                    cell.backgroundImage.image = UIImage(data: imagen)
                
                } catch let err {
                    print(" ERROR : \(err.localizedDescription)")
                }
            }
            cell.tituloLbl.text = noticia.title
            cell.fechaLbl.backgroundColor = UIColor(red: 239/255, green: 182/255, blue: 0/255, alpha: 1.0)
            cell.fechaLbl.text = String(noticia.date.prefix(10))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          let exposicion = exposiciones[indexPath.row]
        if (p == 0){
            if let vc = storyboard?.instantiateViewController(identifier: "Exposiciones2ViewController") as?
            Exposiciones2ViewController{
            vc.data = exposiciones[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            if let vc = storyboard?.instantiateViewController(identifier: "Noticias2ViewController") as?
            Noticias2ViewController{
            vc.data = noticias[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func  didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func switchCustomTableViewAction(_ sender: UISegmentedControl) {
        p = sender.selectedSegmentIndex
        //print(p)
        exposicionesTV.reloadData()
    }
    
}


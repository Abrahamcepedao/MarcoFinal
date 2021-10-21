//
//  ViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 22/08/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PerfilViewController: UIViewController {
    
    

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var optionsTV: UITableView!
    @IBOutlet weak var datosPerfilBtn: UIButton!
    @IBOutlet weak var centroAyudaBtn: UIButton!
    
    let options: [Option] = [
        Option(title: "Terminos de servicio", image: "info.circle"),
        Option(title: "Acerca del museo", image: "info.circle"),
        Option(title: "Contáctanos", image: "info.circle"),
        Option(title: "Cerrar sesión", image: "info.circle")]
    
    //user
    var userData: User?
    
//    var firstname: String? = nil
    let secondname: String? = nil
    let lastnames: String? = nil
    let sex: String? = nil
    let birthdate: String? = nil
    let email: String? = nil
    
    //db
    private var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionsTV.delegate = self
        optionsTV.dataSource = self
        let nib = UINib(nibName: "OptionsTableViewCell", bundle: nil)
        optionsTV.register(nib, forCellReuseIdentifier: "optionCell")
       

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    func fetchData(){
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        docRef.getDocument { (document, error) in
             if let document = document, document.exists {
                 let data = document.data()
                 // Do something with doc data
                
                let firstname = data?["firstname"] as? String ?? ""
                let lastnames = data?["lastnames"] as? String ?? ""
                let secondame = data?["secondame"] as? String ?? ""
                let birthdate = data?["birthdate"] as? String ?? ""
                let sex = data?["sex"] as? String ?? ""
                let email = data?["email"] as? String ?? ""
                
                self.userData = User(birthdate: birthdate, firstname: firstname, lastnames: lastnames, secondame: secondame, sex: sex, email: email)
            
                
                self.usernameLbl.text =  data?["firstname"] as? String ?? "usuario"
              } else {
                 print("Document does not exist")

              }
        }
    }
    
    
    @IBAction func openDatosPerfil(_ sender: Any){
        
        let vc = PerfilDatosViewController(nibName: "PerfilDatosViewController", bundle: nil)
        vc.nombre = userData?.firstname
        vc.email = userData?.email
        vc.apellidos = userData?.lastnames
        vc.segundoNombre = userData?.secondame
        vc.sex = userData?.sex
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func openCentroAyuda(_ sender: Any){
        
        let vc = CentroAyudaViewController(nibName: "CentroAyudaViewController", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func openEventos(_ sender: UIButton) {
        let vc = HoyViewController(nibName: "HoyViewController", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func reservasPressed(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 2;
    }

    @IBAction func esposicionesPressed(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0;
    }
    
}

extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell")  as!  OptionsTableViewCell
        
        let option = options[indexPath.row]
        cell.optionLbl.text = option.title
        cell.optionImg.image = UIImage(systemName: option.image)
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { //terminos y condiciones

            let vc = TerminosViewController(nibName: "TerminosViewController", bundle: nil)
            
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 1 { // contactanos
            
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "AcercaMuseoViewController") as! AcercaMuseoViewController
                self.present(vc, animated: false, completion: nil)
            }
        }
        
        if indexPath.row == 2 { // contactanos
            
            let vc = CentroAyudaViewController(nibName: "CentroAyudaViewController", bundle: nil)
            
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true, completion: nil)
            
        }
        if indexPath.row == 3 { //cerrar sesión
            //logout user
            try! Auth.auth().signOut()

            //go to login
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "SingUpViewController") as! SignUpViewController
                self.present(vc, animated: false, completion: nil)
            }
            
        }
        
    }
}

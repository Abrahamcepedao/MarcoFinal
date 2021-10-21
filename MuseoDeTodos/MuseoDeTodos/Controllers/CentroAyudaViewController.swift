//
//  CentroAyudaViewController.swift
//  MuseoDeTodos
//
//  Created by Ezequiel Lozano Guerrero on 10/5/21.
//

import UIKit

class CentroAyudaViewController: UIViewController {

    @IBOutlet weak var faqsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func openFaqs(_ sender: Any) {
        
        let vc = FaqsViewController(nibName: "FaqsViewController", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

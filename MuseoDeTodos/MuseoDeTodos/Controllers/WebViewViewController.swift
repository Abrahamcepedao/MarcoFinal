//
//  WebViewViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 20/10/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
    
    var link = "https://www.youtube.com/embed/swhrA3qoqx4"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(url ?? "")
        webView.load(URLRequest(url: URL(string: url ?? link)!))
    }
    
    @IBAction func exitBtnPressed(_ sender: UIButton) {
        print("exit.. pressed..")
        self.dismiss(animated: true, completion: nil)
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

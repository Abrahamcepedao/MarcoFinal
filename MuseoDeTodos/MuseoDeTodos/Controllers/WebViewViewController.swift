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

        // Do any additional setup after loading the view
        webView.load(URLRequest(url: URL(string: url ?? link)!))
    }
    
    @IBAction func exitBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

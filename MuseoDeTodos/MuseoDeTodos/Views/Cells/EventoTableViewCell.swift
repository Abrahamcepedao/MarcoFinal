//
//  EventoTableViewCell.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 13/10/21.
//

import UIKit

class EventoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStyles()
    }
    
    func setupStyles(){
        self.view.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

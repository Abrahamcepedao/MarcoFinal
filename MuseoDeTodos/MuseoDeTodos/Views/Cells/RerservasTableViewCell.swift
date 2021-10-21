//
//  RerservasTableViewCell.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 09/09/21.
//

import UIKit

class RerservasTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var dias: UILabel!
    @IBOutlet weak var horas: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStyles()
    }
    
    func setupStyles(){
        self.containerView.layer.cornerRadius = 10
        self.imagen.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

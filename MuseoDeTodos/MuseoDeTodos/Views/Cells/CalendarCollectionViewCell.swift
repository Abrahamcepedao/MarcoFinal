//
//  CalendarCollectionViewCell.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 13/10/21.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    //Views
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var numEventsView: UIView!
    
    //labels
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var numEventsLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStyles()
    }
    
    func setupStyles(){
        self.dayView.layer.cornerRadius = self.dayView.frame.size.width / 2
        self.numEventsView.layer.borderColor = #colorLiteral(red: 0.8954718709, green: 0.1038885489, blue: 0.6602074504, alpha: 1)
        self.numEventsView.layer.borderWidth = 2.0
        self.numEventsView.layer.cornerRadius = self.numEventsView.frame.size.width / 2
    }

}

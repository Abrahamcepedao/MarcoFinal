//
//  PagoTableViewCell.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 20/10/21.
//

import UIKit

protocol PagoCellDelegate: AnyObject{
    func deleteBtnTapped(with card: String)
}

class PagoTableViewCell: UITableViewCell {
    
    weak var delegate: PagoCellDelegate?

    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var cardNum: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupFunctions()
    }
    
    func setupFunctions(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(PagoTableViewCell.deleteBtnTapped))
        deleteBtn.addGestureRecognizer(tap)
        deleteBtn.isUserInteractionEnabled = true
    }
    
    @objc func deleteBtnTapped(){
        delegate?.deleteBtnTapped(with: cardNum!)
    }
}

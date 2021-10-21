//
//  QuestionTableViewCell.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 14/10/21.
//

import UIKit

protocol QuestionCellDelegate: AnyObject {
    func showBtnTapped(with question: String)
}

class QuestionTableViewCell: UITableViewCell {

    weak var delegate: QuestionCellDelegate?
    
    @IBOutlet weak var viiew: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupStyles()
        setupFunctions()
    }

    func setupStyles(){
        viiew.layer.cornerRadius = 15
    }
    
    func setupFunctions(){
        let showTap = UITapGestureRecognizer(target: self, action: #selector(QuestionTableViewCell.showBtnTapped))
        showBtn.addGestureRecognizer(showTap)
        showBtn.isUserInteractionEnabled = true
    }
    
    @objc func showBtnTapped(){
        delegate?.showBtnTapped(with: questionLbl.text!)
    }
}

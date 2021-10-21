//
//  Card.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 20/10/21.
//

import Foundation
import RealmSwift

class Card: Object{
    @objc dynamic var image: String = ""
    @objc dynamic var number: String = ""
    @objc  dynamic var expiration: String = ""
    @objc  dynamic var cvc: Int16 = 0
}

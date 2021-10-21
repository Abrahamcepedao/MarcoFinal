//
//  Booking.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 21/10/21.
//

import Foundation
import RealmSwift

class Booking: Object{
    @objc dynamic var type: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var hour: String = ""
    @objc dynamic var image: String = ""
}

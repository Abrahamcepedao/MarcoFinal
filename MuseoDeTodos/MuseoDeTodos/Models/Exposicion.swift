//
//  Exposicion.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 08/09/21.
//

import Foundation


struct Exposicion: Codable {
    let id: String
    let title: String
    let startDate: String
    let description: String
    let cerraduria: String
    let museografia: String
    let salas: String
    let tecnica: String
    let obras: String
    let recorridoVirtual: String
    let videoUrl: String?
    let photoUrl: String
}

typealias Exposiciones = [Exposicion]

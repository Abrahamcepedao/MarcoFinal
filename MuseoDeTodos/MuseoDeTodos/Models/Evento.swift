//
//  Evento.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 13/10/21.
//
//
//import Foundation
//
//struct EventosRequest: Codable {
//    let results: [Evento]
//}
//
//struct Evento: Codable {
//    let id: String
//    let events: [String]
//    let date: String
//}


import Foundation

struct EventoElement: Codable {
    let id: String
    let events: [String]
    let date: String
}

typealias Eventos = [EventoElement]

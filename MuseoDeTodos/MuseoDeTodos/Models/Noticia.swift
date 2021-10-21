//
//  Noticia.swift
//  MuseoDeTodos
//
//  Created by user193339 on 10/20/21.
//

import Foundation


struct Noticia: Codable {
    let id: String
    let title: String
    let subtitle: String
    let date: String
    let description: String
    let photoUrl: String
}

typealias Noticias = [Noticia]

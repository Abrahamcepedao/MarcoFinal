//
//  Question.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 14/10/21.
//

import Foundation

struct Question: Codable {
    let question: String
    let answer: String
    var show: Bool
}

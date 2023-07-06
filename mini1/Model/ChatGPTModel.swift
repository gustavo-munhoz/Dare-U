//
//  ChatGPTModel.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 05/07/23.
//

import Foundation

struct Prompt: Codable {
    let role: String
    let content: String
}

struct Request: Codable {
    let model: String
    let messages: [Prompt]
}

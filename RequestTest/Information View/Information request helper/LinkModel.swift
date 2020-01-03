//
//  LinkModel.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import Foundation

struct LinkModel: Codable {
    var next_path: String?
    var error: String?
}

struct InformationModel: Codable {
    var path: String
    var response_code: String
}

struct ErrorModel: Codable {
    var error: String
}

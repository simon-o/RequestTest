//
//  InformationManagerMock.swift
//  RequestTest
//
//  Created by Antoine Simon on 04/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import XCTest
import Alamofire
@testable import RequestTest

class InformationManagerMock {
    var getURLCompletion: ((Result<LinkModel?, AFError>) -> Void)?
    var getInformationCompletion: ((Result<InformationModel?, AFError>) -> Void)?
}

extension InformationManagerMock: InformationManagerProtocol {
    func getURL(completion: @escaping((Result<LinkModel?, AFError>) -> Void)) {
        getURLCompletion = completion
    }
    
    func getInformation(urlFetch: String, completion: @escaping((Result<InformationModel?, AFError>) -> Void)) {
        getInformationCompletion = completion
    }
}

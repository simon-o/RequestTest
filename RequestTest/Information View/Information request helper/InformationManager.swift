//
//  InformationManager.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import Foundation
import Alamofire

protocol InformationManagerProtocol: AnyObject {
    func getURL(completion: @escaping((Result<LinkModel?, AFError>) -> Void))
    func getInformation(urlFetch: String, completion: @escaping((Result<InformationModel?, AFError>) -> Void))
}

final class InformationManager {
    private let url: String
    
    init(url: String = "http://localhost:8000") {
        self.url = url
    }
}

extension InformationManager: InformationManagerProtocol {
    func getURL(completion: @escaping((Result<LinkModel?, AFError>) -> Void)) {
        if let url = URL(string: url) {
            AF.request(URLRequest(url: url))
                .responseJSON { response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else { break }
                        let result = try? JSONDecoder().decode(LinkModel.self, from: data)
                        completion(.success(result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
            }
        }
    }
    
    func getInformation(urlFetch: String, completion: @escaping((Result<InformationModel?, AFError>) -> Void)) {
        if let url = URL(string: urlFetch) {
            AF.request(URLRequest(url: url))
                .responseJSON { response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else { break }
                        let result = try? JSONDecoder().decode(InformationModel.self, from: data)
                        completion(.success(result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
            }
        }
    }
}

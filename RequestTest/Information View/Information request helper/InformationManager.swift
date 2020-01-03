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
   func getURL(completion: @escaping((String) -> Void))
}

final class InformationManager {
    private let url: String
    
    init(url: String = "http://localhost:8000") {
        self.url = url
    }
}

extension InformationManager: InformationManagerProtocol {
    func getURL(completion: @escaping((String) -> Void)) {
        if let url = URL(string: url) {
            AF.request(URLRequest(url: url))
                .responseJSON { response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else { break }
                        let result = try? JSONDecoder().decode(LinkModel.self, from: data)
                        completion(result?.next_path)
                    case .failure(let error):
                        completion(error.errorDescription)
                    }
            }
        }
    }
}

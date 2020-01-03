//
//  InformationPresenter.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import Foundation
import Alamofire

struct defaultsKeys {
    static let countKey = "countKey"
}

protocol InformationPresenterProtocol: AnyObject {
    func attachView(view: InformationViewController)
    func viewDidLoad()
    func buttonPressed()
}

final class InformationPresenter {
    private weak var view: InformationViewController?
    private var manager: InformationManagerProtocol
    
    init(manager: InformationManagerProtocol) {
        self.manager = manager
    }
    
    private func saveCount(number: String) {
        UserDefaults.standard.set(number, forKey: defaultsKeys.countKey)
    }
    
    private func getCount() -> String {
        if let stringOne = UserDefaults.standard.string(forKey: defaultsKeys.countKey) {
            return stringOne
        }
        return "0"
    }
    
    private func getInfo(model: LinkModel?) {
        guard let url = model?.next_path else { return }
        manager.getInformation(urlFetch: url) { [weak self] (result) in
            switch result {
            case .success(let info):
                self?.view?.set(information: "Response Code: " + (info?.response_code ?? info?.error ?? ""))
            case .failure(let error): break
            }
        }
    }
    
    private func getURL() {
        manager.getURL { [weak self] (result) in
            switch result {
            case .success(let model):
                self?.getInfo(model: model)
            case .failure(let error): break
            }
        }
    }
}

extension InformationPresenter: InformationPresenterProtocol {
    func buttonPressed() {
        getURL()
    }
    
    func viewDidLoad() {
        view?.set(count: "Times Fetched: " + getCount())
        view?.set(information: "Response Code:")
        view?.setButton(title: "Load")
    }
    
    func attachView(view: InformationViewController) {
        self.view = view
    }
}

//
//  InformationPresenter.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import Foundation

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
}

extension InformationPresenter: InformationPresenterProtocol {
    func buttonPressed() {
        manager.getURL { (result) in
            print(result)
        }
    }
    
    func viewDidLoad() {
        view?.set(count: getCount())
        view?.set(information: "")
        view?.setButton(title: "Load")
    }
    
    func attachView(view: InformationViewController) {
        self.view = view
    }
}

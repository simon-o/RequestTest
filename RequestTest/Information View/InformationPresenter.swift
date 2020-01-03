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
}

final class InformationPresenter {
    private weak var view: InformationViewController?
    
    init() {
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
    func viewDidLoad() {
        view?.set(count: getCount())
        view?.set(information: "")
        view?.setButton(title: "Load")
    }
    
    func attachView(view: InformationViewController) {
        self.view = view
    }
}

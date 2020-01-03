//
//  InformationPresenter.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import Foundation

protocol InformationPresenterProtocol: AnyObject {
    func attachView(view: InformationViewController)
}

final class InformationPresenter {
    private weak var view: InformationViewController?
    
    init() {
    }
}

extension InformationPresenter: InformationPresenterProtocol {
    func attachView(view: InformationViewController) {
        self.view = view
    }
}

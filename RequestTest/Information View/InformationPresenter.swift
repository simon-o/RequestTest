//
//  InformationPresenter.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

struct defaultsKeys {
    static let countKey = "counterKey"
}

protocol InformationPresenterProtocol: AnyObject {
    func attachView(view: InformationViewControllerProtocol)
    func viewDidLoad()
    func buttonPressed()
}

final class InformationPresenter {
    private weak var view: InformationViewControllerProtocol?
    private var manager: InformationManagerProtocol
    private let countRX: BehaviorRelay<Int> = BehaviorRelay(value: UserDefaults.standard.integer(forKey: defaultsKeys.countKey))
    private var modelRX: BehaviorRelay<LinkModel> = BehaviorRelay(value: LinkModel(next_path: ""))
    private let disposeBag = DisposeBag()
    
    init(manager: InformationManagerProtocol) {
        self.manager = manager
    }
    
    private func saveCount(number: Int) {
        UserDefaults.standard.set(number, forKey: defaultsKeys.countKey)
    }
    
    private func getCount() -> Int {
        return UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
    }
    
    private func getInfo(model: LinkModel?) {
        guard let url = model?.next_path else { return }
        manager.getInformation(urlFetch: url) { [weak self] (result) in
            switch result {
            case .success(let info):
                self?.countRX.accept((self?.countRX.value ?? 0) + 1)
                self?.view?.set(information: "Response Code: " + (info?.response_code ?? info?.error ?? ""))
            case .failure(let error):
                self?.view?.alertView(title: "Error", message: error.errorDescription ?? "Error", buttonTitle: "Ok")
            }
        }
    }
    
    private func getURL() {
        manager.getURL { [weak self] (result) in
            switch result {
            case .success(let model):
                guard let model = model else { return }
                self?.modelRX.accept(model)
            case .failure(let error):
                self?.view?.alertView(title: "Error", message: error.errorDescription ?? "Error", buttonTitle: "Ok")
            }
        }
    }
}

extension InformationPresenter: InformationPresenterProtocol {
    func buttonPressed() {
        modelRX.asObservable().subscribe(onNext: { [weak self] (model) in
            self?.getInfo(model: model)
        },
                                         onError: nil,
                                         onCompleted: nil,
                                         onDisposed: nil).disposed(by: disposeBag)
        getURL()
    }
    
    func viewDidLoad() {
        view?.set(information: "Response Code:")
        view?.setButton(title: "Load")
        
        countRX.asObservable().subscribe(onNext: { [weak self] (count) in
            self?.saveCount(number: count)
            self?.view?.set(count: "Times Fetched: " + String(self?.getCount() ?? 0))
        },
                                         onError: nil,
                                         onCompleted: nil,
                                         onDisposed: nil).disposed(by: disposeBag)
        
        countRX.accept(getCount())
    }
    
    func attachView(view: InformationViewControllerProtocol) {
        self.view = view
    }
}

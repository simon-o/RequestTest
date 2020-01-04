//
//  InformationPresenterTest.swift
//  RequestTestTests
//
//  Created by Antoine Simon on 04/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import XCTest
import Alamofire
@testable import RequestTest

class InformationPresenterTest: XCTestCase {
    var presenter: InformationPresenter!
    var manager: InformationManagerMock!
    
    override func setUp() {
        manager = InformationManagerMock()
        presenter = InformationPresenter(manager: manager)
    }
    
    func test_variable_setUp() {
        let view = InformationViewControllerMock()
        presenter.attachView(view: view)
        
        presenter.viewDidLoad()
        
        XCTAssertNotNil(view.countSet)
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code:")
        XCTAssertEqual(view.titleButton, "Load")
        XCTAssertNil(view.messageError)
        XCTAssertNil(view.titleError)
        XCTAssertNil(view.buttonTitleError)
        
        XCTAssertNil(manager.getURLCompletion)
        XCTAssertNil(manager.getInformationCompletion)
    }
    
    func test_manager_success_success() {
        let view = InformationViewControllerMock()
        let prevCount = UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
        
        presenter.attachView(view: view)
        presenter.viewDidLoad()
        presenter.buttonPressed()
        
        XCTAssertNotNil(manager.getURLCompletion)
        XCTAssertNotNil(manager.getInformationCompletion)
        
        manager.getURLCompletion!(.success(LinkModel.init(next_path: "next1")))
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: defaultsKeys.countKey), prevCount)
        XCTAssertNil(view.messageError)
        XCTAssertNil(view.titleError)
        XCTAssertNil(view.buttonTitleError)
        
        manager.getInformationCompletion!(.success(InformationModel(path: "next2", response_code: "12345", error: nil)))
        
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code: 12345")
    }
    
    func test_manager_fail_success() {
        let view = InformationViewControllerMock()
        let prevCount = UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
        
        presenter.attachView(view: view)
        presenter.viewDidLoad()
        presenter.buttonPressed()
        
        XCTAssertNotNil(manager.getURLCompletion)
        
        manager.getURLCompletion!(.failure(AFError.explicitlyCancelled))
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: defaultsKeys.countKey), prevCount)
        
        //        manager.getInformationCompletion!()
    }
}

class InformationManagerMock: InformationManagerProtocol {
    var getURLCompletion: ((Result<LinkModel?, AFError>) -> Void)?
    var getInformationCompletion: ((Result<InformationModel?, AFError>) -> Void)?
    
    func getURL(completion: @escaping((Result<LinkModel?, AFError>) -> Void)) {
        getURLCompletion = completion
    }
    
    func getInformation(urlFetch: String, completion: @escaping((Result<InformationModel?, AFError>) -> Void)) {
        getInformationCompletion = completion
    }
}

class InformationViewControllerMock: InformationViewControllerProtocol {
    var countSet: String?
    var informationSet: String?
    var titleButton: String?
    var titleError: String?
    var messageError: String?
    var buttonTitleError: String?
    
    func set(count: String) {
        countSet = count
    }
    
    func set(information: String) {
        informationSet = information
    }
    
    func setButton(title: String) {
        titleButton = title
    }
    
    func alertView(title: String, message: String, buttonTitle: String) {
        titleError = title
        messageError = message
        buttonTitleError = buttonTitle
    }
}

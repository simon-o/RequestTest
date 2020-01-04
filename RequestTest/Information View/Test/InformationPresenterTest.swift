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
        XCTAssertEqual(view.informationSet, "Response Code:")
        
        manager.getInformationCompletion!(.success(InformationModel(path: "next2", response_code: "12345", error: nil)))
        
        XCTAssertEqual(prevCount + 1, UserDefaults.standard.integer(forKey: defaultsKeys.countKey))
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code: 12345")
        XCTAssertNil(view.messageError)
        XCTAssertNil(view.titleError)
        XCTAssertNil(view.buttonTitleError)
    }
    
    func test_manager_success_fail_clientSide() {
        let view = InformationViewControllerMock()
        let prevCount = UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
        
        presenter.attachView(view: view)
        presenter.viewDidLoad()
        presenter.buttonPressed()
        
        XCTAssertNotNil(manager.getURLCompletion)
        XCTAssertNotNil(manager.getInformationCompletion)
        
        manager.getURLCompletion!(.success(LinkModel.init(next_path: "next1")))
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: defaultsKeys.countKey), prevCount)
        XCTAssertEqual(view.informationSet, "Response Code:")
        
        manager.getInformationCompletion!(.failure(AFError.explicitlyCancelled))
        
        XCTAssertEqual(prevCount, UserDefaults.standard.integer(forKey: defaultsKeys.countKey))
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code:")
        XCTAssertEqual(view.messageError, "Request explicitly cancelled.")
        XCTAssertEqual(view.titleError, "Error")
        XCTAssertEqual(view.buttonTitleError, "Ok")
    }
    
    func test_manager_fail_clientSide() {
        let view = InformationViewControllerMock()
        let prevCount = UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
        
        presenter.attachView(view: view)
        presenter.viewDidLoad()
        presenter.buttonPressed()
        
        XCTAssertNotNil(manager.getURLCompletion)
        XCTAssertNotNil(manager.getInformationCompletion)
        
        manager.getURLCompletion!(.failure(AFError.explicitlyCancelled))
        
        XCTAssertEqual(prevCount, UserDefaults.standard.integer(forKey: defaultsKeys.countKey))
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code:")
        XCTAssertEqual(view.messageError, "Request explicitly cancelled.")
        XCTAssertEqual(view.titleError, "Error")
        XCTAssertEqual(view.buttonTitleError, "Ok")
    }
    
    func test_manager_success_fail_serverSide() {
        let view = InformationViewControllerMock()
        let prevCount = UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
        
        presenter.attachView(view: view)
        presenter.viewDidLoad()
        presenter.buttonPressed()
        
        XCTAssertNotNil(manager.getURLCompletion)
        XCTAssertNotNil(manager.getInformationCompletion)
        
        manager.getURLCompletion!(.success(LinkModel.init(next_path: "next1")))
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: defaultsKeys.countKey), prevCount)
        XCTAssertEqual(view.informationSet, "Response Code:")
        
        manager.getInformationCompletion!(.success(InformationModel(path: nil, response_code: nil, error: "Error")))
        
        XCTAssertEqual(prevCount, UserDefaults.standard.integer(forKey: defaultsKeys.countKey))
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code: Error")
        XCTAssertNil(view.messageError)
        XCTAssertNil(view.titleError)
        XCTAssertNil(view.buttonTitleError)
    }
    
    func test_manager_success_fail_empty() {
        let view = InformationViewControllerMock()
        let prevCount = UserDefaults.standard.integer(forKey: defaultsKeys.countKey)
        
        presenter.attachView(view: view)
        presenter.viewDidLoad()
        presenter.buttonPressed()
        
        XCTAssertNotNil(manager.getURLCompletion)
        XCTAssertNotNil(manager.getInformationCompletion)
        
        manager.getURLCompletion!(.success(LinkModel.init(next_path: "next1")))
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: defaultsKeys.countKey), prevCount)
        XCTAssertEqual(view.informationSet, "Response Code:")
        
        manager.getInformationCompletion!(.success(InformationModel(path: nil, response_code: nil, error: nil)))
        
        XCTAssertEqual(prevCount, UserDefaults.standard.integer(forKey: defaultsKeys.countKey))
        XCTAssertEqual(view.countSet, "Times Fetched: " + String(UserDefaults.standard.integer(forKey: defaultsKeys.countKey)))
        XCTAssertEqual(view.informationSet, "Response Code:")
        XCTAssertEqual(view.messageError, "Empty")
        XCTAssertEqual(view.titleError, "Error")
        XCTAssertEqual(view.buttonTitleError, "Ok")
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

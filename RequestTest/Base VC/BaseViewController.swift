//
//  BaseViewController.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    func alertView(title: String, message: String, buttonTitle: String)
}

extension BaseViewControllerProtocol where Self: UIViewController {
    func alertView(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  InformationViewController.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import UIKit

protocol InformationViewControllerProtocol: AnyObject {
    
}

final class InformationViewController: UIViewController {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var informationLabel: UILabel!
    @IBOutlet private weak var loadButton: UIButton!
    
    private var presenter: InformationViewControllerProtocol
    
    init(presenter: InformationViewControllerProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: InformationViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension InformationViewController: InformationViewControllerProtocol {
    
}

//
//  InformationViewController.swift
//  RequestTest
//
//  Created by Antoine Simon on 03/01/2020.
//  Copyright © 2020 antoine simon. All rights reserved.
//

import UIKit

protocol InformationViewControllerProtocol: AnyObject {
    func set(count: String)
    func set(information: String)
    func setButton(title: String)
}

final class InformationViewController: UIViewController {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var informationLabel: UILabel!
    @IBOutlet private weak var loadButton: UIButton!
    
    private var presenter: InformationPresenterProtocol
    
    init(presenter: InformationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: InformationViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }
}

extension InformationViewController: InformationViewControllerProtocol {
    func set(count: String) {
        countLabel.text = count
    }
    
    func set(information: String) {
        informationLabel.text = information
    }
    
    func setButton(title: String) {
        loadButton.setTitle(title, for: .normal)
    }
}

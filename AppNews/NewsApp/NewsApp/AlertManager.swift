//
//  AlertManager.swift
//  NewsApp
//
//  Created by Иван Курганский on 16/02/2025.
//

import UIKit

final class AlertManager {
    static func showAlert(on viewController: UIViewController,
                          title: String,
                          message: String,
                          buttonTitle: String = "OK",
                          action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle,
                                     style: .default) { _ in
            action?()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
}

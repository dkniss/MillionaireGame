//
//  UIViewController+Ext.swift
//  Millionaire
//
//  Created by Daniil Kniss on 17.03.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, completion: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        })
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
    
    func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

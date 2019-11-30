//
//  UIViewController+Errors.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 30.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

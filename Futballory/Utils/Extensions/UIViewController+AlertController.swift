//
//  UIViewController+AlertController.swift
//  Futballory
//
//  Created by Aldair Carrillo on 09/11/23.
//

import UIKit

extension UIViewController {
    public func openAlert(title: String?,
                          message: String?,
                          alertStyle: UIAlertController.Style,
                          actionTitles: [String],
                          actionStyle: [UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)?]) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for (index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyle[index], handler: actions[index])
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true)
    }
}

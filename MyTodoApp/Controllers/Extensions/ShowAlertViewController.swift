//
//  ShowAlertViewController.swift
//  MyTodoApp
//
//  Created by Usuario invitado on 11/8/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showAlert(with message: String){
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

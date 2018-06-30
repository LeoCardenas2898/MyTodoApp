//
//  SignInViewController.swift
//  MyTodoApp
//
//  Created by Guest User on 6/30/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    //Ctrl + Arrastre para crear Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Colocar texto en tiempo de ejecución
        titleLabel.text = "Bienvenido"
    }
    
    //Para desactivar el teclado tocando cualquier lado de la pantalla
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //Colocar Action y definir la acccion del Button
    @IBAction func signInAction(_ sender: UIButton) {
        //Ir a StoryBoard Home
        performSegue(withIdentifier: "goToHome", sender: nil)
    }
}

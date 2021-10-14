//
//  ViewController.swift
//  loginFirebaseAula21-09
//
//  Created by Maysa on 21/09/21.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "LoginViewController", sender: "LoginViewController")
    }
    
    @IBAction func cadastroButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "SignInViewController", sender: "SignInViewController")
    }
    
}

//
//  LoginViewController.swift
//  loginFirebaseAula21-09
//
//  Created by Maysa on 21/09/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailUserTF: UITextField!
    
    @IBOutlet weak var senhaUserTF: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
   
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonLogin2(_ sender: UIButton) {
        
        let email = emailUserTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let senha = senhaUserTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: senha) { (result, errorCall) in if errorCall != nil {
      
            self.showError(mensagem: errorCall!.localizedDescription)
        }else{
            self.goToHome()
        }
    }
    }
    func goToHome() {
      let home = storyboard?.instantiateViewController(identifier: "HomeVC")
      view.window?.rootViewController = home
      view.window?.makeKeyAndVisible()
}
    func showError(mensagem: String){
      errorLabel.alpha = 1
      errorLabel.text = mensagem
    }
}


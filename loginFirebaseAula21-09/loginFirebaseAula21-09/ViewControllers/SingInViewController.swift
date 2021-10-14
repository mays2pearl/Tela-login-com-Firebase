//
//  SingInViewController.swift
//  loginFirebaseAula21-09
//
//  Created by Maysa on 21/09/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var lastNameTF: UITextField!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  @IBAction func signInAction(_ sender: Any) {
    let error = verifyTextFields()
    if error != nil {
      showError(mensagem: error!)
    } else {
      let firstName = firstNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let lastName = lastNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      Auth.auth().createUser(withEmail: email, password: password) { (result, errorCall) in
        if errorCall != nil {
          self.showError(mensagem: "Não foi possível criar o usuário")
        } else {
          let firestore = Firestore.firestore()
          firestore.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid":result?.user.uid]) { (error) in
            if error != nil {
              self.showError(mensagem: "erro ao cadastrar o usuário")
            }
          }
          self.goToHome()
        }
      }
    }
  }
  func goToHome() {
    let home = storyboard?.instantiateViewController(identifier: "HomeVC")
    view.window?.rootViewController = home
    view.window?.makeKeyAndVisible()
  }
  func verifyTextFields() -> String? {
    if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      return "Preencha todos os campos"
    }
    let currentlyPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    if isPasswordValid(currentlyPassword) == false {
      return "Sua senha não esta valida, digite um senha com mais de 8 caracteres."
    }
    return nil
  }
  func isPasswordValid(_ password : String) -> Bool{
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
  }
  func showError(mensagem: String){
    errorLabel.alpha = 1
    errorLabel.text = mensagem
  }
}

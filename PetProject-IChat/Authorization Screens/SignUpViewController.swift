//
//  SignUpViewContoller.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import  UIKit

class SignUpViewController : UIViewController {
    
    let welcomeLbl = UILabel(text: "Good to see you!", font: .avenirFont30())
    let passwordLbl = UILabel(text: "Password")
    let emailLbl = UILabel(text: "Email")
    let confirmLbl = UILabel(text: "Confirm password")
    let loginnedLbl = UILabel(text: "Already registered?")
    
    let signupBtn = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .darkGray, cornerRadius: 10)
    let loginBtn = UIButton()
    
    let emailTF = OneLineTextField(font: .avenirFont())
    let passwordTF = OneLineTextField(font: .avenirFont())
    let confirmTF = OneLineTextField(font: .avenirFont())
    let loginTF = OneLineTextField(font: .avenirFont())
    
    weak var delegate: AuthNavigationDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(.red, for: .normal)
        setupConstraints()
        
        signupBtn.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
    }
    
    @objc func signUpBtnTapped() {
        
        AuthService.shared.register(email: emailTF.text, password: passwordTF.text, confirm: passwordTF.text) { (result) in
            switch result {
            case .success(let user):
                //self.showAlert(title: "Успешно", message: "You Registered")
                self.showAlert(title: "Успешно", message: "You Registered") {
                    self.present(SetupProfileViewController(currentUser: user   ), animated: true, completion: nil)
                }
                print(user.email ?? "")
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @objc func loginBtnTapped(){
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
    
}
// MARK:  Setup Constraints
extension SignUpViewController {
    
    private func setupConstraints(){
        let emailStackView = UIStackView(arrangedSubviews: [emailTF,emailLbl], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordTF,passwordLbl], axis: .vertical, spacing: 0)
        let confirmStackView = UIStackView(arrangedSubviews: [confirmTF,confirmLbl], axis: .vertical, spacing: 0)
        signupBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView,passwordStackView,confirmStackView, signupBtn], axis: .vertical, spacing: 40)
        
        let bottomStackView = UIStackView(arrangedSubviews: [loginnedLbl,loginBtn], axis: .horizontal, spacing: 40)
        
        welcomeLbl.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLbl)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)

        NSLayoutConstraint.activate([
            welcomeLbl.topAnchor.constraint(equalTo: view.topAnchor,constant: 160),
            welcomeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLbl.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}


// MARK: SwiftUI
 import SwiftUI
struct SignUpControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
         let vc = SignUpViewController()

        func makeUIViewController(context: Context) -> some UIViewController {
            return vc
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }

    }
}

extension UIViewController{
    func showAlert(title:String, message: String, completion:@escaping ()->Void = {}) {
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alertC.addAction(action)
        present(alertC, animated: true, completion: nil)
    }
}

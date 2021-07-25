//
//  ViewController.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import UIKit

class AuthViewController: UIViewController {

    //кнопки
    let emailBtn = UIButton(title: "Email", titleColor: .white, backgroundColor: .black, font: .avenirFont() )
   
    let googleBtn = UIButton(title: "Google",titleColor: .black, backgroundColor: .white)
     
    let loginBtn = UIButton(title: "Login", titleColor: .red, backgroundColor: .white, font: .avenirFont16(), cornerRadius: 15)
    //Лейбл
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: " Or sign with email")
    let loginLabel = UILabel(text: "Already registred?")

    let logoImage = UIImageView(image: #imageLiteral(resourceName: "logo"), contendMode: .scaleAspectFit)
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        googleBtn.customizeGoogleButton()
        
        loginVC.delegate    = self
        signUpVC.delegate   = self
        
        emailBtn.addTarget(self, action: #selector(emailBtnTapped), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
    }
    
  @objc private func emailBtnTapped() {
        present(signUpVC, animated: true, completion: nil)
    }
    
@objc private func loginBtnTapped() {
    present(loginVC, animated: true, completion: nil)
      }
}

// MARK:  Setup Constraints
extension AuthViewController {
    func setupConstraints() {
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        let googleView = ButtonFormView(label: googleLabel, button: googleBtn)
        let emailView = ButtonFormView(label: emailLabel, button: emailBtn)
        let loginView = ButtonFormView(label: loginLabel, button: loginBtn)
        
        
        let stackView = UIStackView(arrangedSubviews: [googleView,emailView,loginView], axis: .vertical, spacing: 50)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImage)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor , constant: 160),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 90),
            logoImage.widthAnchor.constraint(equalToConstant : 90)
        ])
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
}

extension AuthViewController: AuthNavigationDelegate {
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    
}





// MARK: SwiftUI
 import SwiftUI
struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
         let vc = AuthViewController()

        func makeUIViewController(context: Context) -> some UIViewController {
            return vc
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }

    }
}



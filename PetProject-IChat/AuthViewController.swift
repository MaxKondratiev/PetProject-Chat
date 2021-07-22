//
//  ViewController.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import UIKit

class AuthViewController: UIViewController {

    //кнопки
    let emailBtn = UIButton(title: "Email", titleColor: .black, backgroundColor: .white, font: .avenirFont(), isShadow: false, cornerRadius: 10)
   
    let googleBtn = UIButton(title: "Google",titleColor: .black, backgroundColor: .white, isShadow: false, cornerRadius: 10)
     
    let loginBtn = UIButton(title: "Login", titleColor: .black, backgroundColor: .white, font: .avenirFont16(), isShadow: true, cornerRadius: 10)
    //Лейбл
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: " Or sign with email")
    let loginLabel = UILabel(text: "Already registred?")
    
    


    
    let logoImage = UIImageView(image: #imageLiteral(resourceName: "logo"), contendMode: .scaleAspectFit)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor , constant: 160),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 90),
            logoImage.widthAnchor.constraint(equalToConstant : 90)
        ])
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



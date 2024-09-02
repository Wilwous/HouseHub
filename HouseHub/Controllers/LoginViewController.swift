//
//  LoginViewController.swift
//  HouseHub
//
//  Created by Антон Павлов on 29.08.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let authService = AuthService()
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход в аккаунт"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 14)
        
        if let originalImage = UIImage(named: "emailIcon") {
            let tintedImage = originalImage.withRenderingMode(.alwaysTemplate)
            let imageView = UIImageView(image: tintedImage)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = UIColor.gray.withAlphaComponent(0.4)
            
            textField.leftView = imageView
        }
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 14)
        
        let imageView = UIImageView(image: UIImage(named: "passwordLock"))
        imageView.contentMode = .scaleAspectFit
        textField.leftView = imageView
        textField.leftViewMode = .always
        imageView.tintColor = UIColor.gray.withAlphaComponent(0.4)
        
        let passwordToggleButton = UIButton(type: .custom)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordToggleButton.tintColor = UIColor.gray.withAlphaComponent(0.6)
        passwordToggleButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        passwordToggleButton.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )
        
        let toggleButtonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        toggleButtonContainer.addSubview(passwordToggleButton)
        passwordToggleButton.center = toggleButtonContainer.center
        
        textField.rightView = toggleButtonContainer
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .wSunsetOrange
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addElements()
        setupLayoutConstraint()
    }
    
    // MARK: - Private Methods
    
    private func navigateToDashboard() {
        let mainTabBarController = MainTabBarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = mainTabBarController
            window.makeKeyAndVisible()
        }
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        let backButtonImage = UIImage(systemName: "chevron.backward.circle.fill")?
            .withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(type: .system)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = UIColor.gray.withAlphaComponent(0.3)
        backButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        let forgotPasswordButton = UIBarButtonItem(
            title: "Забыли пароль?",
            style: .plain,
            target: self,
            action: #selector(forgotPasswordTapped)
        )
        forgotPasswordButton.tintColor = .gray
        forgotPasswordButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ], for: .normal)
        
        navigationItem.rightBarButtonItem = forgotPasswordButton
    }
    
    // MARK: - Helpers
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    // MARK: - Setup View
    
    private func addElements() {
        [titleLabel,
         emailTextField,
         passwordTextField,
         loginButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 34),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 34),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Animation
    
    private func transitionToDashboardWithAnimation() {
        let mainTabBarController = MainTabBarController()
        
        UIView.transition(with: view.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = mainTabBarController
                window.makeKeyAndVisible()
            }
        }, completion: nil)
    }
    
    // MARK: - Action
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func loginButtonTapped() {
        guard let username = emailTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(
                title: "Ошибка",
                message: "Пожалуйста, введите логин и пароль"
            )
            return
        }
        
        authService.performLogin(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    print("Ответ сервера: \(json)")
                    if let error = json["error"] as? String {
                        self?.showAlert(title: "Ошибка", message: error)
                    } else {
                        self?.transitionToDashboardWithAnimation()
                    }
                case .failure(let error):
                    self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }
    
    @objc private func forgotPasswordTapped() {
        let webViewController = WebViewController(websiteLink: Constants.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        let button = passwordTextField.rightView?.subviews.first as? UIButton
        button?.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

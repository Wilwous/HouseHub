//
//  StartViewController.swift
//  HouseHub
//
//  Created by Антон Павлов on 28.08.2024.
//

import UIKit

final class StartViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро\nпожаловать!"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var authorizationPromptLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизуйтесь, чтобы продолжить работу"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вход", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .wSunsetOrange
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(registerButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var inviteToManageHomeButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Пригласить и управлять своим домом"
        configuration.baseForegroundColor = .wSkyBlue
        
        let houseIcon = UIImage(systemName: "house"
        )?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 12)
        )
        configuration.image = houseIcon
        configuration.imagePadding = 5
        configuration.imagePlacement = .leading
        
        var titleAttributedString = AttributedString("Пригласить и управлять своим домом")
        titleAttributedString.font = .systemFont(ofSize: 14, weight: .bold)
        configuration.attributedTitle = titleAttributedString
        
        let button = UIButton(configuration: configuration)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )
        button.addTarget(
            self,
            action: #selector(inviteToManageHomeTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addElements()
        setupLayoutConstraint()
    }
    
    // MARK: - Setup View
    
    private func addElements() {
        [titleLabel,
         authorizationPromptLabel,
         loginButton,
         registerButton,
         inviteToManageHomeButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            titleLabel.bottomAnchor.constraint(equalTo: authorizationPromptLabel.topAnchor, constant: -46),
            
            authorizationPromptLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -33),
            authorizationPromptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 17),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            
            inviteToManageHomeButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 38),
            inviteToManageHomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inviteToManageHomeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58)
        ])
    }
    
    // MARK: - Action
    
    @objc private func loginButtonTapped() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func registerButtonTapped() {
        let webViewController = WebViewController(websiteLink: Constants.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc private func inviteToManageHomeTapped() {
        let webViewController = WebViewController(websiteLink: Constants.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

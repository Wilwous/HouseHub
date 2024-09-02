//
//  DashboardViewController.swift
//  HouseHub
//
//  Created by Антон Павлов on 29.08.2024.
//

import UIKit

final class DashboardViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dashboardService = DashboardService()
    private var dashboardData: DashboardData?
    
    // MARK: - UI Components
    
    private lazy var headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var userAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var notificationIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.fill")
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private lazy var notificationBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var notificationBadgeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        let todayText = "Сегодня"
        let dateText = "12 апреля"
        let attributedText = NSMutableAttributedString(
            string: todayText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.black
            ]
        )
        attributedText.append(NSAttributedString(
            string: " \(dateText)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 23, weight: .regular),
                .foregroundColor: UIColor.systemGray
            ]
        ))
        label.attributedText = attributedText
        
        return label
    }()
    
    private lazy var notificationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let notificationLabel = UILabel()
        notificationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        notificationLabel.textColor = .black
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationLabel)
        
        let redDotView = UIView()
        redDotView.backgroundColor = .red
        redDotView.layer.cornerRadius = 5
        redDotView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redDotView)
        
        NSLayoutConstraint.activate([
            notificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notificationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            redDotView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            redDotView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            redDotView.widthAnchor.constraint(equalToConstant: 10),
            redDotView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        return view
    }()
    
    private lazy var rentPaymentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let iconContainer = UIView()
        iconContainer.backgroundColor = .wDeepNavyBlue
        iconContainer.layer.cornerRadius = 20
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconContainer)
        
        let iconImageView = UIImageView(image: UIImage(named: "profit")?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Квартплата"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        let amountLabel = UILabel()
        amountLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .right
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 5),
            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -3),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            
            amountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    private lazy var meterReadingsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let iconContainer = UIView()
        iconContainer.backgroundColor = .wDeepNavyBlue
        iconContainer.layer.cornerRadius = 20
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconContainer)
        
        let iconImageView = UIImageView(image: UIImage(named: "meter")?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Показания счётчиков"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        let smallIconsStackView = UIStackView()
        smallIconsStackView.axis = .horizontal
        smallIconsStackView.spacing = 8
        smallIconsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let waterIcon = UIImageView(image: UIImage(systemName: "drop.fill"))
        waterIcon.tintColor = .black
        waterIcon.contentMode = .scaleAspectFit
        waterIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let electricityIcon = UIImageView(image: UIImage(systemName: "bolt.fill"))
        electricityIcon.tintColor = .black
        electricityIcon.contentMode = .scaleAspectFit
        electricityIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let thermometerIcon = UIImageView(image: UIImage(systemName: "thermometer"))
        thermometerIcon.tintColor = .black
        thermometerIcon.contentMode = .scaleAspectFit
        thermometerIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let heatIcon = UIImageView(image: UIImage(systemName: "flame.fill"))
        heatIcon.tintColor = .black
        heatIcon.contentMode = .scaleAspectFit
        heatIcon.translatesAutoresizingMaskIntoConstraints = false
        
        [waterIcon, electricityIcon, thermometerIcon, heatIcon].forEach {
            $0.widthAnchor.constraint(equalToConstant: 14).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
            smallIconsStackView.addArrangedSubview($0)
        }
        
        view.addSubview(smallIconsStackView)
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            
            smallIconsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            smallIconsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -9)
        ])
        
        return view
    }()
    
    private lazy var insuranceView: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView(image: UIImage(named: "umbrella"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemGreen
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Страхование"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Защитим имущество и здоровье"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -16)
        ])
        
        return button
    }()
    
    private lazy var camerasButton: UIButton = {
        let button = UIButton(type: .system)
        let iconContainer = UIView()
        iconContainer.backgroundColor = .wDeepNavyBlue
        iconContainer.layer.cornerRadius = 25
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconContainer)
        
        let iconImageView = UIImageView(image: UIImage(named: "securityCamera")?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)
        
        let label = UILabel()
        label.text = "Камеры"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(label)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(
            self, action: #selector(camerasButtonTapped),
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            iconContainer.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            iconContainer.topAnchor.constraint(equalTo: button.topAnchor, constant: 15),
            iconContainer.widthAnchor.constraint(equalToConstant: 50),
            iconContainer.heightAnchor.constraint(equalToConstant: 50),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    private lazy var gateButton: UIButton = {
        let button = UIButton(type: .system)
        let iconContainer = UIView()
        iconContainer.backgroundColor = .wDeepNavyBlue
        iconContainer.layer.cornerRadius = 25
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconContainer)
        
        let iconImageView = UIImageView(image: UIImage(named: "parkingBarrier")?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)
        
        let label = UILabel()
        label.text = "Шлагбаум"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(label)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(
            self,
            action: #selector(gateButtonTapped),
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            iconContainer.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            iconContainer.topAnchor.constraint(equalTo: button.topAnchor, constant: 15),
            iconContainer.widthAnchor.constraint(equalToConstant: 50),
            iconContainer.heightAnchor.constraint(equalToConstant: 50),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    private lazy var offersButton: UIButton = {
        let button = UIButton(type: .system)
        let iconContainer = UIView()
        iconContainer.backgroundColor = .wDeepNavyBlue
        iconContainer.layer.cornerRadius = 25
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconContainer)
        
        let iconImageView = UIImageView(image: UIImage(named: "lampIcon")?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)
        
        let label = UILabel()
        label.text = "Предложения"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(label)
        
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(
            self,
            action: #selector(offersButtonTapped),
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            iconContainer.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            iconContainer.topAnchor.constraint(equalTo: button.topAnchor, constant: 15),
            iconContainer.widthAnchor.constraint(equalToConstant: 50),
            iconContainer.heightAnchor.constraint(equalToConstant: 50),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                camerasButton,
                gateButton,
                offersButton
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var allServicesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Все сервисы", for: .normal)
        button.backgroundColor = .wSunsetOrange
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(allServicesButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .wDeepNavyBlue
        addElements()
        setupLayoutConstrain()
        loadData()
    }
    
    // MARK: - Setup View
    
    private func addElements() {
        [headerView,
         contentView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [avatarImageView,
         userNameLabel,
         userAddressLabel,
         notificationIconView,
         notificationBadgeView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
        }
        
        notificationBadgeView.addSubview(notificationBadgeLabel)
        
        [dateLabel,
         notificationView,
         rentPaymentView,
         meterReadingsView,
         insuranceView,
         buttonStackView,
         allServicesButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupLayoutConstrain() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            avatarImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -37),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            userNameLabel.bottomAnchor.constraint(equalTo: userAddressLabel.topAnchor, constant: -4),
            
            userAddressLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            userAddressLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -20),
            
            notificationIconView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            notificationIconView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            notificationIconView.widthAnchor.constraint(equalToConstant: 24),
            notificationIconView.heightAnchor.constraint(equalToConstant: 24),
            
            notificationBadgeView.trailingAnchor.constraint(equalTo: notificationIconView.trailingAnchor, constant: 8),
            notificationBadgeView.topAnchor.constraint(equalTo: notificationIconView.topAnchor, constant: -4),
            notificationBadgeView.widthAnchor.constraint(equalToConstant: 16),
            notificationBadgeView.heightAnchor.constraint(equalToConstant: 16),
            
            notificationBadgeLabel.centerXAnchor.constraint(equalTo: notificationBadgeView.centerXAnchor),
            notificationBadgeLabel.centerYAnchor.constraint(equalTo: notificationBadgeView.centerYAnchor),
            
            contentView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -600),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: notificationView.topAnchor, constant: -16),
            
            notificationView.heightAnchor.constraint(equalToConstant: 52),
            notificationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            notificationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            notificationView.bottomAnchor.constraint(equalTo: rentPaymentView.topAnchor, constant: -16),
            
            rentPaymentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            rentPaymentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rentPaymentView.heightAnchor.constraint(equalToConstant: 43),
            
            meterReadingsView.topAnchor.constraint(equalTo: rentPaymentView.bottomAnchor, constant: 30),
            meterReadingsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            meterReadingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            meterReadingsView.heightAnchor.constraint(equalToConstant: 43),
            
            insuranceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            insuranceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            insuranceView.topAnchor.constraint(equalTo: meterReadingsView.bottomAnchor, constant: 30),
            insuranceView.heightAnchor.constraint(equalToConstant: 63),
            
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonStackView.topAnchor.constraint(equalTo: insuranceView.bottomAnchor, constant: 30),
            buttonStackView.heightAnchor.constraint(equalToConstant: 100),
            
            allServicesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            allServicesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            allServicesButton.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 15),
            allServicesButton.heightAnchor.constraint(equalToConstant: 60),
            allServicesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    // MARK: - Load Data
    
    private func loadData() {
        dashboardService.fetchDashboardData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSuccess(data: data)
                case .failure(let error):
                    print("Failed to load dashboard data: \(error)")
                }
            }
        }
    }
    
    private func handleSuccess(data: [String: Any]) {
        var userName = "Неизвестно"
        var userAddress = "Неизвестно"
        var userProfileImageURL: String?
        
        if let profileData = data["my_profile"] as? [String: Any] {
            let firstName = profileData["first_name"] as? String ?? ""
            let lastName = profileData["last_name"] as? String ?? ""
            let secondName = profileData["second_name"] as? String ?? ""
            userName = formatUserName(firstName: firstName, lastName: lastName, secondName: secondName)
            userAddress = profileData["address"] as? String ?? "Неизвестно"
            userProfileImageURL = profileData["photo"] as? String
        }
        
        var notificationCount = 0
        var notifications = "Нет новых уведомлений"
        
        if let notificationsData = data["my_new_notifications"] as? Int {
            if notificationsData >= 0 {
                notificationCount = notificationsData
                if notificationCount > 0 {
                    notifications = "У вас \(notificationCount) новых уведомлений"
                }
            }
        }
        
        var rentPayment = "Неизвестно"
        var rentPaymentDescription = "Неизвестно"
        var meterReadings = "Нет данных"
        
        if let dashboardData = data["customer_dashboard"] as? [String: Any] {
            if let menuItems = dashboardData["menu_items"] as? [[String: Any]] {
                for item in menuItems {
                    if let name = item["name"] as? String, name == "Квартплата" {
                        let arrear = item["arrear"] as? String ?? "0"
                        rentPayment = "\(arrear) ₽"
                        rentPaymentDescription = item["description"] as? String ?? "Неизвестно"
                    } else if let name = item["name"] as? String, name == "Показания счётчиков" {
                        meterReadings = item["description"] as? String ?? "Нет данных"
                    }
                }
            }
        }
        
        self.dashboardData = DashboardData(
            userName: userName,
            userAddress: userAddress,
            notificationCount: notificationCount,
            notifications: notifications,
            rentPayment: rentPayment,
            meterReadings: meterReadings
        )
        
        updateUI(rentPaymentDescription: rentPaymentDescription)
        
        if let profileImageURL = userProfileImageURL, let url = URL(string: profileImageURL) {
            loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.avatarImageView.image = image
                }
            }
        }
    }
    
    
    private func updateUI(rentPaymentDescription: String) {
        guard let data = dashboardData else { return }
        
        userNameLabel.text = data.userName
        userAddressLabel.text = data.userAddress
        
        if data.notificationCount >= 0 {
            notificationBadgeLabel.text = "\(data.notificationCount)"
            notificationBadgeView.isHidden = data.notificationCount == 0
            notificationView.subviews.compactMap { $0 as? UILabel }.first?.text = data.notifications
        }
        
        let rentPaymentTitleLabel = rentPaymentView.subviews.compactMap { $0 as? UILabel }.first
        let rentPaymentAmountLabel = rentPaymentView.subviews.compactMap { $0 as? UILabel }.last
        rentPaymentTitleLabel?.text = "Квартплата"
        rentPaymentAmountLabel?.text = data.rentPayment
        
        let rentPaymentSubtitleLabel = rentPaymentView.subviews.compactMap { $0 as? UILabel }[1]
        rentPaymentSubtitleLabel.text = rentPaymentDescription
        
        let meterReadingsTitleLabel = meterReadingsView.subviews.compactMap { $0 as? UILabel }.first
        let meterReadingsSubtitleLabel = meterReadingsView.subviews.compactMap { $0 as? UILabel }.last
        meterReadingsTitleLabel?.text = "Показания счётчиков"
        meterReadingsSubtitleLabel?.text = data.meterReadings
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func formatUserName(firstName: String, lastName: String, secondName: String) -> String {
        let firstNameInitial = firstName.prefix(1)
        let secondNameInitial = secondName.prefix(1)
        return "\(lastName) \(firstNameInitial).\(secondNameInitial)."
    }
    
    // MARK: - Action
    
    @objc private func camerasButtonTapped() {
        let webViewController = WebViewController(websiteLink: Constants.URLs.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc private func gateButtonTapped() {
        let webViewController = WebViewController(websiteLink: Constants.URLs.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc private func offersButtonTapped() {
        let webViewController = WebViewController(websiteLink: Constants.URLs.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc private func  allServicesButtonTapped() {
        let webViewController = WebViewController(websiteLink: Constants.URLs.websiteLink)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

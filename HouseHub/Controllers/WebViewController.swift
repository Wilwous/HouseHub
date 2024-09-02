//
//  WebViewController.swift
//  HouseHub
//
//  Created by Антон Павлов on 01.09.2024.
//
/*
   Это WebView сделано ради шутки и поднятия настроения,
   неожиданная пасхалка, ну и чтобы экраны и кнопки не были пустые 😄
*/

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: - Static Property
    
    static let websiteLink = "https://clck.ru/3CxnzT"
    
    // MARK: - UI Components
    
    private lazy var webView: WKWebView = {
        let web = WKWebView(frame: .zero)
        web.navigationDelegate = self
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initializer
    
    init(websiteLink: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadWebView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadWebView() {
        if let url = URL(string: Constants.websiteLink) {
            activityIndicator.startAnimating()
            webView.load(URLRequest(url: url))
        } else {
            showErrorAlert()
        }
    }
    
    // MARK: - Alert
    
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Не удалось загрузить страницу.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showErrorAlert()
    }
}

//
//  ViewController.swift
//  Easy Browser, Project 4
//
//  Created by Igor Polousov on 28.06.2021.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    // Создали свойство класса webView
    var webView: WKWebView!
    
    // Запустили метод loadView в котором указано как будет выглядеть view
    override func loadView() {
        webView = WKWebView() // присвоили свойству значение класса
        webView.navigationDelegate = self // сделали чтобы WKWebView был под управлением webWiew
        view = webView // присвоили view storyBoard значение webView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // создали переменную с указанием URL адреса в виде строки
        let url = URL(string: "HTTPS://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url)) // передали значение переменной в webView
        // Строка ниже позволяет сделать доступными жесты "назад" и "вперед" как в браузере
        webView.allowsBackForwardNavigationGestures = true
        // Кнопка в navigation bar с функцией openTapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        }

    @objc func openTapped() {
        // alert controller
        let ac = UIAlertController(title: "Open page ...", message: nil, preferredStyle: .actionSheet)
        // actions for alert controller, choose to load apple or hackingwithswift or cancel with function openPage
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        // popOverController for iPad
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        // show alert controller
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        // Проверили что выбрана одна из опций
        guard let actionTitle = action.title else { return }
        // если выбрана одна из опций передать занчение опции в URL
        guard let url = URL(string: "HTTPS://" + actionTitle)  else { return }
        // Load URL
        webView.load(URLRequest(url: url))
    }
    
    // Show title for webView
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}


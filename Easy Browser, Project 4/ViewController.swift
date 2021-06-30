//
//  ViewController.swift
//  Easy Browser, Project 4
//  Day 25
//  Created by Igor Polousov on 28.06.2021.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    // Создали свойство класса webView
    var webView: WKWebView!
    // Создали свойство класса progressView
    var progressView: UIProgressView!
    // Создали массив с сайтами
    var websites = ["hackingwithswift.com", "apple.com", "mywool.shop"]
    
    
    // Запустили метод loadView в котором указано как будет выглядеть view
    override func loadView() {
        webView = WKWebView() // присвоили свойству значение класса
        webView.navigationDelegate = self // сделали чтобы WKWebView был под управлением webWiew
        view = webView // присвоили view storyBoard значение webView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // создали переменную с указанием URL адреса в виде строки
        let url = URL(string: "HTTPS://" + websites[0])!
        webView.load(URLRequest(url: url)) // передали значение переменной в webView
        // Строка ниже позволяет сделать доступными жесты "назад" и "вперед" как в браузере
        webView.allowsBackForwardNavigationGestures = true
        // Добавили наблюдателя к webView чтобы получать инфо о прогрессе загрузки(estimatedProgress)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        // Кнопка в navigation bar с функцией openTapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        // Создали progress view
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        // Добавили кнопку progressButton
        let progressButton = UIBarButtonItem(customView: progressView)
        // Добавляет кнопку spacer, которая свигает отсальные кнопки к одному краю
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Добавляет кнопку refresh, которая будет перезагружать webView
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        // Добавляем обе кнопки в массив, этот массив идет по умолчанию в классе
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        
        }

    @objc func openTapped() {
        // alert controller
        let ac = UIAlertController(title: "Open page ...", message: nil, preferredStyle: .actionSheet)
        // actions for alert controller, choose to load apple or hackingwithswift or cancel with function openPage
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
//        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
//        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
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
    
    // Show observer value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        // Alert controller informs user not to visit websites that is not in list
        let ac = UIAlertController(title: "Warning!!!", message: "It is not allowed to visit websites that is Not in List!!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
        decisionHandler(.cancel)
    }

}


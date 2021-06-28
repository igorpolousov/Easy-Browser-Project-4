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
    
    // Запустили метод loadView
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
        
        }


}


//
//  DetailViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import WebKit

class DetailViewController: BaseViewController {
    

    

    var webID: String?

    let mainView = DetailView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
    
    override func configureUI() {
        
        guard let webID = webID else {
            return
        }
        let url = URL(string: webID)
        
        guard let url = url else {
            return
        }

        let request = URLRequest(url: url)
        mainView.webView.load(request)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let stopButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(stopButtonClicked))
        let gobackButton = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(gobackButtonClicked))
        let reloadButton = UIBarButtonItem(image: UIImage(systemName: "goforward"), style: .plain, target: self, action: #selector(reloadButtonClicked))
        let goFowardButton = UIBarButtonItem(image: UIImage(systemName: "greaterthan"), style: .plain, target: self, action: #selector(goFowardButtonClicked))
        
        let items: [UIBarButtonItem] = [stopButton, flexibleSpace, gobackButton, flexibleSpace, reloadButton, flexibleSpace, goFowardButton]
        mainView.toolBar.setItems(items, animated: true)
    }
    @objc func stopButtonClicked() {
        mainView.webView.stopLoading()
    }
    @objc func gobackButtonClicked() {
        if mainView.webView.canGoBack {
            mainView.webView.goBack()
        }
    }
    @objc func reloadButtonClicked() {
        mainView.webView.reload()
    }
    @objc func goFowardButtonClicked() {
        if mainView.webView.canGoForward {
            mainView.webView.goForward()
        }
    }
    

    @objc func leftBarButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        
    }
}

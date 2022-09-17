//
//  DetailView.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import Foundation

import WebKit

final class DetailView: BaseView {
    let webView: WKWebView = {
        let view = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        
        return view
    }()
    
    let toolBar: UIToolbar = {
        let view = UIToolbar()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [webView,toolBar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
        }
        
        toolBar.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(webView.snp.bottom)
        }
        
    }
}

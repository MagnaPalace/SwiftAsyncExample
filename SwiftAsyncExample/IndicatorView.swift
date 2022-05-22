//
//  IndicatorView.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/22.
//

import Foundation
import UIKit

class IndicatorView {
    
    static let shared = IndicatorView()
    
    private init() {}
    
    var grayOutView: UIView!
    
    func startIndicator() {
        // xcode15以降のwindow取得方法
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        guard let window = windowScenes?.windows.first else {
            return
        }
        grayOutView = UIView(frame: window.bounds)
        grayOutView.backgroundColor = .black
        grayOutView.alpha = 0.6
        
        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicatorView.center = grayOutView.center
        indicatorView.color = .white
        
        grayOutView.addSubview(indicatorView)
        
        window.addSubview(grayOutView)
        window.bringSubviewToFront(grayOutView)
        
        indicatorView.startAnimating()
    }
    
    func stopIndicator() {
        DispatchQueue.main.async{
            self.grayOutView.removeFromSuperview()
        }
    }
    
}

//
//  ViewController.swift
//  15lesson
//
//  Created by Владислав Пуцыкович on 5.12.21.
//
// Сделать универсальнее
// 

import UIKit

class ViewController: UIViewController {

    var views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newView = UIView()
        
        (0...7).forEach { xPos in
            (0...7).forEach { yPos in
                if xPos % 2 == 0 && yPos % 2 == 0 {
                    newView = UIView(frame: CGRect(x: xPos * 40, y: yPos * 40 + 120, width: 40, height: 40))
                    newView.backgroundColor = .black
                    newView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
                    views.append(newView)
                }
                if xPos % 2 != 0 && yPos % 2 != 0 {
                    newView = UIView(frame: CGRect(x: xPos * 40, y: yPos * 40 + 120, width: 40, height: 40))
                    newView.backgroundColor = .black
                    newView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
                    views.append(newView)
                }
                
            }
        }
        views.forEach { view in
            self.view.addSubview(view)
            print(view.frame)
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        let colors: [UIColor] = [.black, .orange, .green, .blue]
        let color = colors.randomElement()
        self.views.forEach { view in
            view.backgroundColor = color
        }
    }
}


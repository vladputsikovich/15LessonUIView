//
//  ViewController.swift
//  15lesson
//
//  Created by Владислав Пуцыкович on 5.12.21.
//

import UIKit

class ViewController: UIViewController {

    var views: [UIView] = []
    var figures: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printDeck({ x, y in
            appendView(x, y)
        })
        printDeck({ x, y in
            appendFigures(x, y)
        })
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
//        let colors: [UIColor] = [.black, .orange, .green, .blue]
//        let color = colors.randomElement()
//        self.views.forEach { view in
//            view.backgroundColor = color
//        }
        printDeck({ x, y in
            mixFigures(x, y)
        })
    }
    
    func printDeck(_ closure: (Int, Int) -> Void) {
        (0...7).forEach { xPos in
            (0...7).forEach { yPos in
                if xPos % 2 == 0 && yPos % 2 == 0 {
                    closure(xPos, yPos)
                }
                if xPos % 2 != 0 && yPos % 2 != 0 {
                    closure(xPos, yPos)
                }
            }
        }
    }
    
    func appendView(_ xPos: Int, _ yPos: Int) {
        let view = UIView(frame: CGRect(x: xPos * 40, y: yPos * 40 + 120, width: 40, height: 40))
        view.backgroundColor = .black
        view.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
        views.append(view)
        self.view.addSubview(view)
    }
    
    func appendFigures(_ xPos: Int, _ yPos: Int) {
        let view = UIView(frame: CGRect(x: xPos * 40 + 10, y: yPos * 40 + 130, width: 20, height: 20))
        if yPos < 3 {
            view.backgroundColor = .red
        }
        if yPos > 4 {
            view.backgroundColor = .white
        }
        view.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
        figures.append(view)
        self.view.addSubview(view)
    }
    
    func mixFigures(_ xPos: Int, _ yPos: Int) {
        guard let element = figures.randomElement() else {return}
        element.frame.origin.x = CGFloat(xPos * 40 + 10)
        element.frame.origin.y = CGFloat(yPos * 40 + 130)
    }
}


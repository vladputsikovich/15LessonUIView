//
//  ViewController.swift
//  15lesson
//
//  Created by Владислав Пуцыкович on 5.12.21.
//

import UIKit

fileprivate struct Constants {
    static let sideCount: CGFloat = 8
    static let half = 2
    static let countCell = 5
    static let cellSide = 20
    static let figureSide = 10
    static let upFigures = 3
    static let downFigures = 4
    static let countCells = 7
}

class ViewController: UIViewController {

    var views: [UIView] = []
    var figures: [UIView] = []
    
    var sideCell = 0
    var viewSecond = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideCell = Int(self.view.frame.width / Constants.sideCount)
        viewSecond = UIView(
            frame: CGRect(
                x: .zero,
                y: (self.view.bounds.height - self.view.bounds.width) / CGFloat(Constants.half),
                width: self.view.bounds.width,
                height: self.view.bounds.width
            )
        )
        viewSecond.autoresizingMask = [
            .flexibleRightMargin,
            .flexibleLeftMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin
        ]
        self.view.addSubview(viewSecond)
        
        printDeck({ x, y in
            appendView(x, y)
        })
        printDeck({ x, y in
            appendFigures(x, y)
        })
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        randomPosition(Constants.countCell)
    }
    
    func printDeck(_ closure: (Int, Int) -> Void) {
        (0...7).forEach { xPos in
            (0...7).forEach { yPos in
                if xPos % Constants.half == .zero && yPos % Constants.half == .zero {
                    closure(xPos, yPos)
                }
                if xPos % Constants.half != .zero && yPos % Constants.half != .zero {
                    closure(xPos, yPos)
                }
            }
        }
    }
    
    func appendView(_ xPos: Int, _ yPos: Int) {
        let view = UIView(
            frame: CGRect(
                x: xPos * sideCell,
                y: yPos * sideCell,
                width: sideCell,
                height: sideCell
            )
        )
        view.backgroundColor = .black
        view.autoresizingMask = [
            .flexibleRightMargin,
            .flexibleLeftMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin
        ]
        views.append(view)
        viewSecond.addSubview(view)
    }
    
    func appendFigures(_ xPos: Int, _ yPos: Int) {
        var view = UIView()
        if yPos < Constants.upFigures {
            view = UIView(
                frame: CGRect(
                    x: xPos * sideCell + Constants.figureSide,
                    y: yPos * sideCell + Constants.figureSide,
                    width: Constants.cellSide,
                    height: Constants.cellSide
                )
            )
            view.backgroundColor = .red
            view.autoresizingMask = [
                .flexibleRightMargin,
                .flexibleLeftMargin,
                .flexibleTopMargin,
                .flexibleBottomMargin,
                .flexibleHeight,
                .flexibleWidth
            ]
            figures.append(view)
            viewSecond.addSubview(view)
        }
        if yPos > Constants.downFigures {
            view = UIView(
                frame: CGRect(
                    x: xPos * sideCell + Constants.figureSide,
                    y: yPos * sideCell + Constants.figureSide,
                    width: Constants.cellSide,
                    height: Constants.cellSide
                )
            )
            view.backgroundColor = .blue
            view.autoresizingMask = [
                .flexibleRightMargin,
                .flexibleLeftMargin,
                .flexibleTopMargin,
                .flexibleBottomMargin,
                .flexibleHeight,
                .flexibleWidth
            ]
            figures.append(view)
            viewSecond.addSubview(view)
        }
    }
    
    func randomPosition(_ count: Int) {
        var newFigures = [UIView]()
        var success = true
        (0..<count).forEach { num in
            success = true
            while success {
                guard let figure = figures.randomElement() else { return }
                if !newFigures.contains(figure) {
                    newFigures.append(figure)
                    success = false
                }
            }
        }
        
        figures.forEach { figure in
            figure.removeFromSuperview()
        }
        
        var point = CGPoint()
        
        print(figures.count)
        
        newFigures.forEach { figure in
            point = getRandomPoint()
            for cell in newFigures {
                if cell.frame.origin == point {
                    point = getRandomPoint()
                    if cell.frame.origin == point {
                        point = getRandomPoint()
                        if cell.frame.origin == point {
                            point = getRandomPoint()
                        }
                    }
                }
            }
            print(point)
            figure.frame.origin = point
            viewSecond.addSubview(figure)
        }
    }
    
    func getRandomPoint() -> CGPoint {
        var x = Int.random(in: .zero...Constants.countCells)
        var y = Int.random(in: .zero...Constants.countCells)
        while true {
            if x % Constants.half == .zero && y % Constants.half == .zero {
                return CGPoint(
                    x: CGFloat(x * sideCell + Constants.cellSide),
                    y: CGFloat(y * sideCell + Constants.cellSide)
                )
            }
            if x % Constants.half != .zero && y % Constants.half != .zero {
                return CGPoint(
                    x: CGFloat(x * sideCell + Constants.cellSide),
                    y: CGFloat(y * sideCell + Constants.cellSide)
                )
            }
            x = Int.random(in: .zero...Constants.countCells)
            y = Int.random(in: .zero...Constants.countCells)
        }
        return CGPoint(x: x, y: y)
    }
}

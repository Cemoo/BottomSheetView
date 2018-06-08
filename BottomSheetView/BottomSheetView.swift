//
//  BottomSheetView.swift
//  BottomSheetView
//
//  Created by Erencan Evren on 8.06.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BottomSheetView: UIView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    
    public var bottomConstr: CGFloat? = 0
    public var beginPosition: CGPoint?
    
    override func awakeFromNib() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(BottomSheetView.handlePan(_:)))
        self.addGestureRecognizer(gesture)
        
        self.setNoteViewBottomCons()
        beginPosition = self.center
    }
    
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.changed {
            let translation = recognizer.translation(in: self)
            if let view = recognizer.view {
                if view.center.y > 0 {
                    view.center = CGPoint(x:view.center.x,
                                          y:view.center.y + translation.y)
                    
                    if self.center.y > view.center.y {
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            if let view = recognizer.view {
                                view.center = CGPoint(x:view.center.x,
                                                      y: self.center.y + 10)
                            }
                            recognizer.setTranslation(CGPoint.zero, in: self)
                        }, completion: nil)
                    }
                    
                }
                recognizer.setTranslation(CGPoint.zero, in: self)
            }
        } else if recognizer.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                if let view = recognizer.view {
                    let translation = recognizer.translation(in: self)
                    let velocity = recognizer.velocity(in: self)
                    if velocity.y < 0 {
                        view.center = CGPoint(x:view.center.x,
                                              y:view.center.y + translation.y - 40)
                    } else if velocity.y > 0 {
                        view.center = CGPoint(x:view.center.x,
                                              y:view.center.y + translation.y + 40)
                    }
                }
                recognizer.setTranslation(CGPoint.zero, in: self)
            }, completion: { result in
                if (recognizer.view?.center.y)! > (self.frame.height * 1.5) - 50 {
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                        if let view = recognizer.view {
                            view.center = self.beginPosition!
                        }
                        recognizer.setTranslation(CGPoint.zero, in: self)
                    }, completion: nil)
                }
                
            })
        }
        
    }
    
    func setNoteViewBottomCons() -> CGFloat {
        let value = (bottomConstr! * self.frame.height) / 667
        return value
    }
}

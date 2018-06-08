//
//  ViewController.swift
//  BottomSheetView
//
//  Created by Cemal Bayrı on 8.06.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var exampleView: BottomSheetView!
    
    override func viewWillAppear(_ animated: Bool) {
        exampleView.bottomConstr = self.bottomConstraint.constant
        exampleView.setNoteViewBottomCons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


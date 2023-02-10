//
//  TestViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 10/02/23.
//

import UIKit

class TestViewController: UIViewController {

    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLifecycle("viewDidLoad()", for: self.description)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLifecycle("viewWillAppear()", for: self.description)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLifecycle("viewDidAppear()", for: self.description)

        
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { Timer in
            self.showLoaderTwo()
        }
        
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { Timer in
            self.dissmisLoaderTwo()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showLifecycle("viewWillDisappear()", for: self.description)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.showLifecycle("viewDidDisappear()", for: self.description)
    }
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction
    
}



// MARK: - Public Func
extension Example_ViewController {
    
}

// MARK: - Private Func
extension Example_ViewController {
    
}

// MARK: - Services
extension Example_ViewController {
    
}

// MARK: - Other
extension Example_ViewController {
    
}

//
//  Example+ViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 02/02/23.
//

import UIKit

class Example_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        print("""
        /----------------------------------------------------------/
        /---                                                    ---/
        /---              Example_ViewController                ---/
        /---                     viewDidLoad()                  ---/
        /---                                                    ---/
        /----------------------------------------------------------/
        """)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("""
        /----------------------------------------------------------/
        /---                                                    ---/
        /---              Example_ViewController                ---/
        /---                  viewWillAppear()                  ---/
        /---                                                    ---/
        /----------------------------------------------------------/
        """)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("""
        /----------------------------------------------------------/
        /---                                                    ---/
        /---              Example_ViewController                ---/
        /---                   viewDidAppear()                  ---/
        /---                                                    ---/
        /----------------------------------------------------------/
        """)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("""
        /----------------------------------------------------------/
        /---                                                    ---/
        /---              Example_ViewController                ---/
        /---               viewWillDisappear()                  ---/
        /---                                                    ---/
        /----------------------------------------------------------/
        """)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("""
        /----------------------------------------------------------/
        /---                                                    ---/
        /---              Example_ViewController                ---/
        /---                viewDidDisappear()                  ---/
        /---                                                    ---/
        /----------------------------------------------------------/
        """)
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

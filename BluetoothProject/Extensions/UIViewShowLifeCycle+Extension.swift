//
//  UIViewShowLifeCycle+Extension.swift
//  BluetoothProject
//
//  Created by soliduSystem on 10/02/23.
//

import UIKit


extension UIViewController {
    public func showLifecycle(_ lifeCicle : String, for viewController : String) -> Void{
        print("""
        \n\n\n
        /----------------------------------------------------------/
        /---                                                    ---/
        /--- \(viewController)
        /--- \(lifeCicle)
        /---                                                    ---/
        /----------------------------------------------------------/
        """)
    }
}

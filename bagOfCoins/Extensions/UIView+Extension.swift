//
//  UIView+Extension.swift
//  bagOfCoins
//
//  Created by Daniel Hakimi on 02/10/2018.
//  Copyright © 2018 Daniel Hakimi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func create<T>(_ setup: ((T) -> Void)) -> T where T: NSObject {
        let obj = T()
        setup(obj)
        return obj
    }
}

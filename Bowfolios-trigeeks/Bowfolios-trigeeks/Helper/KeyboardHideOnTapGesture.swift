//
//  KeyboardHideOnTapGesture.swift
//  Bowfolios-trigeeks
//
//  Created by Tianhui Zhou on 9/24/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import Foundation
import SwiftUI

class HideKeyboardTapGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touchedView = touches.first?.view, touchedView is UIControl {
            state = .cancelled

        } else if let touchedView = touches.first?.view as? UITextView, touchedView.isEditable {
            state = .cancelled

        } else {
            state = .began
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}

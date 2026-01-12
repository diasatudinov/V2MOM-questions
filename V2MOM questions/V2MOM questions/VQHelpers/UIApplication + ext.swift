//
//  File.swift
//  V2MOM questions
//
//  Created by Dias Atudinov on 12.01.2026.
//


import UIKit
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }
}
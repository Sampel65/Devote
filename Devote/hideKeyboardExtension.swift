//
//  hideKeyboardExtension.swift
//  Devote
//
//  Created by Sampel on 07/04/2023.
//

import SwiftUI

#if canImport(UIKit)

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

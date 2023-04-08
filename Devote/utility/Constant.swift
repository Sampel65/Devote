//
//  Constant.swift
//  Devote
//
//  Created by Sampel on 06/04/2023.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


// MARK : UI

var backgroundGradient  : LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]) , startPoint: .topLeading, endPoint: .bottomTrailing)
}
// MARK UX

let feedback = UINotificationFeedbackGenerator()

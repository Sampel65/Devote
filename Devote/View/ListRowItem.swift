//
//  ListRowItem.swift
//  Devote
//
//  Created by Sampel on 07/04/2023.
//

import SwiftUI

struct ListRowItem: View {
    @Environment(\.managedObjectContext) var  viewContext
    @ObservedObject var item  : Item
    var body: some View {
        // TOGGLE
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12 )
                .animation(.default)
        }// : TOGGLE
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange, perform: { _ in 
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
    }
}



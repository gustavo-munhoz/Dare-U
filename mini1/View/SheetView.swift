//
//  SheetView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 22/06/23.
//

import SwiftUI; import UIKit

struct SheetView: View {
    @Binding var showSheetView: Bool
    @State private var isShare = false
    var view: ContentView

    var body: some View {
        Button(action: {
            isShare = true
        }) {
            Text("Share Me")
        }
        .background(SharingViewController(isPresenting: $isShare) {
            let av = UIActivityViewController(activityItems: [view.snapshot()], applicationActivities: nil)
            
            av.completionWithItemsHandler = { _, _, _, _ in
                isShare = false
            }
            
            return av
        })
    }
}

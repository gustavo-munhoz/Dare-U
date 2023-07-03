//
//  SheetView.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 22/06/23.
//

import SwiftUI; import UIKit

struct SheetView: View {
    @Binding var showSheetView: Bool
    @State private var isSharing = false
    var view: StoriesView

    var body: some View {
        Button(action: {
            isSharing = true
        }) {
            HStack {
                Image(systemName: "square.and.arrow.up")
                Text("Compartilhar")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 29)
            .foregroundColor(Color("AppGray03"))
            .font(.system(.headline))
            .padding(10)
            .background(Color("AppPink"))
            .cornerRadius(10)
        }
        .background(SharingViewController(isPresenting: $isSharing) {
            let renderer = ImageRenderer(content: Image("\(view.imageName)_\(view.level)").imageScale(.large))
            
            renderer.scale = UIScreen.main.scale
            
            let av = UIActivityViewController(activityItems: [renderer.uiImage!], applicationActivities: nil)
            
            av.completionWithItemsHandler = { _, _, _, _ in
                isSharing = false
            }
            
            return av
        })
    }
}

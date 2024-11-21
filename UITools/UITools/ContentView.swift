//
//  ContentView.swift
//  UITools
//
//  Created by zhoufei on 2024/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            FilterViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
        .padding()
    }
}


struct FilterViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FilterViewController {
        return FilterViewController.filterViewController()
    }
    
    func updateUIViewController(_ uiViewController: FilterViewController, context: Context) {
        // 在这里更新 UIViewController（如果需要）
    }
}


#Preview {
    ContentView()
}

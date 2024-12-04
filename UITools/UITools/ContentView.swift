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
//            FilterViewControllerRepresentable()
//                .edgesIgnoringSafeArea(.all)
            
//            SelectBarRepresentable()
//                .frame(width: 200, height: 44)
            
            RichTextViewControllerRepresentable()
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

struct RichTextViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RichTextViewController {
        return RichTextViewController.richTextViewController()
    }
    
    func updateUIViewController(_ uiViewController: RichTextViewController, context: Context) {
        // 在这里更新 UIViewController（如果需要）
    }
}




//View的转换
struct SelectBarRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> SelectBar {
        let bar = SelectBar.selectBar()
        bar.selectIndex = 0
        return bar
    }
    
    func updateUIView(_ uiView: SelectBar, context: Context) {
        uiView.configRedNum(leftNum: 10, rightNum: 200)
    }
}


#Preview {
    ContentView()
}

//
//  ContentView.swift
//  ImageTextHtmlTemplate
//
//  Created by zhoufei on 2024/11/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HtmlLabelViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}


struct HtmlLabelViewControllerRepresentable: UIViewControllerRepresentable {
      func makeUIViewController(context: Context) -> HtmlLabelViewController {
          return HtmlLabelViewController() // 创建并返回你的 UIViewController
      }

      func updateUIViewController(_ uiViewController: HtmlLabelViewController, context: Context) {
          // 在这里更新 UIViewController（如果需要）
      }
  }


//struct MapView: UIViewRepresentable {
//    let landmark: Landmark
//    func makeUIView(context: Context) -> MKMapView {
//        return MKMapView()
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        //地图中心点经纬度
//        let center = CLLocationCoordinate2DMake(39.9087243, 116.3952859)
//        //比例尺
//        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//        
//        uiView.setRegion(MKCoordinateRegion(center: landmark.locationCoordition, span: span), animated: true)
//    }
//}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(landmark: landmarks[0])
//    }
//}

#Preview {
    ContentView()
}

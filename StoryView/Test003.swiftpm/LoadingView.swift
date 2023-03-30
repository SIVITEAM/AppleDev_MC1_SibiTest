//
//  LoadingView.swift
//  Test003
//
//  Created by GYURI PARK on 2023/03/29.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var pageStatus:PageStatus
    @Binding var scores:[Double]
    
    
    let imageNames = ["001","002","003","004","005","006"]
    @State private var currentImageIndex = 0
    
    let rotationTime: Double = 0.5
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)
    
    @State var spinnerStart:CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var rotationDegreeS1 = initialDegree
    
    let animationTime: Double = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                Image(imageNames[currentImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
                        currentImageIndex = (currentImageIndex + 1) % imageNames.count
                    }
                ZStack {
                    LoadingViewCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: Color(0x24E7B0))
                }.frame(width: 250, height: 250)
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) {
                            (mainTimer) in self.animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }
                        }
                    }
            }
            Spacer().frame(height:80)
            
            Text("당신의 러너 캐릭터를")
                .fontWeight(.bold)
                .font(.system(size: 30))
            Spacer().frame(height: 10)
            Text("분석하고 있어요")
                .fontWeight(.bold)
                .font(.system(size: 30))
            
            Spacer().frame(height: 30)
            
            //            ZStack {
            //                LoadingViewCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: Color(0x24E7B0))
            //            }.frame(width: 50, height: 50)
            //                .onAppear() {
            //                    Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) {
            //                        (mainTimer) in self.animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }
            //                    }
            //                }
            Spacer()
            
//            Button(
//                action: {
//                    print(scores)
//                    pageStatus = .MAIN
//                    scores = [0.0,0.0,0.0,0.0,0.0,0.0]
//                }){Text("메인으로 돌아가기")
//                        .underline()
//                        .foregroundColor(Color(0x24E7B0))
//                }
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                if let maxIndex = scores.firstIndex(where: { $0 == scores.max() }) {
                    print("The index of the maximum value is \(maxIndex)")
                    switch maxIndex {
                    case 0:
                        pageStatus = .RESULTPETER
                    case 1:
                        pageStatus = .RESULTKIHYUN
                    case 2:
                        pageStatus = .RESULTTAMRA
                    case 3:
                        pageStatus = .RESULTKIHYUN
                    case 4:
                        pageStatus = .RESULTDANA
                    case 5:
                        pageStatus = .RESULTRIN
                    default :
                        pageStatus = .RESULTPETER
                    }
                }
            }
        }
    }
    
    func animateSpinner(with timeInterval: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: rotationTime)) {
                completion()
            }
        }
    }
}

struct LoadingViewCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

struct LoadingView_Previews: PreviewProvider {
    @State static var pageStatus : PageStatus = .STORY
    @State static var scores : [Double] = [0,0,0,0,0,0]
    static var previews: some View {
        LoadingView(pageStatus: $pageStatus,scores: $scores)
    }
}
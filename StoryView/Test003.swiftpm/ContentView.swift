import SwiftUI

// 컴포넌트를 많이 써본다.
struct ContentView: View {
    @State var pageStatus = PageStatus.MAIN
    @State var scores: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0] //피터, 기현, 탐라, 린, 다나, 도리스 순 
    var body: some View {
        // 버티컬리하게 쪼갠다.
        VStack {
            if pageStatus == .PREREPORT {
                LoadingView(pageStatus: $pageStatus, scores: $scores)
            } else if pageStatus == .MAIN{
                MainView(pageStatus: $pageStatus)
            } else if pageStatus == .STORY{
                StoryView(pageStatus: $pageStatus, scores: $scores)
            } else if pageStatus == .RESULTDANA{
                ResultViewDANA(pageStatus: $pageStatus, scores: $scores)
            }  else if pageStatus == .RESULTDORIS{
                ResultViewDORIS(pageStatus: $pageStatus, scores: $scores)
            }  else if pageStatus == .RESULTKIHYUN{
                ResultViewKIHYUN(pageStatus: $pageStatus, scores: $scores)
            }  else if pageStatus == .RESULTRIN{
                ResultViewRIN(pageStatus: $pageStatus, scores: $scores)
            }  else if pageStatus == .RESULTTAMRA{
                ResultViewTAMRA(pageStatus: $pageStatus, scores: $scores)
            }  else if pageStatus == .RESULTPETER{
                ResultViewPETER(pageStatus: $pageStatus, scores: $scores)
            } else {
                MainView(pageStatus: $pageStatus)
            }
        }.padding()
    }
}

// 컨텐트뷰_프리뷰
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

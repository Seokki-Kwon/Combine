import UIKit
import Combine

let timeoutSubject = PassthroughSubject<String, Never>()
var cancellables = Set<AnyCancellable>()

//DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//    timeoutSubject.send("after 1 seconds")
//}

DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
    timeoutSubject.send("after 2 seconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
    timeoutSubject.send("after 3 seconds")
}

// 1초동안 요소를 생성하지 않는경우 게시를 종료
// 2초부터 이벤트를 방출하기 때문에 스트림이 종료됨
timeoutSubject
    .timeout(1, scheduler: DispatchQueue.main)
    .sink(receiveValue: {str in
        print(str)
    })
    .store(in: &cancellables)

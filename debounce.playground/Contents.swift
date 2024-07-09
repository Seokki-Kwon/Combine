import UIKit
import Combine

// debounce
// 이벤트 간에 지정된 시간 간격이 경과한 후에만 요소를 게시
// 다운스트림에 전달되는 값의 수를 지정한 비율로 줄여야 하는 경우
var cancellables = Set<AnyCancellable>()

//let debounceSubject = PassthroughSubject<String, Never>()
//
//DispatchQueue.global().asyncAfter(deadline: .now()) {
//    debounceSubject.send("after 0 seconds")
//}
//
//DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//    debounceSubject.send("after 1 seconds")
//}
//
//DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
//    debounceSubject.send("after 2 seconds")
//}
//
//debounceSubject
//    .debounce(for: 1, scheduler: DispatchQueue.main)
//    .sink(receiveValue: { str in
//        print(str)
//    })
//    .store(in: &cancellables)

// throttle
// 지정된 시간간격 내에 게시자가 게시한 최신 또는 첫번째 요소를 게시

let throttleSubject = PassthroughSubject<String, Never>()

DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    throttleSubject.send("after 1 senconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
    throttleSubject.send("after 2 senconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
    throttleSubject.send("after 3 senconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
    throttleSubject.send("after 4 senconds")
}

DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
    throttleSubject.send("after 5 senconds")
}

// latest
// false -> 1 -> 10초동안 방출x -> 2(간격동안 수신된 첫번째값)
// true -> 1 -> 10초동안 방출x -> 5(간격동안 수신된 최신값)
throttleSubject
    .throttle(for: 10, scheduler: DispatchQueue.main, latest: false)
    .sink(receiveValue: { str in
        print(str)
    })
    .store(in: &cancellables)

// debounce는 시간이 경과하고 최신값을 방출
// throttle은 시간동안 방출된 첫번째값 또는 최신값을 선택해서 방출가능

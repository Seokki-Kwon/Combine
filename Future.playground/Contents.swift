import UIKit
import Combine

// Future
// 값을 생성하고 완료하거나 실패하는 퍼블리셔
// RxSwift의 Observable.create 같은 개념?
func futureIncrenment(integer: Int, afterDelay delay: TimeInterval) -> Future<Int, Never> {
    // Promise는 ResultType, Error를 전달하는 클로저
    Future<Int, Never> { promise in
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
           promise(.success(integer + 1))
         }
    }
}



let future = futureIncrenment(integer: 1, afterDelay: 3)

future
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .cancel()


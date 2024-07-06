import UIKit
import Combine

// eraseToAnyPublisher를 사용하지 않는경우 옵셔널로 전달
["A", nil, "C"].publisher
    .eraseToAnyPublisher()
    .replaceNil(with: "-")
    .sink(receiveValue: { print($0) })

// replaceEmpty
// Empty 즉시 빈값을 방출하는 퍼블리셔
// 작업의 완료를 알리거나 테스트할때 사용
let empty = Empty<Int, Never>()

empty
    // 완료되기전에 1을 방출
    .replaceEmpty(with: 1)
    .sink(receiveValue: { print($0) })


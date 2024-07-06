import UIKit
import Combine

// map
let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

[123, 4, 56].publisher
    .map {
        formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
    }
    .sink(receiveValue: { print($0) })
    .cancel()

struct Test {
    let x: Int
    let y: Int
}

let publisher = PassthroughSubject<Test, Never>()

// keyPath 사용
publisher
    .map(\.x, \.y)
    .sink(receiveValue: { x, y in
        print("\(x), \(y)")
    })

publisher.send(Test(x: 10, y: 2))
publisher.send(Test(x: 2, y: 4))

// tryMap
// 오류를 throw하면 다운스트림에서 오류를 방출

Just("Directory name that does not exist")
    .tryMap { try FileManager.default.contentsOfDirectory(atPath: $0) }
    .sink(receiveCompletion: { print($0) },
          receiveValue:  { print($0) })

// flatMap

func decode(_ codes: [Int]) -> AnyPublisher<String, Never> {
    Just(
    codes
        .compactMap { code in
            guard (32...255).contains(code) else { return nil }
            return String(UnicodeScalar(code) ?? " ")
        }
        .joined()
    )
    .eraseToAnyPublisher()
}

[72, 101, 108, 108, 111, 44, 32, 87, 111, 114, 108, 100, 33]
  .publisher
  .collect()
  .flatMap(decode)
  .sink(receiveValue: { print($0) })


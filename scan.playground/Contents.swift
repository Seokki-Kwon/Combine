import UIKit
import Combine

var dailyGainLoss: Int { .random(in: -10...10)}

let august2019 = (0..<22)
    .map { _ in dailyGainLoss }
    .publisher

august2019
// 시작값을 50으로 설정
// 이전갑과 현재값을 더한 새로운 값을 방출
    .scan(50) { latest, current in
            max(0, latest + current)
    }
    .sink(receiveValue: { _ in })

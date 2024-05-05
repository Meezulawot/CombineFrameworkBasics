import UIKit
import Combine

var subscription = Set<AnyCancellable>()

example(of: "NotificationCenter"){
    let center = NotificationCenter.default
    let myNotification = Notification.Name("myNotification")
    
    let publisher = center
        .publisher(for: myNotification, object: nil)
        
    
    let subscription = publisher
        .print()
        .sink{_ in
            print("Notification received from publisher")
        }
        
    
    center.post(name: myNotification, object: nil)
    subscription.cancel()
}
 

example(of: "Just"){
    let just = Just("Hello World")
    
    just.sink(
        receiveCompletion: {_ in
        print("Received completion")
    }, receiveValue: {
        print("Receive value:", $0)
    })
    .store(in: &subscription)
}


example(of: "assign(to: on:)"){
    class SomeObject {
        var value: String = "" {
            didSet{
                print(value)
            }
        }
    }
    
    let object = SomeObject()
    
    ["Hello", "World"].publisher
        .assign(to: \.value, on: object)
        .store(in: &subscription)
}


example(of: "PassthroughSubject"){
    let subject = PassthroughSubject<String, Never>()
    
    subject
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
    
    subject.send("Hello")
    subject.send("World")
    subject.send(completion: .finished)
    subject.send("Still there?")
}


example(of: "CurrentValueSubject"){
    let subject = CurrentValueSubject<Int, Never>(0)
    
    subject
        .print()
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
    
    print(subject.value)
    
    subject.send(1)
    subject.send(2)
    
    print(subject.value)
    subject.send(completion: .finished)
}


example(of:"Type erasure"){
    let subject = PassthroughSubject<Int, Never>()
    
    let publisher = subject.eraseToAnyPublisher()
    
    publisher
        .print()
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
    
    subject.send(0)
}


example(of: "collect"){
    ["A", "B", "C", "D", "E"].publisher
        .collect(2)
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
}


example(of: "map"){
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    [123,4,56].publisher
        .print()
        .map{
            formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
        }
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
}


example(of: "replacingNil"){
    ["Test",nil,"Something"].publisher
        .replaceNil(with: "-")
        .map{$0!}
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
}

example(of: "replacingEmpty"){
    let empty = Empty<Int, Never>()
    
    empty
        .replaceEmpty(with: 1)
        .sink(receiveValue: {print($0)})
        .store(in: &subscription)
}


example(of: "scan"){
    var dailyGainLoss: Int{ .random(in: -10...10)}
    
    let august2019 = (0..<22)
        .map{_ in
            dailyGainLoss
        }
        .publisher
    
    august2019
        .scan(50) {latest, current in
            max(0, latest + current)
        }
        .sink(receiveValue: {_ in})
        .store(in: &subscription)
}


example(of: "flatmap"){
    let charlotte = Chatter(name: "Charlotte", message: "Hi I am charlotte")
    let james = Chatter(name: "James", message: "Hi I am James")
    
    let chat = CurrentValueSubject<Chatter, Never>(charlotte)
    
    chat
        .sink(receiveValue: {print($0.message.value)})
        .store(in: &subscription)
    
}

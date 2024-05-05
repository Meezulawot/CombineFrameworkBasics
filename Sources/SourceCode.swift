import Foundation
import Combine

public func example(of description: String, action: ()-> Void){
    print("\n------------Example of :", description, "-------------")
    action()
}


public struct Chatter {
  public let name: String
  public let message: CurrentValueSubject<String, Never>
  
  public init(name: String, message: String) {
    self.name = name
    self.message = CurrentValueSubject(message)
  }
}

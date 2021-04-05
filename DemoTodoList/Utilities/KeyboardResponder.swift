//
//  KeyboardResponder.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import SwiftUI
import Combine

protocol KeyboardResponderProtocol {
  var currentHeight: CGFloat { get }
  var duration: TimeInterval { get }
}

final class KeyboardResponder: KeyboardResponderProtocol, ObservableObject {
  @Published private(set) var currentHeight: CGFloat = 0
  private(set) var duration: TimeInterval = 0.3
  private var cancellableBag = Set<AnyCancellable>()
  
  init() {
    let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
    
    Publishers.Merge(keyboardWillShow, keyboardWillHide)
      .receive(on: RunLoop.main)
      .sink { [weak self] in self?.keyboardNotification($0)}
      .store(in: &cancellableBag)
  }
  
  private func keyboardNotification(_ notification: Notification) {
    let isShowing = notification.name == UIResponder.keyboardWillHideNotification
    if let userInfo = notification.userInfo {
      duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      if isShowing {
        currentHeight = endFrame?.height ?? 0
      } else {
        currentHeight = 0
      }
    }
  }
}

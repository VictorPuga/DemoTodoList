//
//  NewTodoView.swift
//  DemoTodoList
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import SwiftUI

struct NewTodoView: View {
  // MARK: - Properties
  @ObservedObject var viewModel: NewTodoViewModel
  @ObservedObject var keyboard = KeyboardResponder()
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  @State private var title = ""
  
  private var isAddButtonDisabled: Bool { title.isEmpty }
  private var addButtonColor: Color { isAddButtonDisabled ? .gray : .blue }
  
  // MARK: - Body
  var body: some View {
    VStack {
      Spacer()
      TextField("Name", text: $title)
      Spacer()
      HStack {
        Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }
        .padding(.vertical, 16)
        .frame(minWidth: 0, maxWidth: .infinity)
        
        Button("Add") {
          if !isAddButtonDisabled {
            viewModel.addNewTodo(title: title)
            presentationMode.wrappedValue.dismiss()
          }
        }
        .foregroundColor(.black)
        .padding(.vertical, 16)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(addButtonColor)
        .disabled(isAddButtonDisabled)
      }
    }
    .padding()
    .padding(.bottom, keyboard.currentHeight)
    .animation(.easeOut(duration: keyboard.duration))
  }
}

// MARK: - Preview
struct NewTodoView_Previews: PreviewProvider {
  static var previews: some View {
    NewTodoView(viewModel: NewTodoViewModel())
  }
}

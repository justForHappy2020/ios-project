//样式
import SwiftUI

let lightGreyColor = Color(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, opacity: 0.8)

let bgColor = Color(red: 88.0/255.0, green: 79.0/255.0, blue: 97.0/255.0, opacity: 1.0)

let boldGreyColor = Color(red: 187.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, opacity: 1.0)

let bgGrey = Color(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, opacity: 1)

let lightGreenColor = Color(red: 37.0/255.0, green: 198.0/255.0, blue: 137.0/255.0, opacity: 0.5)

let boldGreenColor = Color(red: 37.0/255.0, green: 198.0/255.0, blue: 137.0/255.0, opacity: 1.0)

struct AboutHeadingStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .padding(.bottom, 5)
  }
}

struct AboutDescStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 16))
      .foregroundColor(boldGreyColor)
      .padding(.bottom, 28)
  }
}

struct IptStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .background(lightGreyColor)
            .cornerRadius(30.0)
            .padding(.bottom,30)
            .foregroundColor(Color.white)
    }
}

struct IptNotRadius: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.bottom,30)
            .foregroundColor(Color.white)
    }
}


struct ButtonRadius: ViewModifier{
    func body(content: Content) -> some View {
        content
            .cornerRadius(30.0)
    }
}

struct ButtonStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .foregroundColor(Color.white)
    }
}

struct ActiveButton: ViewModifier{
    func body(content: Content) -> some View {
        content
            .modifier(ButtonStyle())
            .background(boldGreyColor)
            .modifier(ButtonRadius())
    }
}

struct InactiveButton: ViewModifier{
    func body(content: Content) -> some View {
        content
            .modifier(ButtonStyle())
            .background(lightGreenColor)
            .modifier(ButtonRadius())
    }
}


//被选中的性别样式
struct SelectSex: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lightGreenColor, lineWidth: 5)
            )
    }
}

struct emptyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}


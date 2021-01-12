import SwiftUI

struct Search: View {
    @State private var searchText = ""
    @State private var selectTag = ""
    @State private var showCancelButton: Bool = false
    @State private var isActive:Bool = false
    @State private var showHistory: Bool = true
    
    var body: some View {
//       NavigationView {
            VStack {
                if !showCancelButton{
                    HStack{
                        Text("搜索")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical,5)
                }
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            setSearchTextToLocal(searchText: searchText)
                            print("commit")
                        }).foregroundColor(.primary)
                            
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)

                    if showCancelButton  {
                        Button("取消") {
                                UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                self.searchText = ""
                                self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
//                .navigationBarHidden(showCancelButton)
//                .navigationBarTitle(Text("搜索"))
                .resignKeyboardOnDragGesture()
                
                if showCancelButton && !searchText.isEmpty{
                    SearchResult(searchText: searchText)
                }
                
                if showHistory && !showCancelButton{
                    SearchHistoryView(searchText: Binding(
                        get: { self.selectTag },
                        set: {
                            self.searchText = $0
                            self.showCancelButton = true
                        }
                    ))
                }
                Spacer()
            }.frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)

//        }
    }
}



struct Search_preview: PreviewProvider {
    static var previews: some View {
        Search()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}


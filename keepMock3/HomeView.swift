//
//  Tabs.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2021/1/7.
//

import SwiftUI
import BottomBar_SwiftUI

let items: [BottomBarItem] = [
    BottomBarItem(icon: "house.fill", title: "Home", color: .purple),
    BottomBarItem(icon: "heart", title: "Likes", color: .pink),
    BottomBarItem(icon: "magnifyingglass", title: "Search", color: .orange),
    BottomBarItem(icon: "person.fill", title: "Profile", color: .blue)
]

struct BasicView:View{
    let idx: Int
    
    var body: some View{
        VStack{
            switch idx {
                case 0:
                    Train()
                case 1:
                    ExploreView()
                case 2:
                    UserView()
                case 3:
                    SettingsView()
                default:
                    EmptyView()
            }
        }
    }
}

struct HomeView: View {
    @State private var selectedIndex: Int = 0
    
    var selectedItem: BottomBarItem {
        items[selectedIndex]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //切换view
                BasicView(idx: selectedIndex)
                BottomBar(selectedIndex: $selectedIndex, items: items)
            }
        }
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

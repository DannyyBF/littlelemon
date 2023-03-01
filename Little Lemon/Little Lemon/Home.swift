//
//  Home.swift
//  Little Lemon
//
//  Created by Danny on 14/02/2023.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    var body: some View {
//        LittleLemonLogo()
//        LittleLemonBlurb()
        TabView{
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
            UserProfile()
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// green = 495e57 (red 73, green 94, blue 87
// yellow = f4ce14

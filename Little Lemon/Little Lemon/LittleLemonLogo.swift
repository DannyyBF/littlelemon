//
//  LittleLemonLogo.swift
//  Little Lemon Reservation App
//
//  Created by Danny on 01/12/2022.
//

import SwiftUI

struct LittleLemonLogo: View {
    var body: some View {
        HStack {
            Image("littleLemon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 40)
            Spacer(minLength: 80)
            Image("Photo")
                .resizable()
                .scaledToFit()
                .frame(width: 50.0, height: 50.0)
                .clipShape(Circle())
        }.padding([.leading,.trailing], 20)
    }
}

struct LittleLemonLogo_Previews: PreviewProvider {
    static var previews: some View {
        LittleLemonLogo()
    }
}

//
//  LittleLemonBlurb.swift
//  Little Lemon
//
//  Created by Danny on 27/02/2023.
//

import SwiftUI

struct LittleLemonBlurb: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Little Lemon")
                .font(Font.custom("Cambria", size: 33))
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color("myColorYellow"))
                .padding(.top)
            HStack {
                VStack (alignment: .leading, spacing: 1) {
                    Text("Chicago")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom)
                    Text("We are a family owned Mditerranean restaurant, focused on traditonal recipes served with a modern twist.")
                        .font(.body)
                        .foregroundColor(.white)
                }
                Image("llim")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                    .cornerRadius(20)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(Color ("myColorGreen"))
    }
}

struct LittleLemonBlurb_Previews: PreviewProvider {
    static var previews: some View {
        LittleLemonBlurb()
    }
}

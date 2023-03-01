//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Danny on 14/02/2023.
//

import SwiftUI

struct UserProfile: View {
    @State var firstName = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    @State var isProfile = true

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack (alignment:.leading, spacing: 0){
            LittleLemonLogo()
            Text("Personal Information")
                .fontWeight(.bold)
                .font(.title)
            Text( "Avatar" )
                .foregroundColor(.gray)
            HStack {
                Image("Photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.trailing, 20)
                Button( "Change" ) {
                    
                }
                .buttonStyle(.bordered)
                .background(Color("myColorGreen"))
                .foregroundColor(.white)
                Button( "Remove" ) {
                    
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }.padding()
            VStack (alignment: .leading){
                Text("First Name")
                TextField( "First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                Text("Last Name")
                TextField( "Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                Text("Email")
                TextField( "Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
            }
            HStack (alignment: .center) {
                Button( "Logout", action: {
                    UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                })
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                Button( "Sim Restart App", action: {
                    UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                })
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }.frame(minWidth: 0, maxWidth: .infinity)
            Spacer()
        }
        .padding(.leading)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Danny on 14/02/2023.
//

import SwiftUI

let keyFirstName = "first name key"
let keyLastName = "last name key"
let keyEmail = "email key"
let keyIsLoggedIn = "logged in key"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    var body: some View {
        if isLoggedIn == false {
            Image("littleLemon")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            LittleLemonBlurb()
                .padding(.bottom)
        }
        NavigationView {
            VStack {
                VStack (alignment: .leading, spacing: 0) {
                    Text("First Name*")
                    TextField( "First Name", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                    Text("Last Name*")
                    TextField( "Last Name", text: $lastName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                    Text("Email*")
                    TextField( "Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                    HStack{
                        Spacer(minLength: 150)
                        NavigationLink( destination: Home(), isActive: $isLoggedIn) {
                            Button( "Register", action: {
                                if firstName.isEmpty == false && lastName.isEmpty == false && email.isEmpty == false {
                                    UserDefaults.standard.set( firstName, forKey: keyFirstName)
                                    UserDefaults.standard.set( lastName, forKey: keyLastName)
                                    UserDefaults.standard.set( email, forKey: keyEmail)
                                    UserDefaults.standard.set( isLoggedIn, forKey: keyIsLoggedIn)
                                    // optional later add check for valid email
                                    isLoggedIn = true
                                }
                            })
                            .buttonStyle(.bordered)
                            .foregroundColor(.black)
                            Spacer()
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onAppear {
                    if UserDefaults.standard.bool(forKey: keyIsLoggedIn) {
                        isLoggedIn = true
                    } else {
                        firstName = ""
                        lastName = ""
                        email = ""
                    }
                }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

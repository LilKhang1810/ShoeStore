//
//  LoginView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 03/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel : AuthencationController
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            ZStack{
               Image("loginbg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack {
                        NeumorphicStyleTextField{TextField("Email", text: $email).foregroundColor(.black)}
                        NeumorphicStyleTextField{SecureField("Password", text: $password).foregroundColor(.black)}
                    }
                    .padding(.horizontal)
                    .padding(.top,30)
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(.black)
                            .cornerRadius(20)
                    })
                    .padding(.top,30)
                    HStack{
                        NavigationLink(destination: SignUpView()) {
                            Text("Forget password")
                                .foregroundColor(.black)
                                .underline()
                        }
                        Spacer()
                        NavigationLink(destination: SignUpView()) {
                            Text("New User?")
                                .foregroundColor(.black)
                                .underline()
                        }
                    }
                    .padding(.horizontal,10)
                    .padding(.top,30)
                    VStack{
                        VStack{Text("--Continue with--")}
                            .padding()
                        HStack(spacing:30){
                            NavigationLink(destination: Text("Continue with facebook")) {
                                Image("facebook_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50,height: 50)
                            }
                            NavigationLink(destination: Text("Continue with google")) {
                                Image("google_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60,height: 60)
                            }

                            NavigationLink(destination: Text("Continue with apple")) {
                                Image("apple_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50,height: 50)
                            }
                        }
                    }
                    .offset(y:50)
                }
                .frame(width: 350,height: 700,alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                (Text("Welcome to ") +
                 Text("SNEAKER").underline() + Text(" world")).font(.system(size: 40).bold())
                    .offset(y:-270)
                    
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthencationController())
    }
}
struct SignUpView: View {
    @StateObject var registerVM = RegisterViewModel()
    @EnvironmentObject var viewModel : AuthencationController
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image("signup")
                .resizable()
                .frame(height: .infinity)
                .edgesIgnoringSafeArea(.all)
                
            VStack{
                Spacer(minLength: 200)
                NeumorphicStyleTextField{
                    TextField("Name", text: $registerVM.name)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                NeumorphicStyleTextField{
                    TextField("Email", text: $registerVM.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                NeumorphicStyleTextField{
                    SecureField("Password", text: $registerVM.password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                HStack{
                    Button(action: {dismiss()}, label: {
                        Text("Already has an account")
                            .foregroundColor(.black)
                            .underline()
                    })
                }
                .frame(width: 350)
                .padding(.trailing,130)
                .padding(.top,40)
                .padding(.bottom,40)
                Button(action: {
                    registerVM.register()
                }, label: {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(.black)
                        .cornerRadius(20)
                })
                Spacer()
            }
            .frame(width: 350,height: 600,alignment: .center)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .padding()
            (Text("Create ") +
             Text("SNEAKER").underline() + Text(" passport")).font(.system(size: 40).bold())
                .offset(y:-220)
        }
        .navigationBarBackButtonHidden(true)
    }
}


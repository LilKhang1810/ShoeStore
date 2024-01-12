//
//  CheckoutView.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 30/12/2023.
//

import SwiftUI

struct CheckoutView: View {
    let totalAmount: Double
    @State var nameTextField: String = ""
    @State var addressTextField: String = ""
    @State var emailTextField: String = ""
    @State var postcodeTextField: String = ""
    @State var hasRead: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment: .leading){
                    Divider()
                    HStack{
                        Text("Summary")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(String(totalAmount) + "$")
                            .font(.system(size: 20))
                            .bold()
                    }
                    Divider()
                    Text("How would you like to get your order?")
                        .font(.system(size:20))
                        .bold()
                    ZStack{
                        HStack{
                            Image(systemName: "shippingbox.fill")
                                .font(.system(size: 25))
                            Text("Deliver it")
                                .font(.system(size: 20))
                                .bold()
                            Spacer()
                        }
                        .padding(25)
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .frame(width:350,height: 70)
                    }
                    Text("Enter your name and address")
                        .font(.system(size: 20))
                        .bold()
                    Group{
                        NeumorphicStyleTextField{TextField("Name", text: $nameTextField)}
                        NeumorphicStyleTextField{TextField("Address", text: $addressTextField)}
                        NeumorphicStyleTextField{TextField("Email", text: $emailTextField)}
                        NeumorphicStyleTextField{TextField("Postcode", text: $postcodeTextField)}
                    }
                    .padding(10)
                    Toggle(isOn: $hasRead) {
                        Text("I have read the policy")
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(10)
                    NavigationLink(destination: {SuccessCheckoutView()}) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .frame(width: 150,height: 50)
                            .background(.black)
                            .cornerRadius(20)
                    }
                    .padding(.leading,120)
                }
                .padding(.horizontal,10)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("left")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }

    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(totalAmount: 2000000)
    }
}

struct NeumorphicStyleTextField<Content>: View where Content: View {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack {
            content()
        }
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .padding()
        .foregroundColor(.neumorphictextColor)
        .background(Color.background)
        .cornerRadius(6)
        .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
        .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}
extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}

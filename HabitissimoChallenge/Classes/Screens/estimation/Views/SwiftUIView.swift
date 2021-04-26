//
//  SwiftUIView.swift
//  HabitissimoChallenge
//
//  Created by Arturo Dominguez Sanchez on 17/04/2021.
//  Copyright © 2021 Arturo Dominguez Sanchez. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var locationsArray = [LocationModel]()

    
    @State var name: String = ""
    @State var emailAddress: String = ""
    @State var phone: String = ""
    
    @State var text = ""
    @State var textHeight: CGFloat = 150

    @State var location = 1
    @State var category = 1
    @State var subcategory = 1

    @State var submit = false

    var body: some View {
        
        
//        GeometryReader { geometry in
//            VStack (alignment: .center){
//                HStack {
//                    Image("2")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    Text("Social App")
//                        .font(.system(size: 12))
//
//                }
        NavigationView{
            Form{
                Section(header: Text("Nombre")) {
                    TextField("Tu nombre", text: self.$name)
                                .textContentType(.name)
                                .accentColor(.red)
                                .cornerRadius(5)
                }
                Section(header: Text("Correo electrónico")) {
                    TextField("Tu correo electrónico", text: self.$emailAddress)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .cornerRadius(5)
                }
                Section(header: Text("Teléfono de contacto")) {
                    TextField("Tu teléfono", text: self.$phone)
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)
                            .accentColor(.red)
                            .cornerRadius(5)
                }
                Section(header: Text("Descripción")) {
                    ScrollView {
                        TextView(placeholder: "Escribe una descripción de lo que quieres hacer. Cuanto más detallada sea la descripción, más preciso será el presupuesto obtenido. ", text: self.$text, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    }
                }
                Picker(selection: self.$location, label: Text("Localización")) {
                    Text(LOCATION_CONSTANT[0].name).tag(1)
                    Text(LOCATION_CONSTANT[1].name).tag(2)
                    Text(LOCATION_CONSTANT[2].name).tag(3)
                    Text(LOCATION_CONSTANT[3].name).tag(4)

                }
                Picker(selection: self.$category, label: Text("Categoria")) {
                    Text("Reformas").tag(1)
                    Text("Mudanzas").tag(2)
                    Text("Demoliciones").tag(3)
                }
                Picker(selection: self.$subcategory, label: Text("Subcategoría")) {
                    Text("Reformas casas").tag(1)
                    Text("Reformas piscinas").tag(2)
                    Text("Reformas muros").tag(3)
                }
                Spacer()
                
                Button(action: {
                    self.submit.toggle()
                }) {
                    HStack(alignment: .center) {
                        Text("Enviar")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color(color1))
                    .cornerRadius(5)
                }
            }
            .navigationBarTitle("Solicitar presupuesto")
        }.onAppear(perform: loadLocations)
            
    }
    
    func loadLocations() {
        LocationRequest().getLocations { (location) in
            self.locationsArray = location
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
    


struct TextView: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String

    var minHeight: CGFloat
    @Binding var calculatedHeight: CGFloat

    init(placeholder: String, text: Binding<String>, minHeight: CGFloat, calculatedHeight: Binding<CGFloat>) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
        self._calculatedHeight = calculatedHeight
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator

        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
//        textView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        // Set the placeholder
        textView.text = placeholder
        textView.textColor = UIColor.lightGray

        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text == self.placeholder {
            textView.text = placeholder
        } else{
            textView.text = self.text
        }
        

        recalculateHeight(view: textView)
    }

    func recalculateHeight(view: UIView) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
            }
        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
            }
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textViewDidChange(_ textView: UITextView) {
            // This is needed for multistage text input (eg. Chinese, Japanese)
            if textView.markedTextRange == nil {
                parent.text = textView.text ?? String()
                parent.recalculateHeight(view: textView)
            }
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.lightGray
            }
        }
    }
}

import SwiftUI

struct SettingsView: View {
    @State var showPopup = false
    @State var pressedButton = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false


    

    @State private var showingGame = false
    @State var showAlert:Bool = false
    @State var showstuff = false
    @EnvironmentObject var model: Model
    
    var color: Color = .black
    
    var body: some View {
            ScrollView{
                
                HStack{
                    VStack{
                        HStack(spacing: 1){
                            Image(systemName: "gearshape").font(.system(size: CGFloat(model.fontSize + 4)))
                            .fontWeight(.bold)
                            
                            Text("General Settings")
                            .font(.system(size: CGFloat(model.fontSize + 4)))
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Button(action: {
                            pressedButton.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                                pressedButton.toggle()
                            }
                            showAlert.toggle()
                        }
                        ) {
                            Text("Clear User Data")
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.bordered)
                        .font(.system(size: CGFloat(model.fontSize)))
                        .buttonBorderShape(.automatic)
                        .padding(.vertical, 10)
                        .scaleEffect(pressedButton ? 0.9 : 1)
                        .animation(.spring(response: 0.1, dampingFraction: 2), value: pressedButton)
                    }
                    Spacer()
                }
                .padding(20)
                .background(color.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous), style: FillStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                
                
                HStack{
                    VStack{
                        HStack(spacing: 1){
                            Image(systemName: "textformat.abc.dottedunderline").font(.system(size: CGFloat(model.fontSize + 4)))
                            .fontWeight(.bold)
                            
                            Text("Text Size")
                            .font(.system(size: CGFloat(model.fontSize + 4)))
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                            Slider(value: $model.fontSize, in: 12...36, step: 1)
                                            .padding()
                        
                    }
                    Spacer()
                }
                .padding(20)
                .background(color.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous), style: FillStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure??"), message: Text("All user data will be cleared"), primaryButton: .default(Text("I am sure"), action: {
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                        UserDefaults.standard.synchronize()
                    }), secondaryButton: .default(Text("Nevermind"))
                )}
                          }.navigationTitle("Settings")
        
        
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showPopup = true
                        pressedButton.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                            pressedButton.toggle()
                        }
                    }) {
                        Image(systemName: "person.circle.fill")
                            .font(.body)
                            .foregroundColor(Color("4"))
                    }
                    .padding(.vertical, 10)
                    .scaleEffect(pressedButton ? 0.9 : 1)
                    .animation(.spring(response: 0.1, dampingFraction: 2), value: pressedButton)
                    .sheet(isPresented: $showPopup) {
                        ZStack{
                            Color("4").opacity(0.5)
                                .ignoresSafeArea()
                            VStack {
                                VStack(alignment: .leading, spacing: 16){
                                    Text("Sign Up")
                                        .font(Font.largeTitle.bold())
                                        .foregroundColor(Color.black)
                                    Text("Store your statistics and dificulty levels across devices.")
                                        .font(.subheadline)
                                        .foregroundColor(Color.black)
                                    HStack(spacing: 12.0){
                                        TextFieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextField)
                                            .foregroundColor(.white)
                                        TextField("Email", text: $email){
                                            isEditing in
                                            editingEmailTextField = isEditing
                                            editingPasswordTextField = false
                                        }
                                            .colorScheme(.dark)
                                            .foregroundColor(Color.white.opacity(0.7))
                                            .autocapitalization(.none)
                                            .textContentType(.emailAddress)

                                    }
                                    .frame(height: 52)
                                    .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white, lineWidth: 1)
                                        .blendMode(.overlay)
                                    )
                                    .background(
                                    Color("secondaryBackground")
                                        .cornerRadius(16.0)
                                        .opacity(0.8)
                                    )
                                    HStack(spacing: 12.0){
                                        TextFieldIcon(iconName: "key.fill", currentlyEditing: $editingPasswordTextField)
                                            .foregroundColor(.white)
                                        SecureField("Password", text: $password)
                                            .onTapGesture{
                                                editingPasswordTextField = true
                                                editingEmailTextField = false
                                            }
                                            .colorScheme(.dark)
                                            .foregroundColor(Color.white.opacity(0.7))
                                            .autocapitalization(.none)
                                            .textContentType(.password)
                                            

                                    }
                                    .frame(height: 52)
                                    .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white, lineWidth: 1)
                                        .blendMode(.overlay)
                                    )
                                    .background(
                                    Color("secondaryBackground")
                                        .cornerRadius(16.0)
                                        .opacity(0.8)
                                    )
                                    
                                    
                                    GradientButton2()
                                    
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color.white.opacity(0.1))
                                    
                                    VStack(alignment: .leading, spacing: 16, content:{
                                        Button {
                                            print("Switch to sign in")
                                        } label: {
                                            HStack(spacing: 4){
                                                Text("Already have an account?")
                                                    .font(.footnote)
                                                    .foregroundColor(Color.black)
                                                Text("Sign in")
                                                    .font(.footnote)
                                                    .bold()
                                                    .foregroundColor(Color.black)
                                                
                                            }
                                        }

                                    })
                                    
                                    
                                }
                                .padding(20)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.2))
                                    .background(Color("4").opacity(0.6))
                                    .shadow(color: Color("shadowColor").opacity(0.5), radius:60, x: 0, y: 30)
                            )
                            .cornerRadius(30.0)
                            .padding(.horizontal)
                        }
                        
                    
                        
                        
                    }
                }
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            
        }
    }



import SwiftUI
import FirebaseAuth


struct SettingsView: View {

    @State var showPopup = false
    @State var pressedButton = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false
    @State private var showProfileView: Bool = false
    @State private var signupToggle: Bool = true
    @State private var rotationAngle = 0.0
    
    @State private var showAlertView : Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)], animation: .default) private var savedAccounts: FetchedResults<Account>

    private let generator = UISelectionFeedbackGenerator()
    @Environment(\.presentationMode) var presentationMode


    

    @State private var showingGame = false
    @State var showAlert:Bool = false
    @State var showstuff = false
    @EnvironmentObject var model: Model
    
    var color: Color = .black
    
    var body: some View {
        color.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
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
                .background(color.opacity(0.5))
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
                .background(color.opacity(0.5))
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
                        
                        if model.loggedIn{
                            showProfileView.toggle()
                        }
                        else{
                            showPopup.toggle()
                        }
                        
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
                        //
                        //
                          //
                            //
                            //
                            ZStack{
                                Color("4").opacity(0.5)
                                    .ignoresSafeArea()
                                VStack {
                                    VStack(alignment: .leading, spacing: 16){
                                        Text(signupToggle ? "Sign Up" : "Sign In")
                                            .font(Font.largeTitle.bold())
                                            .foregroundColor(Color.black)
                                        Text("Store your statistics and dificulty levels across devices.")
                                            .font(.subheadline)
                                            .foregroundColor(Color.black)
                                        HStack(spacing: 12.0){
                                            TextFieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextField, passedImage: .constant(nil))
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
                                            TextFieldIcon(iconName: "key.fill", currentlyEditing: $editingPasswordTextField, passedImage: .constant(nil))
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
                                        
                                        
                                        GradientButton2(buttonTitle: signupToggle ? "Create Account" : "Sign In") {
                                            generator.selectionChanged()
                                            signup()
                                        }
                                        .onAppear{
                                            Auth.auth().addStateDidChangeListener { Auth, user in
                                                if let currentUser = user{
                                                    if savedAccounts.count == 0 {
                                                        // add data to core data
                                                        let userDataToSave = Account(context: viewContext)
                                                        userDataToSave.name = currentUser.displayName
                                                        userDataToSave.bio = nil
                                                        userDataToSave.userID = currentUser.uid
                                                        userDataToSave.profileImage = nil
                                                        userDataToSave.userSince = Date()
                                                        
                                                        do {
                                                            try viewContext.save()
                                                            DispatchQueue.main.async {
                                                                model.loggedIn.toggle()
                                                                presentationMode.wrappedValue.dismiss()
                                                                showPopup.toggle()
                                                            }
                                                        } catch let error {
                                                            alertTitle = "Could not create account"
                                                            alertMessage = error.localizedDescription
                                                            showAlertView.toggle()
                                                        }
                                                    }
                                                    else{
                                                        alertTitle = "Account Created"
                                                        alertMessage = ""
                                                        showAlertView.toggle()
                                                        model.loggedIn.toggle()
                                                        presentationMode.wrappedValue.dismiss()
                                                        showPopup.toggle()
                                                    }
                                                }
                                                
                                                
                                            }
                                        }
                                        if signupToggle
                                        {
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(Color.white.opacity(0.1))
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 16, content:{
                                            Button {
                                                withAnimation(.easeInOut(duration: 0.7)){
                                                    signupToggle.toggle()
                                                    self.rotationAngle += 180
                                                }
                                            } label: {
                                                HStack(spacing: 4){
                                                    Text(signupToggle ? "Already have an account?" : "Don't have an account?")
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                    Text(signupToggle ? "Sign In" : "Sign Up")
                                                        .font(.footnote)
                                                        .bold()
                                                        .foregroundColor(Color.black)
                                                    
                                                }
                                            }
                                            if !signupToggle {
                                                Button {
                                                    sendPasswordResetEmail()
                                                } label: {
                                                    HStack(spacing: 4){
                                                        Text("Forgot password?")
                                                            .font(.footnote)
                                                            .foregroundColor(.black)
                                                        Text("Reset Password")
                                                            .font(.footnote.bold())
                                                            .foregroundColor(.black)
                                                    }
                                                }
                                                
                                            }
                                            
                                        })
                                        
                                        
                                    }
                                    .padding(20)
                                }
                                .rotation3DEffect(
                                    Angle(degrees:self.rotationAngle),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white.opacity(0.3))
                                        .background(Color("4").opacity(0.6))
                                        .shadow(color: Color("shadowColor").opacity(0.5), radius:60, x: 0, y: 30)
                                )
                                .cornerRadius(30.0)
                                .padding(.horizontal)
                                .rotation3DEffect(
                                    Angle(degrees:self.rotationAngle),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .alert(isPresented: $showAlertView){
                                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
                                }
                                .sheet(isPresented: $showProfileView) {
                                    ProfileView()
                                }
                            }}
                    .sheet(isPresented: $showProfileView) {
                        ProfileView()
                            .environment(\.managedObjectContext, self.viewContext)
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            
        }
    func signup(){
        if signupToggle
        {
            Auth.auth().createUser(withEmail: email, password: password){
                result, error in
                guard error == nil else{
                    self.alertTitle = "Oh No!"
                    self.alertMessage = (error!.localizedDescription)
                    self.showAlertView.toggle()
                    return
                }
                print("User signed up")
            }
        }
        else{
            Auth.auth().signIn(withEmail: email, password: password) {
                result, error in
                guard error == nil else{
                    self.alertTitle = "Oh No!"
                    self.alertMessage = (error!.localizedDescription)
                    self.showAlertView.toggle()
                    return
                }
                print("user is signed in")
            }
        }
    }
    
    func sendPasswordResetEmail(){
        Auth.auth().sendPasswordReset(withEmail: email){
            error in
            guard error == nil else{
                self.alertTitle = "Oh No!"
                self.alertMessage = (error!.localizedDescription)
                self.showAlertView.toggle()
                return
            }
            alertTitle = ("password reset email sent")
            alertMessage = "Check your inbox for an email to reset your password"
            showAlertView.toggle()
            
        }
    }
    }



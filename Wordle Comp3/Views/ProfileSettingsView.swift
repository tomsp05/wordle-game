//
//  ProfileSettingsView.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 15/01/2023.
//

import SwiftUI
import CoreData
import FirebaseAuth

struct ProfileSettingsView: View {
    
    @State private var editingNameTextField = false
    @State private var editingBioTextField = false
    
    @State private var nameIconBounce = false
    @State private var bioIconBounce = false
    
    @State private var name = ""
    @State private var bio = ""
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var showAlertView : Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)],
        predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid),
        animation: .default
    ) private var savedAccounts: FetchedResults<Account>
    @State private var currentAccount: Account?

    private let generator = UISelectionFeedbackGenerator()


    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 16){
                Text("Profile Settings")
                    .font(.largeTitle.bold())
                    .padding(.top)
                Text("Manage your Wordle! profile and account")
                    .opacity(0.7)
                    .font(.callout)
                
                //Choose photo
                
                Button{
                    self.showImagePicker = true
                    
                }label: {
                    HStack(spacing: 12) {
                        TextFieldIcon(iconName: "person.crop.circle", currentlyEditing: .constant(false), passedImage: $inputImage)
                        Text("Choose Photo")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                    )
                }
                
                // Name text field
                
                GradientTextField(editingTextField: $editingNameTextField, textFieldString: $name, iconBounce: $nameIconBounce, textFieldPlaceholder: "Name", textFieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                
                
                // Bio text field
                
                GradientTextField(editingTextField: $editingBioTextField, textFieldString: $bio, iconBounce: $bioIconBounce, textFieldPlaceholder: "Bio", textFieldIconString: "text.justifyleft")
                    .autocapitalization(.sentences)
                    .keyboardType(.default)
                
                GradientButton2(buttonTitle: "Save Settings"){
                    //save changes to core data
                    generator.selectionChanged()
                    
                    currentAccount?.name = self.name
                    currentAccount?.bio = self.bio
                    currentAccount?.profileImage = self.inputImage?.pngData()
                    do{
                        try viewContext.save()
                        alertTitle = "Settings Saved"
                        alertMessage = "Your Settings Have Been Saved"
                        showAlertView.toggle()
                    }catch let error{
                        alertTitle = "Oh No!"
                        alertMessage = error.localizedDescription
                        showAlertView.toggle()
                    }
                }
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.937254902, green: 0.6549019608, blue: 0.4078431373, alpha: 1)).opacity(0.3))
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showImagePicker){
                ImagePicker1(image: self.$inputImage)
            }
            .onAppear(){
                currentAccount = savedAccounts.first!
                self.name = currentAccount?.name ?? ""
                self.bio = currentAccount?.bio ?? ""
                self.inputImage = UIImage(data: currentAccount?.profileImage ?? Data())
            }
            .alert(isPresented: $showAlertView, content: {Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())})
    }
}



struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}

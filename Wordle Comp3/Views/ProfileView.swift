//
//  ProfileView.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 14/01/2023.
//

import SwiftUI
import FirebaseAuth
import CoreData

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: Model

    @State private var showSettingsView: Bool = false
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
    
    @State private var updater: Bool = true

    
    var body: some View {
        ZStack{
            Color("4").opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack(alignment: .leading
                       , spacing: 16){
                    HStack(spacing: 16){
                        if currentAccount?.profileImage != nil{
                            GradientProfilePicture(profilePicture: UIImage(data: currentAccount!.profileImage!)!)
                                .frame(width: 66, height: 66, alignment: .center)
                        }else{
                            ZStack{
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 66, height: 66, alignment: .center)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .medium, design: .rounded))
                            }
                            .frame(width: 66, height: 66, alignment: .center)
                        }
                        

                        VStack(alignment: .leading){
                            Text(currentAccount?.name ?? "No name")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                            Text("View Profile")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.footnote)
                        }
                        Spacer()
                        
                        Button{
                            showSettingsView.toggle()
                        } label: {
                            TextFieldIcon(iconName: "gearshape.fill", currentlyEditing: .constant(true), passedImage: .constant(nil))
                        }

                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    
                    Text(currentAccount?.bio ?? "No Bio")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                    
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                }
                
            }
            .padding(20)
            .background(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.2))
                .background(Color(#colorLiteral(red: 0.937254902, green: 0.6549019608, blue: 0.4078431373, alpha: 1)).opacity(0.5))
                .background(VisualEffectBlur(blurStyle: .dark))
                .shadow(color: Color.black.opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            VStack{
                Spacer()
                Button {
                    model.loggedIn = false
                    signout()
                } label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 15,weight: .medium, design: .rounded))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 0, z: 1)
                        )
                        .background(
                        Circle()
                            .stroke(Color.white.opacity(0.2),lineWidth: 1)
                            .frame(width: 42, alignment: .center)
                            .overlay(
                                VisualEffectBlur(blurStyle: .dark)
                                    .cornerRadius(21)
                                    .frame(width: 42, height: 42, alignment: .center)
                            )
                        )
                }

            }
            .padding(.bottom, 64)
        }
        .colorScheme(updater ? .dark : .dark)
        .sheet(isPresented: $showSettingsView){
        ProfileSettingsView()
                .environment(\.managedObjectContext, self.viewContext
                )
                .onDisappear(){
                    currentAccount = savedAccounts.first!
                    updater.toggle()
                }
    }
        .onAppear(){
            currentAccount = savedAccounts.first
            
            if currentAccount == nil {
                let userDataToSave = Account(context: viewContext)
                userDataToSave.name = Auth.auth().currentUser!.displayName
                userDataToSave.bio = nil
                userDataToSave.userID = Auth.auth().currentUser!.uid
                userDataToSave.profileImage = nil
                userDataToSave.userSince = Date()
                
                do {
                    try viewContext.save()
                } catch let error {
                    alertTitle = "Could not create account"
                    alertMessage = error.localizedDescription
                    showAlertView.toggle()
                }
            }
        
        }
        
    }
    
    func signout(){
        do{
            try Auth.auth().signOut()
            presentationMode.wrappedValue.dismiss()
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

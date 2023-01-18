import SwiftUI
import FirebaseAuth
import CoreData



struct HomeView: View {
    @AppStorage("AVGnumberOfGuesses") var AVGnumGuesses: Int = 0
    @AppStorage("LastNumberOfGuesses") var LastNumGuesses: Int = 0
    @AppStorage("correctGamesPlayed") var correctGamesPlayed: Int = 0
    @AppStorage("numGamesPlayed") var NumGamesPlayed: Int = 0
    @AppStorage("mostUsedCatagory") var mostUsedCatagory: String = ""
    @AppStorage("mostCorrectCatagory") var mostCorrectCatagory: String = ""
    
    @AppStorage("userLoggedIn") var userLoggedIn: Bool = false

    
    @Environment(\.presentationMode) var presentationMode
    @State private var showSettingsView: Bool = false
    @State private var showAlertView : Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)],
        animation: .default
    ) private var savedAccounts: FetchedResults<Account>
    @State private var currentAccount: Account?
    
    @State private var updater: Bool = true
    
    @EnvironmentObject var model: Model
    
    var color: Color = .black
    
    

    var body: some View {
        
        color.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
        ScrollView{
            VStack{
                
                VStack(spacing: 5) {
                    
                    
                    
                    
                    
                    HStack{
                        VStack{
                            HStack(spacing: 1){
                                Image(systemName: "chart.bar.doc.horizontal").font(.system(size: CGFloat(model.fontSize + 4)))
                                .fontWeight(.bold)
                                
                                Text("Last Game Statistics")
                                .font(.system(size: CGFloat(model.fontSize + 4)))
                                .fontWeight(.bold)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            if LastNumGuesses == 0{
                                Text("No data for previous game yet")
                                    .font(.system(size: CGFloat(model.fontSize)))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            else{
                                Text("On the last game you played you used \(LastNumGuesses) guesses!")
                                    .font(.system(size: CGFloat(model.fontSize)))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
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
                                Image(systemName: "chart.bar.doc.horizontal").font(.system(size: CGFloat(model.fontSize + 4)))
                                .fontWeight(.bold)
                                
                                Text("Overall Player Statistics")
                                .font(.system(size: CGFloat(model.fontSize + 4)))
                                .fontWeight(.bold)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack{
                                Text("On average you use \(AVGnumGuesses) guesses per game")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: CGFloat(model.fontSize)))
                                    .font(.body)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 5)
                                
                                if NumGamesPlayed == 0{
                                    Text("The number of games you have played is \(NumGamesPlayed)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                    
                                    Text("\(correctGamesPlayed) out of \(NumGamesPlayed) words have been guessed correctly")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                }
                                else{
                                    Text("The number of games you have played is \(NumGamesPlayed - 1)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                    
                                    Text("\(correctGamesPlayed) out of \(NumGamesPlayed - 1) words have been guessed correctly")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                    
                                }
                            }
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
                                Image(systemName: "chart.bar.doc.horizontal").font(.system(size: CGFloat(model.fontSize + 4)))
                                .fontWeight(.bold)
                                
                                Text("Category Infomation")
                                .font(.system(size: CGFloat(model.fontSize + 4)))
                                .fontWeight(.bold)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack{
                                if mostUsedCatagory == ""{
                                    Text("Not enough infomation about the category's you use yet")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                }
                                else{
                                    Text("Your most used category is \(mostUsedCatagory)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                }
                                
                                if mostCorrectCatagory == ""{
                                    Text("Not enough infomation about the category's you use yet")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                }
                                else{
                                    Text("The category you are best at is \(mostCorrectCatagory)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: CGFloat(model.fontSize)))
                                        .font(.body)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(20)
                    .background(color.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous), style: FillStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    

                        .sheet(isPresented: $showSettingsView){
                            ProfileSettingsView()
                                .environment(\.managedObjectContext, self.viewContext
                                )
                                .onDisappear(){
                                    currentAccount = savedAccounts.first!
                                    updater.toggle()
                                }}
                    
                    
                    
                }.navigationTitle("Welcome")
                    .navigationViewStyle(StackNavigationViewStyle())
                
                
                
                
            }
        }
    }
    
    func updateCard(){
        currentAccount = savedAccounts.first!
        updater.toggle()
    }
}

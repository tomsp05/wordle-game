import SwiftUI


struct HomeView: View {
    @AppStorage("AVGnumberOfGuesses") var AVGnumGuesses: Int = 0
    @AppStorage("LastNumberOfGuesses") var LastNumGuesses: Int = 0
    @AppStorage("correctGamesPlayed") var correctGamesPlayed: Int = 0
    @AppStorage("numGamesPlayed") var NumGamesPlayed: Int = 0
    @AppStorage("mostUsedCatagory") var mostUsedCatagory: String = ""
    @AppStorage("mostCorrectCatagory") var mostCorrectCatagory: String = ""
    
    @AppStorage("userLoggedIn") var userLoggedIn: Bool = false

    
    @EnvironmentObject var model: Model
    
    var color: Color = .black
    
    var body: some View {
        
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
                    .background(color.opacity(0.3))
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
                    .background(color.opacity(0.3))
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
                    .background(color.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous), style: FillStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    
                    
                    
                    
                }.navigationTitle("Welcome")
                    .navigationViewStyle(StackNavigationViewStyle())
                
                
                
                
            }
        }
    }
}

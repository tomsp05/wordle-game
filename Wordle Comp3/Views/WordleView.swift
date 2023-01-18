import SwiftUI
import UserNotifications

struct WordleView: View {
    //alert logic
    @State var showAlert:Bool = false
    @State var showIncorrectAlert:Bool = false
    @State var showCatagoryAlert:Bool = false
    @State var showCorrectWord:Bool = false
    @State var showAlertDebug:Bool = false
    @State var pluralText: String = "Guess"
    @State var warnLength: Bool = false
    @State var warnNotValidWord: Bool = false
    //storage
    @AppStorage("AVGnumberOfGuesses") var AVGnumGuesses: Int = 0
    @AppStorage("LastNumberOfGuesses") var LastNumGuesses: Int = 0
    @AppStorage("numGamesPlayed") var numGamesPlayed: Int = 0
    @AppStorage("correctGamesPlayed") var correctGamesPlayed: Int = 0
    @AppStorage("totalNumGuesses") var totalNumGuesses: Int = 0
    
    @AppStorage("nounsCatagoryUsed") var nounsCatagoryUsed: Int = 0
    @AppStorage("verbsCatagoryUsed") var verbsCatagoryUsed: Int = 0
    @AppStorage("adjectivesCatagoryUsed") var adjectivesCatagoryUsed: Int = 0
    @AppStorage("allwordsCatagoryUsed") var allwordsCatagoryUsed: Int = 0
    @AppStorage("mostUsedCatagory") var mostUsedCatagory: String = ""
    
    @AppStorage("nounsCatagoryCorrect") var nounsCatagoryCorrect: Int = 0
    @AppStorage("adjectivesCatagoryCorrect") var adjectivesCatagoryCorrect: Int = 0
    @AppStorage("allwordsCatagoryCorrect") var allwordsCatagoryCorrect: Int = 0
    @AppStorage("verbsCatagoryCorrect") var verbsCatagoryCorrect: Int = 0
    @AppStorage("mostCorrectCatagory") var mostCorrectCatagory: String = ""
    
    @EnvironmentObject var model: Model
    //guess logic
    @ObservedObject var textBindingManager = TextBindingManager(limit: 5)
    @State var usersGuess1 = ""
    @State var usersGuess2 = ""
    @State var usersGuess3 = ""
    @State var usersGuess4 = ""
    @State var usersGuess5 = ""
    @State var usersGuess6 = ""
    //button logic
    @State var textFieldPlaceholder = "Type Your Guess"
    @State var pressCount = 0
    @State var pressedButton = false
    @State var buttonText = "Enter"
    //wordle logic
    @State var characters : Array = []
    @State var gridItemsNum = 1
    @State var selectedCatagory = "All Words"
    @State var textTest = ""
    @State var charactarsInputted = -1


    @State var randomNumber = Int.random(in: 1...wordsUsableList.count)
    @State var correctWord = ""
    @State var decidedColour: UIColor = .red
    @FocusState private var amountIsFocused: Bool

    
    var color: Color = .black
    
    var body: some View {
        
        let columns = [
            GridItem(.fixed(60)),
            GridItem(.fixed(60)),
            GridItem(.fixed(60)),
            GridItem(.fixed(60)),
            GridItem(.fixed(60))
        ]
        
        NavigationStack{
            
            ZStack {
                color.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    
                    VStack{
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(GridItemsRow1) { g in
                                    ZStack{
                                        Text(g.letter)
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(model.fontSize + 2)))
                                    }
                                    .frame(width: 50, height: 50, alignment: .center)
                                    
                                    .background(Color(g.colour))
                                    
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(7.5)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                                    .onTapGesture {
                                        print("Pressed")
                                        amountIsFocused.toggle()
                                    }
                                    
                                }
                            }
                        }.padding(.vertical, 4)
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(GridItemsRow2) { g in
                                    ZStack{
                                        Text(g.letter)
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(model.fontSize + 2)))
                                    }
                                    .frame(width: 50, height: 50, alignment: .center)
                                    
                                    .background(Color(g.colour))
                                    
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(7.5)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                                    .onTapGesture {
                                        print("Pressed")
                                        amountIsFocused.toggle()
                                    }
                                }
                            }
                        }.padding(.vertical, 4)
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(GridItemsRow3) { g in
                                    ZStack{
                                        Text(g.letter)
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(model.fontSize + 4)))
                                    }
                                    .frame(width: 50, height: 50, alignment: .center)
                                    
                                    .background(Color(g.colour))
                                    
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(7.5)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                                    .onTapGesture {
                                        print("Pressed")
                                        amountIsFocused.toggle()
                                    }
                                }
                            }
                        }.padding(.vertical, 4)
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(GridItemsRow4) { g in
                                    ZStack{
                                        Text(g.letter)
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(model.fontSize + 2)))
                                    }
                                    .frame(width: 50, height: 50, alignment: .center)
                                    
                                    .background(Color(g.colour))
                                    
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(7.5)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                                    .onTapGesture {
                                        print("Pressed")
                                        amountIsFocused.toggle()
                                    }
                                }
                            }
                        }.padding(.vertical, 4)
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(GridItemsRow5) { g in
                                    ZStack{
                                        Text(g.letter)
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(model.fontSize + 2)))
                                    }
                                    .frame(width: 50, height: 50, alignment: .center)
                                    
                                    .background(Color(g.colour))
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(7.5)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                                    .onTapGesture {
                                        print("Pressed")
                                        amountIsFocused.toggle()
                                    }
                                }
                            }
                        }.padding(.vertical, 4)
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(GridItemsRow6) { g in
                                    ZStack{
                                        Text(g.letter)
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(model.fontSize + 2)))
                                    }
                                    .frame(width: 50, height: 50, alignment: .center)
                                    
                                    .background(Color(g.colour))
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(7.5)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                                    .onTapGesture {
                                        print("Pressed")
                                        
                                        amountIsFocused.toggle()
                                    }
                                }
                            }
                        }.padding(.top, 4)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 0)
                    
                    
                    
                    HStack{
                        
                        TextField("Type Your Guess:", text: $textBindingManager.text)
                            .keyboardType(.alphabet)
                            .font(.system(size: CGFloat(model.fontSize + 2)))
                            .focused($amountIsFocused)
                            .foregroundColor(color.opacity(0.0))
                            .accentColor(color.opacity(0.0))
                        
                            .disableAutocorrection(true)
                            .frame(height: 50)
                            .textInputAutocapitalization(.characters)
                            .multilineTextAlignment(.leading)
                            .ignoresSafeArea(.keyboard)
                            
                        
                            
                            
                            .onSubmit {

                                if textBindingManager.text.lengthOfBytes(using: .ascii) < 5 || textBindingManager.text.lengthOfBytes(using: .ascii) > 5 {
                                    print("warn user length")
                                    warnLength = true
                                }
                                
                                else{
                                    warnLength = false
                                }
                                
                                if warnLength == false{
                                    pressCount += 1
                                    var letterNum = 0
                                    
                                    if selectedCatagory == "All Words"{
                                        correctWord = wordsUsableList[randomNumber]
                                    }
                                    else if selectedCatagory == "Nouns"{
                                        correctWord = wordsNouns[randomNumber]
                                    }
                                    else if selectedCatagory == "Adjectives"{
                                        correctWord = wordsAdjectives[randomNumber]
                                    }
                                    else if selectedCatagory == "Verbs"{
                                        correctWord = wordsVerbs[randomNumber]
                                    }
                                    
                                    print(Array(correctWord))
                                    
                                    
                                    if pressCount == 1 {
                                        usersGuess1 = textBindingManager.text
                                    } else if pressCount == 2 {
                                        usersGuess2 = textBindingManager.text
                                    } else if pressCount == 3 {
                                        usersGuess3 = textBindingManager.text
                                    } else if pressCount == 4 {
                                        usersGuess4 = textBindingManager.text
                                    } else if pressCount == 5 {
                                        usersGuess5 = textBindingManager.text
                                    } else if pressCount == 6 {
                                        usersGuess6 = textBindingManager.text
                                    }
                                    
                                    var counter = 0
                                    var count2 = 0
                                    while counter < 5 {
                                        
                                        if gridItemsNum == 1 {
                                            model.numGuesses = 1
                                            if Array(usersGuess1)[letterNum] == Array(correctWord)[letterNum]{
                                                decidedColour = UIColor(red: 0.00, green: 0.67, blue: 0.25, alpha: 1)}
                                            else if Array(correctWord).contains(Array(usersGuess1)[letterNum]){
                                                decidedColour = .orange}
                                            else if !Array(correctWord).contains(Array(usersGuess1)[letterNum]){
                                                decidedColour = .gray}
                                            if usersGuess1 == correctWord{
                                                pluralText = "Guess"
                                                LastNumGuesses = model.numGuesses
                                                showAlert.toggle()
                                            }
                                            GridItemsRow1[letterNum] = GridValue(letter: guessSplitter1(guessInt: letterNum), colour: decidedColour)
                                                
                                            
                                            
                                        } else if gridItemsNum == 2 {
                                            model.numGuesses = 2
                                            if Array(usersGuess2)[letterNum] == Array(correctWord)[letterNum]{
                                                decidedColour = UIColor(red: 0.00, green: 0.67, blue: 0.25, alpha: 1)}
                                            else if Array(correctWord).contains(Array(usersGuess2)[letterNum]){
                                                decidedColour = .orange}
                                            else if !Array(correctWord).contains(Array(usersGuess2)[letterNum]){
                                                decidedColour = .gray}
                                            if usersGuess2 == correctWord{
                                                pluralText = "Guesses"
                                                LastNumGuesses = model.numGuesses
                                                showAlert.toggle()
                                            }
                                            GridItemsRow2[letterNum] = GridValue(letter: guessSplitter2(guessInt: letterNum), colour: decidedColour)
                                            
                                        } else if gridItemsNum == 3 {
                                            model.numGuesses = 3
                                            if Array(usersGuess3)[letterNum] == Array(correctWord)[letterNum]{
                                                decidedColour = UIColor(red: 0.00, green: 0.67, blue: 0.25, alpha: 1)}
                                            else if Array(correctWord).contains(Array(usersGuess3)[letterNum]){
                                                decidedColour = .orange}
                                            else if !Array(correctWord).contains(Array(usersGuess3)[letterNum]){
                                                decidedColour = .gray}
                                            if usersGuess3 == correctWord{
                                                pluralText = "Guesses"
                                                LastNumGuesses = model.numGuesses
                                                showAlert.toggle()
                                            }
                                            GridItemsRow3[letterNum] = GridValue(letter: guessSplitter3(guessInt: letterNum), colour: decidedColour)
                                            
                                        } else if gridItemsNum == 4 {
                                            model.numGuesses = 4
                                            if Array(usersGuess4)[letterNum] == Array(correctWord)[letterNum]{
                                                decidedColour = UIColor(red: 0.00, green: 0.67, blue: 0.25, alpha: 1)}
                                            else if Array(correctWord).contains(Array(usersGuess4)[letterNum]){
                                                decidedColour = .orange}
                                            else if !Array(correctWord).contains(Array(usersGuess4)[letterNum]){
                                                decidedColour = .gray}
                                            if usersGuess4 == correctWord{
                                                pluralText = "Guesses"
                                                LastNumGuesses = model.numGuesses
                                                showAlert.toggle()
                                            }
                                            GridItemsRow4[letterNum] = GridValue(letter: guessSplitter4(guessInt: letterNum), colour: decidedColour)
                                            
                                        } else if gridItemsNum == 5 {
                                            model.numGuesses = 5
                                            if Array(usersGuess5)[letterNum] == Array(correctWord)[letterNum]{
                                                decidedColour = UIColor(red: 0.00, green: 0.67, blue: 0.25, alpha: 1)}
                                            else if Array(correctWord).contains(Array(usersGuess5)[letterNum]){
                                                decidedColour = .orange}
                                            else if !Array(correctWord).contains(Array(usersGuess5)[letterNum]){
                                                decidedColour = .gray}
                                            if usersGuess5 == correctWord{
                                                pluralText = "Guesses"
                                                LastNumGuesses = model.numGuesses
                                                showAlert.toggle()
                                            }
                                            
                                            GridItemsRow5[letterNum] = GridValue(letter: guessSplitter5(guessInt: letterNum), colour: decidedColour)
                                        }
                                        else if gridItemsNum == 6 {
                                            model.numGuesses = 6
                                            if Array(usersGuess6)[letterNum] == Array(correctWord)[letterNum]{
                                                decidedColour = UIColor(red: 0.00, green: 0.67, blue: 0.25, alpha: 1)}
                                            else if Array(correctWord).contains(Array(usersGuess6)[letterNum]){
                                                decidedColour = .orange}
                                            else if !Array(correctWord).contains(Array(usersGuess6)[letterNum]){
                                                decidedColour = .gray}
                                            if usersGuess6 == correctWord{
                                                pluralText = "Guesses"
                                                LastNumGuesses = model.numGuesses
                                                showAlert.toggle()
                                            }
                                            if usersGuess6 != correctWord{
                                                LastNumGuesses = model.numGuesses
                                                print("Incorrect")
                                                showIncorrectAlert.toggle()
                                                
                                            }
                                            
                                            GridItemsRow6[letterNum] = GridValue(letter: guessSplitter6(guessInt: letterNum), colour: decidedColour)
                                        }
                                            
                                        
                                        letterNum += 1
                                        counter += 1
                                    }
                                    gridItemsNum += 1
                                    count2 += 1
                                    textBindingManager.text = ""
                                }
                                
                                    
                                
                            }
                        Text("Enter a valid 5 letter word")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.trailing)
                            .font(.subheadline)
                        
                            .frame(width: 80)
                            .opacity(warnLength ? 1 : 0)
                        
                            
                        
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 0)
                    
                    
                    
                    
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Well done!! You got it correct in \(model.numGuesses) \(pluralText)"), message: Text("The word was \(correctWord)"), dismissButton: .default(Text("New Game"), action: {
                            if selectedCatagory == "All Words"{
                                allwordsCatagoryCorrect += 1
                            }
                            else if selectedCatagory == "Nouns"{
                                nounsCatagoryCorrect += 1
                            }
                            else if selectedCatagory == "Adjectives"{
                                adjectivesCatagoryCorrect += 1
                            }
                            averageNumGuessesCalc()
                            mostCorrectCatagoryCalc()
                            numGamesPlayed += 1
                            correctGamesPlayed += 1
                            mostUsedCatagoryCalc()
                            newGame()}))}
                }
                .animation(.easeInOut, value: pressCount)
                .navigationTitle("Unlimited Wordle")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Text("Guess: \(textBindingManager.text)")

                        Spacer()
                        Button("Close Keyboard") {
                            amountIsFocused = false
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu() {
                            Button {
                                correctWord = wordsUsableList[randomNumber]
                                showAlert.toggle()
                            } label: {
                                Text("Force Correct")
                                    .font(.body)
                            }
                            Button {
                                correctWord = wordsUsableList[randomNumber]
                                showIncorrectAlert.toggle()
                            } label: {
                                Text("Force Incorrect")
                                    .font(.body)
                            }
                            Button {
                                
                            } label: {
                                Text("Correct word is: \(correctWord)")
                                    .font(.body)
                            }
                            
                            Button {
                                
                                newGame()
                            } label: {
                                Text("Reset")
                                    .font(.body)
                            }
                            Text("Press Count: \(pressCount)")
                            
                            Text("Category: \(selectedCatagory)")
                            
                        } label: {
                            HStack{
//                                Text("Debug Menu")
//                                    .font(.body)
//                                    .foregroundColor(color)
                                Image(systemName: "ladybug.fill")
                                    .foregroundColor(color)
                                    .font(.body)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Menu() {
                            Button {
                                newGame()
                            } label: {
                                Text("New Game")
                                    .font(.body)
                            }
                            Menu(){
                                
                                Menu(){
                                    Button {
                                        randomNumber = Int.random(in: 1...wordsNouns.count)
                                        selectedCatagory = "Nouns"
                                        showCatagoryAlert.toggle()
                                        nounsCatagoryUsed += 1
                                    } label: {
                                        Text("Nouns")
                                        .font(.body)}
                                    
                                    
                                    Button {
                                        randomNumber = Int.random(in: 1...wordsAdjectives.count)
                                        selectedCatagory = "Adjectives"
                                        showCatagoryAlert.toggle()
                                        adjectivesCatagoryUsed += 1
                                    } label: {
                                        Text("Advjectives")
                                        .font(.body)}
                                    
                                    Button {
                                        randomNumber = Int.random(in: 1...wordsVerbs.count)
                                        selectedCatagory = "Verbs"
                                        showCatagoryAlert.toggle()
                                        verbsCatagoryUsed += 1
                                    } label: {
                                        Text("Verbs")
                                        .font(.body)}
                                    
                                    
                                }label: {
                                    Text("Types of Word Classes")
                                        .fontWeight(.bold)
                                }
                                    
                                Button {
                                    selectedCatagory = "All Words"
                                    randomNumber = Int.random(in: 1...wordsUsableList.count)
                                    showCatagoryAlert.toggle()
                                    allwordsCatagoryUsed += 1
                                } label: {
                                    Text("All Words")
                                    .font(.body)}
                                
                                    
                                } label: {
                                    Text("Choose Catagory")
                                        .fontWeight(.bold)
                                }
                                
                            } label: {
                                HStack{
                                    Image(systemName: "gamecontroller")
                                        .foregroundColor(color)
                                        .font(.body)
                                    Text("Game")
                                        .foregroundColor(color)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    
                }
            
            }.navigationViewStyle(StackNavigationViewStyle()
                                  
            )
            
            .alert(isPresented: $showIncorrectAlert) {
                Alert(title: Text("Oh No!! You did not manage to get the correct word."), message: Text("The word was \(correctWord)"), dismissButton: .default(Text("New Game"), action: {
                        averageNumGuessesCalc()
                        mostUsedCatagoryCalc()
                        numGamesPlayed += 1
                        newGame()}))
            }
            
//            .alert(isPresented: $showCatagoryAlert) {
//                Alert(title: Text("You have changed the category!"), message: Text("The category has been set to \(selectedCatagory)"), dismissButton: .default(Text("Ok"), action: {
//                }))
//            }
        
            
        
        }
        
        func newGame(){
            if selectedCatagory == "All Words"{
                randomNumber = Int.random(in: 1...wordsUsableList.count)
            }
            else if selectedCatagory == "Nouns"{
                randomNumber = Int.random(in: 1...wordsNouns.count)
            }
            else if selectedCatagory == "Adjectives"{
                randomNumber = Int.random(in: 1...wordsAdjectives.count)
            }
            else if selectedCatagory == "Verbs"{
                randomNumber = Int.random(in: 1...wordsVerbs.count)
            }
            pressCount = 0
            gridItemsNum = 1
            
            
            var counter = 0
            
            while counter < 5 {
                GridItemsRow1[counter] = GridValue(letter: "", colour: .clear)
                GridItemsRow2[counter] = GridValue(letter: "", colour: .clear)
                GridItemsRow3[counter] = GridValue(letter: "", colour: .clear)
                GridItemsRow4[counter] = GridValue(letter: "", colour: .clear)
                GridItemsRow5[counter] = GridValue(letter: "", colour: .clear)
                GridItemsRow6[counter] = GridValue(letter: "", colour: .clear)
                counter += 1
            }
        }
        
        func averageNumGuessesCalc(){
            totalNumGuesses = totalNumGuesses + LastNumGuesses
            if numGamesPlayed == 0{
                numGamesPlayed = 1
            }
            AVGnumGuesses = totalNumGuesses/numGamesPlayed
        }
        
        
        func mostUsedCatagoryCalc() {
            let largestNum = max(allwordsCatagoryUsed, max(nounsCatagoryUsed, adjectivesCatagoryUsed, verbsCatagoryUsed))
            if nounsCatagoryUsed == largestNum{
                mostUsedCatagory = "Nouns"}
            else if allwordsCatagoryUsed == largestNum{
                mostUsedCatagory = "All Words"}
            else if adjectivesCatagoryUsed == largestNum{
                mostUsedCatagory = "Adjectives"}
            else if verbsCatagoryUsed == largestNum{
                mostUsedCatagory = "Verbs"}
        }
        
        func mostCorrectCatagoryCalc() {
            let largestNum2 = max(allwordsCatagoryCorrect, max(nounsCatagoryCorrect, adjectivesCatagoryCorrect, verbsCatagoryUsed))
            if nounsCatagoryCorrect == largestNum2{
                mostCorrectCatagory = "Nouns"}
            else if allwordsCatagoryCorrect == largestNum2{
                mostCorrectCatagory = "All Words"}
            else if adjectivesCatagoryCorrect == largestNum2{
                mostCorrectCatagory = "Adjectives"}
            else if verbsCatagoryCorrect == largestNum2{
                mostCorrectCatagory = "Verbs"}
        }
        
        func guessSplitter1(guessInt: Int) -> String{
            let characters = Array(usersGuess1)
            let strings = characters.map { String($0) }
            return strings[guessInt] }
        func guessSplitter2(guessInt: Int) -> String{
            let characters = Array(usersGuess2)
            let strings = characters.map { String($0) }
            return strings[guessInt] }
        func guessSplitter3(guessInt: Int) -> String{
            let characters = Array(usersGuess3)
            let strings = characters.map { String($0) }
            return strings[guessInt] }
        func guessSplitter4(guessInt: Int) -> String{
            let characters = Array(usersGuess4)
            let strings = characters.map { String($0) }
            return strings[guessInt] }
        func guessSplitter5(guessInt: Int) -> String{
            let characters = Array(usersGuess5)
            let strings = characters.map { String($0) }
            return strings[guessInt] }
        func guessSplitter6(guessInt: Int) -> String{
            let characters = Array(usersGuess6)
            let strings = characters.map { String($0) }
            return strings[guessInt] }
    

        
        func correctWordSplitter(guessInt: Int) -> String{
            let characters = Array(correctWord)
            let strings = characters.map { String($0) }
            return strings[guessInt]
        }
        
    }
    


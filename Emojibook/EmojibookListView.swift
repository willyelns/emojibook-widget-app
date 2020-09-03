//
//  ContentView.swift
//  Emojibook
//
//  Created by Will Xavier on 03/09/20.
//

import SwiftUI

struct EmojibookListView: View {
    
    let emojiData: [EmojiDetails] = EmojiProvider.all()
    @State private var showingDetail: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emojiData, content: { emojiDetails in
                    Button(action: {
                        showingDetail.toggle()
                    }, label: {
                        EmojiItemView(emoji: emojiDetails.emoji, emojiName: emojiDetails.name)
                    })
                    .sheet(isPresented: $showingDetail) {
                        EmojiDetailsView(emojiDetails: emojiDetails)
                    }
                })
            }
            .foregroundColor(.black)
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Emojibook")
        }
    }
}

struct EmojibookListView_Previews: PreviewProvider {
    static var previews: some View {
        EmojibookListView()
    }
}

struct EmojiItemView: View {
    let emoji: String
    let emojiName: String
    
    var body: some View {
        Text("\(emoji) \(emojiName)")
            .font(.largeTitle)
            .padding([.top, .bottom])
    }
}

struct EmojiDetailsView: View {
    var emojiDetails: EmojiDetails
    
    var body: some View {
        ZStack {
            // Background Color
            Color(UIColor.systemIndigo).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            // Emoji Data
            VStack(alignment: .leading) {
                HStack {
                    Text("\(emojiDetails.emoji) \(emojiDetails.name)")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                
                Text(emojiDetails.description)
                    .padding([.leading, .trailing, .bottom])
                    .font(.title)
            }
        }
        .foregroundColor(.white)
    }
}

//
//  ContentView.swift
//  Emojibook
//
//  Created by Will Xavier on 03/09/20.
//

import SwiftUI

struct EmojibookListView: View {
    
    let emojiData: [EmojiDetails] = EmojiProvider.all()
    
    @State private var visibleEmojiDetails: EmojiDetails?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emojiData, content: { emojiDetails in
                    Button(action: {
                        visibleEmojiDetails = emojiDetails
                    }, label: {
                        EmojiItemView(emoji: emojiDetails.emoji, emojiName: emojiDetails.name)
                    })
                })
            }
            .foregroundColor(.black)
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Emojibook")
        }
        .onOpenURL { url in
            guard let emojiDetails = emojiData.first(where: { $0.url == url}) else { return }
            visibleEmojiDetails = emojiDetails
        }
        .sheet(item: $visibleEmojiDetails, content: { emojiDetails in
            EmojiDetailsView(emojiDetails: emojiDetails)
        })
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

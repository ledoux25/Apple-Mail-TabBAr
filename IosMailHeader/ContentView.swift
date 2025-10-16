//
//  ContentView.swift
//  IosMailHeader
//
//  Created by Sanguo Joseph Ledoux on 10/13/25.
//

import SwiftUI

struct MailSection: Identifiable {
    var id = UUID()
    var title : String
    var icon : String
    var color : Color
}

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var activeSection = 5
    @State private var selectedSection : MailSection?
    let items = [
    
        MailSection(title: "primary", icon: "person.fill", color: .blue),
        MailSection( title: "Transactions", icon: "cart.fill", color: .green),
        MailSection(title: "Updates", icon: "text.bubble.fill", color: .indigo),
        MailSection(title: "Promotions", icon: "megaphone.fill", color: .pink)
//        MailSection( title: "Al Mails", icon: "tray.fill", color: .black)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(){
                    HStack(spacing: activeSection == 5 ? -12 : 3) {
                        ForEach(items.enumerated(), id: \.offset){ index, section in
                            let isActive = index == activeSection
                            let image = isActive ? section.icon :section.icon.replacingOccurrences(of: ".fill", with: "")
                            HStack{
                                Image(systemName: image)
                                
                                if isActive {
                                    Text(
                                        section.title
                                    )
                                    .font(.subheadline.bold())
                                }
                            }
                            .font(.title3)
                            .padding()
                            
                            .foregroundStyle(isActive ? .white : .gray)
                            .frame(minWidth : 65,maxWidth: isActive ? .infinity : nil, maxHeight: 50)
                            .background(isActive ? section.color : .accentColor)
                            .clipShape(.rect(cornerRadius: 20))
                            
                            .zIndex(Double(index))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 3)
                            )
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    
                                    if activeSection == index {
                                        activeSection = 5
                                        return
                                    }
                                    selectedSection = section
                                    activeSection = index
                                }
                            }
                            
                            
                        }
                    }
                    .frame( alignment: .leading)
                    
                    
                    
                    if activeSection == 5 {
                        HStack{
                            Image(systemName: "tray.fill")
                            
                            
                            Text(
                                "All Mails"
                            )
                            .font(.subheadline.bold())
                            
                        }
                        .font(.title3)
                        .padding()
                        .foregroundStyle( .white )
                        .frame(maxWidth:  .infinity, maxHeight: 50)
                        .background(.black)
                        .clipShape(.rect(cornerRadius: 20))
                        .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .offset(x:160).combined(with: .opacity)))
                    }
                }
                .padding(.horizontal)
                
                
                
                
                
                
                Spacer()
                

                    Text(selectedSection?.title ?? "All Mails")
                    
                

                
                
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search fruits")
                .navigationTitle("All Inboxes")
                Spacer()
            }
        }
    }

}



#Preview {
    ContentView()
}


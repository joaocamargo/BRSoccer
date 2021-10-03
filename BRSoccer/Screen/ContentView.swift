//
//  ContentView.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 28/09/21.
//

import SwiftUI
import Combine

struct ContentView: View{
    
    @State var stage = [Stage]()
    @State var leagues = [League]()
    @State var seasons = [Season]()
    @State var teams = [Team]()
    @State var isLoading = false
    
    
    var body: some View {
        NavigationView {
            ScrollView() {
                if isLoading {
                    VStack {
                        Text("Carregando times....").font(.system(size: 10, weight: .semibold))
                        ProgressView()
                    }.frame(height: 140)
                } else {
                    VStack(alignment: .trailing,spacing: 2) {
                        Text("Equipes da primeira divisão").font(.system(size: 10, weight: .semibold))
                        TeamLogosMenu(teams: teams).frame(height: 140)
                    }.padding()
                }
                UndergoingMatchesView()
            }
            .onAppear {
                isLoading = true
                TeamService.shared.getBrasilianFirstDivisionTeams() { result in
                    isLoading = false
                    switch result {
                    case .success(let teams):
                        print("Sucesso")
                        self.teams =  teams
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}


struct TeamLogosMenu: View {
    
    var teams: [Team]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                ForEach(teams) { teamItem in
                    
                    VStack(spacing: 10) {
                        ImageRow(model: teamItem)
                        Text("\(teamItem.shortCode)")
                    }
                }
            }.padding()
        }.navigationTitle("BRSoccer")
    }
}


struct UndergoingMatchesView: View {
    var body: some View {
        VStack{
            HStack {
                Text("Jogos de hoje").font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all").font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
                .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(0..<5, id: \.self) { num in
                        Spacer()
                            .frame(width: 125, height: 150)
                            .background(Color.gray)
                            .cornerRadius(5)
                            .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

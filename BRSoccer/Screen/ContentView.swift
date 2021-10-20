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
                        Text("Equipes da primeira divisão").font(.system(size: 12, weight: .semibold))
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
            }.navigationTitle("BRSoccer")
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
        }
    }
}


struct UndergoingMatchesView: View {
    
    @State var matches = [Match]()
    
    var body: some View {
        VStack{
            HStack {
                Text("Jogos de hoje").font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all").font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
                .padding(.top)
            
            ScrollView(.horizontal) {
                if matches.count > 0 {
                    HStack(spacing: 8) {
                        ForEach(matches.sorted(by: { $0.matchDate < $1.matchDate})) { match in
                            VStack(alignment: .center){
                                
                                HStack(alignment: .center,spacing: 0) {
                                    VStack {
                                        RemoteImage(imageUrl: match.homeTeam.logo,width: 80, height: 80)
                                        Text("\(match.stats.homeScore)")
                                            .font(.system(size: 26, weight: .bold)).shadow(color: .black, radius: 1)
                                            .padding(.horizontal, 1)
                                            .frame(alignment: .leading)

                                    }
                                    
                                    VStack {
                                        Text("VS").fixedSize(horizontal: true, vertical: false).font(.system(size: 16, weight: .semibold)).shadow(color: .black, radius: 1)
                                    }.frame(width: 20, height: 20, alignment: .center)
                                    
                                    VStack {
                                        RemoteImage(imageUrl: match.awayTeam.logo,width: 80, height: 80)
                                        Text("\(match.stats.awayScore)")
                                            .font(.system(size: 26, weight: .bold)).shadow(color: .black, radius: 1)
                                            .padding(.horizontal, 1)
                                            .frame(alignment: .trailing)
                                    }
                                }//.padding(.bottom,10)
                                    .background(Image("grass").resizable().scaledToFill().opacity(0.6))
                                .padding(.horizontal,10)
                                
                                HStack(alignment: . lastTextBaseline){
                                    Text("\(match.venue.name)").frame(width: 90, alignment: .bottomLeading).lineLimit(3).font(.system(size: 12, weight: .medium))//.padding(.leading, 8)
                                    //Spacer()
                                    Text("\(match.matchStartDateTime)").frame(alignment: .trailing).frame(width: 60)//.padding(.trailing,4)
                                }.font(.system(size: 14, weight: .bold)).foregroundColor(.black)//.shadow(color: .black, radius: 1)
                                //.background(Color(.yellow))
                                    .padding(.horizontal, 5).padding(.bottom,5).padding(.top,1)
                            }
                            .frame(width: 180)
                            .background(Color.yellow)
                            .cornerRadius(5)
                            //.shadow(color: .gray, radius: 4, x: 0, y: 2)
                            .padding(.bottom)
                        }
                    }.padding(.horizontal)
                }
            }.onAppear {
                //isLoading = true
                MatchesService.shared.getAllMatchesOfADate(fatherId: LeagueEnum.Brasileirao, matchDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!) { result in
                    //isLoading = false
                    switch result {
                    case .success(let matches):
                        self.matches = matches
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
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

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

    
    var body: some View {
        
//        List(stage) { league in
//            Text("\(league.name)")
//        }
//        List(leagues) { league in
//            Text("\(league.name)")
//        }
//        List(seasons) { s in
//            Text("\(s.name)")
//        }
        List(teams) { s in
            HStack {
                ImageRow(model: s)
                Text(s.name)
            }
        }
        .onAppear {
            
//            SeasonService.shared.getAll(fatherId: 314) { result in
//                switch result {
//                case .success(let seasons):
//                    print("Sucesso")
//                    print("season \(seasons)")
//                    self.seasons = seasons
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//            
//            
//            SeasonService.shared.get(id: 496) { result in
//                switch result {
//                case .success(let result):
//                    print("RESULTADO DO GET \(result)")
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//            
//            
//            StageService.shared.getAll(fatherId: 25) { result in
//                switch result {
//                case .success(let stages):
//                    print("Sucesso")
//                    print("STAGES \(stages)")
//                    self.stage = stages
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//            
//            
//            StageService.shared.get(id: 3) { result in
//                switch result {
//                case .success(let result):
//                    print("RESULTADO DO GET \(result)")
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//            
//            
//            LeagueService.shared.getAll(fatherId: 25) { result in
//                switch result {
//                case .success(let leagues):
//                    print("Sucesso")
//                    print("LEAGUES \(leagues)")
//                    self.leagues = leagues
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//
//            LeagueService.shared.get(id: Championship.Brasileirao) { result in
//                switch result {
//                case .success(let result):
//                    print("RESULTADO DO GET \(result)")
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
         
            TeamService.shared.get(id: 8378) { result in
                switch result {
                case .success(let result):
                    print("RESULTADO DO GET \(result)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

            TeamService.shared.getAll(fatherId: 25) { result in
                switch result {
                case .success(let teams):
                    print("Sucesso")
                   // print("LEAGUES \(teams)")
                    self.teams =  teams
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

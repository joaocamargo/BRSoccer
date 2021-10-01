//
//  ContentView.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 28/09/21.
//

import SwiftUI

struct ContentView: View{
    
    @State var stage = [Stage]()
    @State var leagues = [League]()

    
    var body: some View {
        
        List(stage) { league in
            Text("\(league.name)")
        }
        List(leagues) { league in
            Text("\(league.name)")
        }
        .onAppear {
            StageService.shared.getAll(fatherId: 25) { result in
                switch result {
                case .success(let stages):
                    print("Sucesso")
                    print("STAGES \(stages)")
                    self.stage = stages
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            StageService.shared.get(id: 3) { result in
                switch result {
                case .success(let result):
                    print("RESULTADO DO GET \(result)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            LeagueService.shared.getAll(fatherId: 25) { result in
                switch result {
                case .success(let leagues):
                    print("Sucesso")
                    print("LEAGUES \(leagues)")
                    self.leagues = leagues
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            LeagueService.shared.get(id: 761) { result in
                switch result {
                case .success(let result):
                    print("RESULTADO DO GET \(result)")
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

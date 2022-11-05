//
//  MainView.swift
//  LatifiCounter
//
//  Created by Георгий Черемных on 04.11.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            Image("icon_latifi_pole")
            
            Text("main.icon_description", comment: "")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
            
            Text("\(viewModel.counter)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .animation(.easeIn(duration: 0.2))
                .padding()
            
            Text("main.title", comment: "")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
            
            Button(String(localized: "main.button")) {
                viewModel.increment()
            }.buttonStyle(.borderedProminent)
        }
    }
}

let kLatifiCounterKey = "kLatifiCounter"

extension MainView {
    
    @MainActor final class MainViewModel: ObservableObject {
        
        @Published var counter: Int
        private let userDefaults: UserDefaults
        
        init(userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.webviewlab.latificounter")!) {
            self.userDefaults = userDefaults
            self.counter = userDefaults.integer(forKey: kLatifiCounterKey)
        }
        
        func increment() {
            counter += 1
            userDefaults.set(counter, forKey: kLatifiCounterKey)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
}

//
//  ContentView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI
import CoreData

/*
 HauptView wo alles gesteuert wird
 
 QUELLEN:
 
 LOTTIE ANIMATION: - https://lottiefiles.com/ -> GIT: https://github.com/airbnb/lottie-ios
 CHARTS            - GIT: https://github.com/spacenation/swiftui-charts
 ICONS: Apple interne App für devoloper um auf symbole zuzugreifen (SF-Symbols)

 */
struct ContentView: View {
    //aktuelle view
    @State var selectedView = 1
    
    var body: some View {
        //Tabview mit 3 HauptViews die einzelenen hauptviews sind getagt mit einem Int um genau zu wissen welche view gerade geöffnet ist
        TabView(selection: $selectedView) {
            //HAUPTVIEW 1
            NavigationView {
                WorkoutView(triggerView: $selectedView)
                    
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                VStack{
                    Image(systemName: "hexagon")
                    Text("Workout")
                }
            }
            .tag(1)

            //HAUPTVIEW 2
            NavigationView {
                PlanView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                VStack{
                    Image(systemName: "chart.bar.doc.horizontal.fill")
                    Text("Plan")
                }
            }
            .tag(2)

            //HAUPTVIEW 3
            NavigationView {
                ProgressView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                VStack{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Progress")
                }
            }
            .tag(3)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

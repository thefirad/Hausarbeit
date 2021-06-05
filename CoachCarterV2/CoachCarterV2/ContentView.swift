//
//  ContentView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 17.05.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],animation: .default) private var workouts: FetchedResults<Workout>

    var body: some View {
        TabView {
                NavigationView {
                    WorkoutView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    VStack{
                        Image(systemName: "person")
                        Text("Workout")
                    }
                }
                NavigationView {
                    ProgressView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    VStack{
                        Image(systemName: "person")
                        Text("Progress")
                    }
                }
            }
        }
    }
  

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

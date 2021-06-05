//
//  ProgressView.swift
//  FitnessTracker
//
//  Created by Firat Ak on 11.05.21.
//

import SwiftUI
import CoreData

struct ProgressView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],animation: .default) private var workouts: FetchedResults<Workout>
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("background").edgesIgnoringSafeArea(.all)
                
                VStack {
                    ForEach(workouts, id: \.self) { training in
                        PlanView(workoutName: training.wrappedWorkout)
                            .onTapGesture {
                                viewContext.delete(training)
                                try! viewContext.save()
                            }
                        
                        ForEach(training.exerciseArray, id: \.self) { ex in
                            ExerciseView(name: ex.wrappedExerciseName, weight: ex.weight, reps: ex.reps, sets: ex.sets)
                                .onTapGesture {
                                    ex.workout?.removeFromWorkouts(ex)
                                    try! viewContext.save()
                                }
                        }
                        
                    }
                }
                
                
                
                //.navigationBarTitle("Progress")
            }
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

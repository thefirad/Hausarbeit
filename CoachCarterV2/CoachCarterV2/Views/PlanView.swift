//
//  ProgressView.swift
//  FitnessTracker
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI
import CoreData

struct PlanView: View {
    //Datenbank objekt zum löschen/hinzufügen von objekten
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],animation: .default) private var workouts: FetchedResults<Workout>
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("background").edgesIgnoringSafeArea(.all)
                
                VStack {
                    //Liste aller Workouts mit ihren Übungen
                    ForEach(workouts, id: \.self) { training in
                        WorkoutNameView(workoutName: training.wrappedWorkout)
                            //Löscht ein Workout beim längeren drücken
                            .onLongPressGesture {
                                viewContext.delete(training)
                                try! viewContext.save()
                            }
                        
                        ForEach(training.exerciseArray, id: \.self) { ex in
                            ExerciseView(name: ex.wrappedExerciseName, weight: ex.weight, reps: ex.reps, sets: ex.sets)
                                //Löscht eine Übung  beim längeren drücken
                                .onLongPressGesture {
                                    ex.workout?.removeFromWorkouts(ex)
                                    try! viewContext.save()
                                }
                        }
                        
                    }
                }
                .padding(.top, 30)
            }
        }
        .navigationBarTitle("Plan 📓")
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}

//
//  AddExerciseView.swift
//  Fitness
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI

struct AddExerciseView: View {
    //Datenbank objekt zum löschen/hinzufügen von objekten
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],animation: .default) private var workouts: FetchedResults<Workout>
    
    //Schließe diese View
    @Binding var closeView: Bool
    
    //Platzhalter für die einzelenen Eingabewerte
    @State var exerciseName: String = ""
    @State var weight: Double = 20
    @State var reps: Int16 = 8
    @State var sets: Int16 = 3
    @State var workoutName = ""
    
    //Aktuelle View entweder Exercise = 0 oder Workout = 1
    @State var currentView: Int = 0
    
    //Array für alle hinzugefügten Übungen
    @State var exerciseArray: [Exercise] = []
    
    // trigger für exercise message
    @State var isAdded: Bool = false
    
    // trigger für workout name messsage
    @State var isWorkoutEmpty: Bool = false
    
    //Wird überwacht um nach dem workout hinzufügen zu einer anderen view wechselt
    @Binding var triggerView: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                //Überschrift
                HStack {
                    Text("Create")
                        .foregroundColor(.primary)
                        .font(.system(size: 34, weight: .bold, design: .default))
                        .padding(.leading)
                        .padding(.top, 20)
                    
                    Spacer()
                }
                
                
                //View auswahl Exercise/Workout
                Picker("", selection: $currentView) {
                    Text("Exercise").tag(0)
                    Text("Workout").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if currentView == 0 {
                    
                    //Einzelne Eingabefelder
                    VStack(alignment: .leading) {
                        Text("Exercise Name")
                            .font(.callout)
                            .bold()
                        TextField("Enter username...", text: $exerciseName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding([.leading, .trailing])
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Weight (Kg)")
                            .font(.callout)
                            .bold()
                        TextField("Enter username...", value: $weight, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding([.leading, .trailing])
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Reps")
                            .font(.callout)
                            .bold()
                        TextField("Enter username...", value: $reps, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding([.leading, .trailing])
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Sets")
                            .font(.callout)
                            .bold()
                        TextField("Enter username...", value: $sets, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding([.leading, .trailing])
                    
                    
                    Spacer()
                    
                    //Übernimmt die eingaben und speichert eine Exercise in dem Exercise array
                    Button(action: {
                        withAnimation {
                            let ex = Exercise(context: viewContext)
                            ex.name = exerciseName
                            ex.weight = weight
                            ex.reps = reps
                            ex.sets = sets
                            
                            //array methode zum hinzufügen von objekten
                            exerciseArray.append(ex)
                            
                            //trigger für nachricht
                            isAdded = true
                            
                            //methode zum verschwinden der nachricht ( 1.5 sec )
                            removeAddedExercise()
                        }
                    }) {
                        HStack {
                            Text("Add Exercise to Workout")
                                .fontWeight(.semibold)
                        }
                        .frame(minWidth: 200)
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(13)
                    }
                    
                } else {
                    /*
                     WORKOUTVIEW SHEET
                     */
                    VStack {
                        Text("\(workoutName) Workout")
                            .font(.callout)
                            .bold()
                        TextField("Name your Workout..", text: $workoutName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.leading, .trailing])
                        
                        //Eine for schleifen die alle Objekte im Exercisearray durchgeht und sie anzeigt
                        VStack(alignment: .leading) {
                                ForEach(exerciseArray) { ex in
                                    
                                    //Extra View zum anzeigen einer Exercise
                                    ExerciseView(name: ex.wrappedExerciseName, weight: ex.weight, reps: ex.reps, sets: ex.sets)
                                    Divider()
                                        .padding(5)
                                }
                        }
                        
                        
                        Spacer()
                        
                        //Button zum speichern eines Workouts
                        Button(action: {
                            
                            //ÜBERPRÜFUNG ob workoutname leer ist falls ja dann message falls nein dann speichern
                            if workoutName.isEmpty {
                                
                                //message triggern
                                isWorkoutEmpty.toggle()
                                //message löschen (2.5 sec)
                                removeWorkoutMessage()
                                
                            } else {
                                //Workout objekt erstellen und speichern
                                let workout = Workout(context: viewContext)
                                workout.name = workoutName
                                workout.date = Date()
                                
                                workout.addToWorkouts(NSSet(array: exerciseArray))
                                
                                try! viewContext.save()
                                
                                closeView = false
                                
                                //leere exercise arr nach erfolgreichen hinzufügen des Workouts
                                exerciseArray = []
                                
                                //Springt nach Plan
                                triggerView = 2
                            }
                            
                            
                        }, label: {
                            HStack {
                                Text("Add Workout")
                                    .fontWeight(.semibold)
                            }
                            .frame(minWidth: 200)
                            .padding()
                            .foregroundColor(.primary)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(13)
                            
                        })
                    }
                    
                }
            }
            
            /*
             Hier kommt die  message für exercise eingefügt
             */
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width - 100, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Exercise added to Workout")
            }
            .offset(x: isAdded ? 0 : -400, y: -150)
            .opacity(isAdded ? 1 : 0)
            
            
            /*
             Hier kommt die error message für kein workout name
             */
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.red.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width - 100, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Fill out Workoutname")
            }
            .offset(x: isWorkoutEmpty ? 0 : -400, y: -200)
            .opacity(isWorkoutEmpty ? 1 : 0)
        }
    }
    
    
    /*
     Funktionen
     */
    
     func removeAddedExercise() {
            // Delay of 1.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isAdded = false
                }
            }
        }
    
    func removeWorkoutMessage() {
           // Delay of 1.5 seconds
           DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
               withAnimation {
                   isWorkoutEmpty = false
               }
           }
       }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(closeView: .constant(true), triggerView: .constant(1))
            .preferredColorScheme(.dark)
    }
}

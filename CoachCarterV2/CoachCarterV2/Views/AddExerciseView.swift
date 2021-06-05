//
//  AddExerciseView.swift
//  Fitness
//
//  Created by Firat Ak on 11.05.21.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],animation: .default) private var workouts: FetchedResults<Workout>
    
    @State var exerciseName: String = ""
    @State var weight: Double = 20
    @State var reps: Int16 = 8
    @State var sets: Int16 = 3
    
    @State var workoutName = ""
    
    @State var currentView: Int = 0
    
    @State var arr: [Exercise] = []
    
    @State var isAdded: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                HStack {
                    Text("Create")
                        .foregroundColor(.primary)
                        .font(.system(size: 34, weight: .bold, design: .default))
                        .padding(.leading)
                        .padding(.top, 20)
                    
                    Spacer()
                }
                
                
                Picker("", selection: $currentView) {
                    Text("Exercise").tag(0)
                    Text("Workout").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if currentView == 0 {
                    
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
                    
                    Button(action: {
                        withAnimation {
                            let ex = Exercise(context: viewContext)
                            ex.name = exerciseName
                            ex.weight = weight
                            ex.reps = reps
                            ex.sets = sets
                            
                            arr.append(ex)
                            
                            isAdded = true
                            
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
                    
                    VStack {
                        Text("\(workoutName) Workout")
                            .font(.callout)
                            .bold()
                        TextField("Name your Workout..", text: $workoutName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.leading, .trailing])
                        
                        //                    ForEach(workouts, id: \.self) { training in
                        //                        Section(header: Text(training.wrappedWorkout)) {
                        //                            ForEach(training.exerciseArray, id: \.self) { ex in
                        //                                Text("Exercise: \(ex.wrappedExerciseName)")
                        //                            }
                        //                        }
                        //                    }
                        
                        
                        VStack(alignment: .leading) {
                                ForEach(arr) { ex in
                                    ExerciseView(name: ex.wrappedExerciseName, weight: ex.weight, reps: ex.reps, sets: ex.sets)
                                    Divider()
                                        .padding(5)
                                }
                        }
                        
                        
                        Spacer()
                        
                        Button(action: {
                            let workout = Workout(context: viewContext)
                            workout.name = workoutName
                            workout.date = Date()
                            
                            workout.addToWorkouts(NSSet(array: arr))
                            
                            
                            
                            try! viewContext.save()
                            
                            //leere array fpr neue übung
                            arr = []
                            
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
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width - 100, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Exercise added to Workout")
            }
            .offset(x: isAdded ? 0 : -400, y: -150)
            .opacity(isAdded ? 1 : 0)
        }
    }
    
     func removeAddedExercise() {
            // Delay of 7.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isAdded = false
                }
            }
        }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView()
            .preferredColorScheme(.dark)
    }
}

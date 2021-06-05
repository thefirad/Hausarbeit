//
//  WorkoutView.swift
//  FitnessTracker
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI

/*
 Start view der APP
 */
struct WorkoutView: View {
    //Öffnet sheet zum erstellen eines workouts
    @State var isOpen: Bool = false
    
    //Überwacht aktuelle Tabview und gibt es an AddExerciseView weiter um nach dem workout hinzufügen auf die Plan view zu gelangen
    @Binding var triggerView: Int
    
    var body: some View {
        VStack {
            Spacer()
        
            //Framework um illustrationen einzufügen
            LottieView(filename: "curls", animate: .loop)
                .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            //button zum öffnen des Sheets
            Button(action: {
                withAnimation {
                    isOpen.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "plus")
                    
                    Text("Add Workout")
                        .fontWeight(.semibold)
                }
                .frame(minWidth: 200)
                .padding()
                .foregroundColor(.primary)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(13)
            }
        }
        .padding()
        .navigationBarTitle("Workout 🦾")
        
        //Hier wird ein sheet über die Aktuelle view gelegt
        .sheet(isPresented: $isOpen, content: {
            AddExerciseView(closeView: $isOpen, triggerView: $triggerView)
        })
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(triggerView: .constant(1))
    }
}

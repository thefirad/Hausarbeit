//
//  WorkoutView.swift
//  FitnessTracker
//
//  Created by Firat Ak on 11.05.21.
//

import SwiftUI

struct WorkoutView: View {
    @State var isOpen: Bool = false
    
    
    var body: some View {
        VStack {
            Spacer()
            
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
        .navigationBarTitle("Workout")
        .sheet(isPresented: $isOpen, content: {
            AddExerciseView()
        })
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}

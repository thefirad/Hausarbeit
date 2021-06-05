//
//  ExerciseView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI

/*
 Anzeige Helfer um eine View zusammenzubauen
 */
struct ExerciseView: View {
    let name: String
    let weight: Double
    let reps: Int16
    let sets: Int16
    
    var body: some View {
        VStack {
            HStack {
                Text("\(name)  -  \(weight, specifier: "%.2f") KG  -  \(reps) x \(sets)")
            }
            .padding()
            
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(name: "Bein Presse", weight: 106.25, reps: 12, sets: 4)
    }
}

//
//  PlanView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI


/*
 Anzeige Helfer um eine View zusammenzubauen
 */
struct WorkoutNameView: View {
    let workoutName: String
    
    var body: some View {
        VStack {
            Text("\(workoutName)")
                .font(.custom("Arial Rounded MT Bold", size: 28))
            Divider()
                .padding([.leading, .trailing])
            
        }
    }
}

struct WorkoutNameView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutNameView(workoutName: "Chest")
    }
}

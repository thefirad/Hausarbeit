//
//  PlanView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 17.05.21.
//

import SwiftUI

struct PlanView: View {
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

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(workoutName: "Chest")
    }
}

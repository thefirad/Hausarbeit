//
//  Exercise+CoreDataProperties.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var reps: Int16
    @NSManaged public var sets: Int16
    @NSManaged public var workout: Workout?
    
    public var wrappedExerciseName: String {
        name ?? "Unknown Exercise"
    }

}

extension Exercise : Identifiable {

}

//
//  Workout+CoreDataProperties.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 17.05.21.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var workouts: NSSet?

    
    public var wrappedWorkout: String {
        name ?? "Unknown Workout"
    }
    
    public var exerciseArray: [Exercise] {
        let set = workouts as? Set<Exercise> ?? []
        
        return set.sorted {
            $0.wrappedExerciseName < $1.wrappedExerciseName
        }
    }
}

// MARK: Generated accessors for workouts
extension Workout {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: Exercise)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: Exercise)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}

extension Workout : Identifiable {

}

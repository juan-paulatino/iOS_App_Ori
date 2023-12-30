import SwiftUI

struct Exercise {
    var name: String
    var description: String
}

struct ContentView: View {
    @State private var selectedRoutineIndex = 0

    let routines = ["Full Body Workout", "Cardio", "Upper Body", "Lower Body"]

    var exercises: [String: [Exercise]] = [
        "Full Body Workout": [
            Exercise(name: "Squats", description: "Works legs and glutes"),
            Exercise(name: "Push-ups", description: "Targets chest and triceps"),
            Exercise(name: "Rows", description: "Strengthens upper back"),
        ],
        "Cardio": [
            Exercise(name: "Running", description: "Improves cardiovascular health"),
            Exercise(name: "Jump Rope", description: "Burns calories and improves agility"),
            Exercise(name: "Cycling", description: "Cardiovascular exercise for legs"),
        ],
        "Upper Body": [
            Exercise(name: "Bench Press", description: "Builds chest and triceps"),
            Exercise(name: "Pull-ups", description: "Strengthens upper back and arms"),
            Exercise(name: "Shoulder Press", description: "Targets shoulders and triceps"),
        ],
        "Lower Body": [
            Exercise(name: "Deadlifts", description: "Works lower back and hamstrings"),
            Exercise(name: "Lunges", description: "Targets quads and glutes"),
            Exercise(name: "Calf Raises", description: "Strengthens calves"),
        ],
    ]

    let motivationalQuotes = [
        "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
        "The only bad workout is the one that didn't happen.",
        "Your body can stand almost anything. It's your mind that you have to convince.",
        "The only limit to our realization of tomorrow will be our doubts of today.",
    ]

    @State private var showMotivationalQuote = false

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                // Main Content
                VStack {
                    // Workout Selection
                    Form {
                        Section(header: Text("Select Routine")) {
                            Picker("Routine", selection: $selectedRoutineIndex) {
                                ForEach(0..<routines.count) {
                                    Text(self.routines[$0])
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }

                        Section {
                            Text("Selected Routine: \(routines[selectedRoutineIndex])")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()

                    // Dynamic Workout Display
                    VStack {
                        Text("Today's Workout")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        // Display Exercises for the Selected Routine
                        if let selectedRoutine = routines[selectedRoutineIndex],
                           let routineExercises = exercises[selectedRoutine] {
                            ForEach(routineExercises, id: \.name) { exercise in
                                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                    HStack {
                                        Text(exercise.name)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(15)
                    .padding()

                    // Motivational Quotes
                    Button(action: {
                        showMotivationalQuote.toggle()
                    }) {
                        Text("Show Motivational Quote")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()

                    if showMotivationalQuote {
                        Text(motivationalQuotes.randomElement() ?? "")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                            .padding()
                    }

                    Spacer()
                }
            }
            .navigationBarTitle("Oriana Coach Gym App", displayMode: .inline)
        }
    }
}

struct ExerciseDetailView: View {
    var exercise: Exercise

    var body: some View {
        VStack {
            Text(exercise.name)
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text(exercise.description)
                .foregroundColor(.black)
                .padding()

            Spacer()
        }
        .navigationBarTitle(exercise.name, displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extension to safely access array indices
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

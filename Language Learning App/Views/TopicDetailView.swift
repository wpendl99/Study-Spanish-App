//
//  TopicDetailView.swift
//  Language Learning App
//
//  Created by William Pendleton on 10/24/24.
//

import SwiftUI

struct TopicDetailView: View {
    @ObservedObject var progressManager = ProgressManager.shared
    @State var topic: Topic
    
    var body: some View {
        VStack(spacing: 20) {
            Text(topic.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .bold()
                .padding()
            
            NavigationLink(destination: LessonView(topic: topic)) {
                OptionButton(
                    title: "Read Lesson",
                    completed: ProgressManager.shared.isLessonRead(for: topic.id)
                )
            }
            
            NavigationLink(destination: FlashcardsView(topic: topic)) {
                OptionButton(
                    title: "Practice Flashcards",
                    completed: ProgressManager.shared.isFlashcardsCompleted(for: topic.id)
                )
            }
            
            NavigationLink(destination: QuizView(topic: topic)) {
                OptionButton(
                    title: "Take Quiz",
                    completed: ProgressManager.shared.isQuizCompleted(for: topic.id)
                )
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if progressManager.didChangeFlag {
                progressManager.resetDidChangeFlag()
            }
        }
    }
}

struct OptionButton: View {
    let title: String
    let completed: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            if completed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    TopicDetailView(topic: SampleData.sampleTopic)
}

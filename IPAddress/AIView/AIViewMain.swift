////
////  AIViewMain.swift
////  IPAddress
////
////  Created by Jimmy Zhao on 2025/06/27.
////
//
//import FoundationModels
//import SwiftUI
//
//@available(iOS 26.0, *)
//@Generable
//struct KeyPoint {
//    let title: String
//    let content: String
//}
//
//@available(iOS 26.0, *)
//@Generable
//struct ArticleSummary {
//    let summaryLanguage: String
//    
//    @Guide(.minimumCount(3))
//    let keyPoints: [KeyPoint]
//    
//    @Guide(description: "Each tag should be short and distinct", .count(3))
//    let tags: [String]
//}
//
//
//@available(iOS 26.0, *)
//struct AIViewMain: View {
//    @State private var articleSummary: ArticleSummary.PartiallyGenerated?
//    @State private var tags: [String] = []
//    
//    var body: some View {
//        ScrollView {
//            Button("生成 Foundation Models 解釋", action: generateResponse)
//                .font(.title2.bold())
//                .buttonStyle(.bordered)
//                .padding()
//            
//            let keyPoints = articleSummary?.keyPoints ?? []
//            ForEach(keyPoints) { keyPoint in
//                VStack {
//                    if let title = keyPoint.title {
//                        Text(title)
//                            .font(.title2.weight(.semibold))
//                            .foregroundStyle(.indigo)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    
//                    if let content = keyPoint.content {
//                        Text(content)
//                            .font(.title3)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                }
//                .multilineTextAlignment(.leading)
//                .padding(.bottom, 32)
//            }
//            
//            HStack {
//                let tags = articleSummary?.tags ?? []
//                ForEach(tags.indices, id: \.self) { index in
//                    let tag = tags[index]
//                    Text(tag)
//                        .font(.body)
//                        .padding(8)
//                        .background(Color.indigo.gradient.tertiary,
//                                    in: .capsule)
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//        .contentMargins(16, for: .scrollContent)
//    }
//    
//    func generateResponse() {
//        Task {
//            let session = LanguageModelSession(
//                instructions: "Your job is to summarize articles for a 5-year-old. Keep your summarization engaging and practical. You MUST use this locale: zh_Hant_TW"
//            )
//            
//            do {
//                let stream = session.streamResponse(
//                    to: """
//    The Foundation Models framework provides access to Apple’s on-device large language model that powers Apple Intelligence to help you perform intelligent tasks specific to your use case. The text-based on-device model identifies patterns that allow for generating new text that’s appropriate for the request you make, and it can make decisions to call code you write to perform specialized tasks.
//    
//    Generate text content based on requests you make. The on-device model excels at a diverse range of text generation tasks, like summarization, entity extraction, text understanding, refinement, dialog for games, generating creative content, and more.
//    
//    Generate entire Swift data structures with guided generation. With the @Generable macro, you can define custom data structures and the framework provides strong guarantees that the model generates instances of your type.
//    
//    To expand what the on-device foundation model can do, use Tool to create custom tools that the model can call to assist with handling your request. For example, the model can call a tool that searches a local or online database for information, or calls a service in your app.
//    
//    To use the on-device language model, people need to turn on Apple Intelligence on their device. For a list of supported devices, see Apple Intelligence.
//    
//    For more information about acceptable usage of the Foundation Models framework, see Acceptable use requirements for the Foundation Models framework.
//    """,
//                    generating: ArticleSummary.self
//                )
//                for try await partialResponse in stream {
//                    self.articleSummary = partialResponse
//                }
//            } catch {
//                print("❌ error: \(error.localizedDescription)")
//            }
//        }
//    }
//}

//
//  ContentView.swift
//  AutoTranslate
//
//  Created by James Clarke on 1/4/25.
//

import SwiftUI
import Translation


struct ContentView: View {
    enum TranslationState {
        case waiting, creating, done
    }
    
    @State private var input = "Hello, world!"
    
    @State private var languages = [
        Language (id:
                    "ar", name:
                    "Arabic", isSelected:
                    false),
        Language (id:
                    "tr", name:
                    "Turkish", isSelected:
                    false),
        Language (id:
                    "uk", name:
                    "Ukrainian", isSelected:
                    false)
    ]
    
    @State private var configuration = TranslationSession.Configuration(source: Locale.Language(identifier: "en"), target: Locale.Language(identifier: "es"))
    
    @State private var translatingLanguages = [Language]()
    
    @State private var translationState: TranslationState = .waiting
    
    @State private var languageIndex = 0
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                Form {
                    ForEach($languages) {
                        $language in
                        Toggle(language.name, isOn: $language.isSelected)
                    }
                }
            }
        } detail: {
            TextEditor(text: $input)
                .font(.largeTitle)
                .translationTask(configuration, action: translate)
                .onChange(of: input) { oldValue, newValue in
                    configuration.invalidate()
                }
                .onChange(of: languages) { oldValue, newValue in
                    updateLanguages()
                }
            
            Button("create translations", action: createAllTranslations)
        }
    }
    
    func createAllTranslations() {
        translatingLanguages = languages.filter(\.isSelected)
        languageIndex = 0
        translationState = .creating
        doNextTranslation()
    }
    
    func translate(using session: TranslationSession) async {
        do {
            if translationState == .waiting {
                try await session.prepareTranslation()
            } else {
                let result = try await session.translate( input)
                print(result.targetText)
                
                languageIndex += 1
                doNextTranslation()
            }
        } catch {
            print(error.localizedDescription)
            translationState = .waiting
        }
    }
    
    func doNextTranslation() {
        guard languageIndex < translatingLanguages.count else {
            translationState = .done
            return
        }
        
        let language = translatingLanguages[languageIndex]
        configuration.source = Locale.Language(identifier: "en")
        configuration.target = Locale.Language(identifier: language.id)
        configuration.invalidate()
        
    }
    
    func updateLanguages(oldValue: [Language], newValue: [Language]) {
        let oldSet = Set(oldValue.filter(\.isSelected))
        let newSet = Set(newValue.filter(\.isSelected))
        let difference = newSet.subtracting(oldSet)
        
        if let newLanguage = difference.first {
            configuration.source = Locale.Language(identifier: newLanguage.id)
            configuration.invalidate()
        }
        
        translationState  = .waiting
    }
}

//#Preview {
//    ContentView()
//}

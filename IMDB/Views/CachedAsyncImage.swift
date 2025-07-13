//
//  CachedAsyncImage.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import SwiftUI

extension CachedAsyncImage {
    
    enum LoadingState {
        case initial, success(Image), loading, failed
        
        var isLoading: Bool {
            switch self {
            case .loading: return true
            case .initial, .failed, .success: return false
            }
        }
    }
}

/// Image that caches the remote images
struct CachedAsyncImage: View {
    private let url: URL?
    @State private var state: LoadingState = .initial

    public init(url: URL?) {
        self.url = url
    }

    public var body: some View {
        switch state {
            case .failed:
            Image.photoPlaceHolder
        case .success(let image):
            image
                .resizable()
                .scaledToFit()
        case .initial, .loading:
            ProgressView()
                .onAppear {
                    Task {
                        await loadImage()
                    }
                }
        }
    }

    private func loadImage() async {
        guard let url = url, !state.isLoading else { return }
        state = .loading

        // Check if the image is already cached
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            await MainActor.run {
                self.state = .success(Image(uiImage: cachedImage))
            }
            return
        }

        // Fetch the image from the network
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // Cache the image
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)

            if let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.state = .success(Image(uiImage: uiImage))
                }
            }
        } catch {
            // Handle any errors here (e.g., network failure)
            await MainActor.run {
                self.state = .failed
            }
        }
    }
}

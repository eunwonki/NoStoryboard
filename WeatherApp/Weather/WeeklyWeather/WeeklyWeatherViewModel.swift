import Combine
import SwiftUI

class WeeklyWeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var dataSource: [DailyWeatherRowViewModel] = []

    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    init(
        weatherFetcher: WeatherFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        $city
            .dropFirst(1) // 이게 뭐지?
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .map { $0.lowercased() } // 소문자로
            .sink(receiveValue: fetchWeather(forCity:))
            .store(in: &disposables)
    }

    private func fetchWeather(forCity city: String) {
        weatherFetcher.weeklyWeatherForecast(forCity: city)
            .map { response in
                response.list.map(DailyWeatherRowViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    // 성공 실패 여부에 상관없이 호출됨.
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    // 성공했을때만 호출됨.
                    guard let self = self else { return }
                    self.dataSource = forecast
                }
            )
            .store(in: &disposables)
    }
}

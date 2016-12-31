import Foundation
import Bond

class StopWatchViewModel {
    
    class Action {
        let description: String
        let enabled: Bool
        let `do`: () -> Void
        
        init(description: String, enabled: Bool, `do`: @escaping () -> Void = {}) {
            self.description = description
            self.enabled = enabled
            self.do = `do`
        }
    }
    
    let time = Observable<String>(StopWatchViewModel.string(fromInterval: TimeInterval(0)))
    let clearAction = Observable<Action>(Action(description: "Clear", enabled: false))
    let mainAction = Observable<Action>(Action(description: "Start", enabled: true))
    
    private let stopWatch = StopWatch()
    
    init() {
        stopWatch.time
            .map{ (time: TimeInterval) -> String in
                return StopWatchViewModel.string(fromInterval: time) }
            .bind(to: time)
        
        // stopWatchの状態に応じてmainActionの状態を変更
        stopWatch.state
            .map{ (state: StopWatch.State) -> Action in
                return self.getMainAction(fromState: state) }
            .bind(to: mainAction)
        
        // stopWatchの状態に応じてclearActionの状態を変更
        stopWatch.state
            .map{ (state: StopWatch.State) -> Action in
                return self.getClearAction(fromState: state) }
            .bind(to: clearAction)
    }
    
    // StopWatchが示す時間をView用に加工する
    private static func string(fromInterval interval: TimeInterval) -> String {
        let centiSecond = Int(interval * 100) % 100
        let second = Int(interval) % 60
        let minutes = Int(interval / 60) % 60
        let hour = Int(interval / 3600) % 100
        return String(format: "%02i:%02i:%02i.%02i", hour, minutes, second, centiSecond)
    }
    
    private func getMainAction(fromState state: StopWatch.State) -> Action {
        let start: () -> Void = {
            self.stopWatch.start()
        }
        
        let stop: () -> Void = {
            self.stopWatch.stop()
        }
        
        let resume: () -> Void = {
            self.stopWatch.resume()
        }
        
        switch state {
        case .startable:
            return Action(description: "Start", enabled: true, do: start)
        case .stoppable:
            return Action(description: "Stop", enabled: true, do: stop)
        case .resumable:
            return Action(description: "Resume", enabled: true, do: resume)
        }
    }
    
    private func getClearAction(fromState state: StopWatch.State) -> Action {
        let clear: () -> Void = {
            self.stopWatch.clear()
        }
        
        let disabledAction = Action(description: "Clear", enabled: false, do: {})
        
        switch state {
        case .startable:
            return disabledAction
        case .stoppable:
            return disabledAction
        case .resumable:
            return Action(description: "Clear", enabled: true, do: clear)
        }
    }
}

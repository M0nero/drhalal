//
//  Logs.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import SwiftyBeaver

final public class Log {
    private static let log: SwiftyBeaver.Type = {
        let beaver = SwiftyBeaver.self

        let console = ConsoleDestination()
        console.minLevel = .verbose
        beaver.addDestination(console)
        return beaver
    }()
    
    private static func object(_ message: Any = "", thread: Bool) -> Any {
        thread ? "\(String(describing: Thread.current.name))\n\(message)" : message
    }
    public static func error(_ message: Any = "",
                             thread: Bool = false,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line,
                             _ context: Any? = nil) {
        log.error(object(message, thread: thread), file: file, function: function, line: line, context: context)
    }
    
    public static func warning(_ message: Any = "",
                               thread: Bool = false,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line,
                               _ context: Any? = nil) {
        log.warning(object(message, thread: thread), file: file, function: function, line: line, context: context)
    }
    
    public static func info(_ message: Any = "",
                            thread: Bool = false,
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: Int = #line,
                            _ context: Any? = nil) {
        log.info(object(message, thread: thread), file: file, function: function, line: line, context: context)
    }
    
    public static func debug(_ message: Any = "",
                             thread: Bool = false,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line,
                             _ context: Any? = nil) {
        log.debug(object(message, thread: thread), file: file, function: function, line: line, context: context)
    }
    
    public static func verbose(_ message: Any = "",
                               thread: Bool = false,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line,
                               _ context: Any? = nil) {
        log.verbose(object(message, thread: thread), file: file, function: function, line: line, context: context)
    }
}

extension Log {
    static func log(for request: URLRequest) {
        var requestString = ""
        let httpMethod = request.httpMethod ?? ""
        
        if let url = request.url {
            requestString += "--> \(httpMethod): \(url)\n"
        }
        
        if let allHTTPHeaderFields = request.allHTTPHeaderFields {
            for (key, value) in allHTTPHeaderFields {
                requestString += "\(key): \(value)\n"
            }
        }
        
        if let stringBody = request.httpBody?.prettyPrintedJSONString() {
            requestString += stringBody + "\n"
        }
        
        requestString += "--> END \(httpMethod)"
        
        self.verbose(requestString, thread: true)
    }
    
    static func log(response: HTTPURLResponse?,
                    data: Data?,
                    error: Error?,
                    startRequestTime: Date,
                    endRequestTime: Date) {
        
        if let error = error {
            Log.error("<-- Status code \(response?.statusCode ?? 0), \(error)", thread: true)
            return
        }
        
        guard let response = response else { return }
        
        let executionTime = String(format: "%.0f", endRequestTime.timeIntervalSince(startRequestTime) * 1_000)
        var responseString = ""
        responseString += "<-- HTTPS, Status code \(response.statusCode) "
        responseString += "\(response.url?.absoluteString ?? "") (\(executionTime) ms)\n"
        
        for (key, value) in response.allHeaderFields {
            responseString += "\(key): \(value)\n"
        }
        
        if let stringBody = data?.prettyPrintedJSONString() {
            responseString += stringBody + "\n"
        }
        
        responseString += "<-- END HTTPS\n"
        
        Log.info(responseString, thread: true)
    }
}

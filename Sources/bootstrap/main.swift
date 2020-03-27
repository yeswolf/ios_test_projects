import Foundation

func exists(url: URL) throws -> Bool {
    let req = NSMutableURLRequest(url: url)
    req.httpMethod = "HEAD"
    req.timeoutInterval = 3.0 // Adjust to your needs

    var response: URLResponse?
    try NSURLConnection.sendSynchronousRequest(req as URLRequest, returning: &response)

    return ((response as? HTTPURLResponse)?.statusCode ?? -1) == 200
}

func shell(_ command: String) {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]

    let pipe = Pipe()
    task.standardOutput = pipe

    pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: pipe.fileHandleForReading, queue: nil) {
        notification in
        let output = pipe.fileHandleForReading.availableData
        let outputString = String(data: output, encoding: String.Encoding.utf8) ?? ""
        if outputString != "" {
            print(outputString, terminator: "")
        }
        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    }

    task.launch()
    task.waitUntilExit()
}

enum ProjectType {
    case hmm, large, medium, small
}

enum ProjectLanguage {
    case objc, swift
}

class Project {
    var type: ProjectType
    var name: String
    var root: String
    var lang: ProjectLanguage
    var setupCommands: [String]
    var serverRoot: String {
        get { "\(root.lowercased())/\(name.lowercased())" }
    }

    var targetRoot: String {
        get { "\(type)/\(lang)/\(name.lowercased())" }
    }

    init(type: ProjectType, name: String, root: String, lang: ProjectLanguage, setup: [String] = []) {
        self.type = type
        self.name = name
        self.root = root
        self.lang = lang
        self.setupCommands = setup
    }

    func github() -> URL? {
        URL(string: "https://github.com/\(serverRoot).git")
    }


    func clone() {
        shell("git clone --recursive https://github.com/\(root)/\(name).git \(targetRoot)")
    }

    func setup() {
        var result = "cd \(targetRoot)"
        for command in self.setupCommands {
            result += " && " + command
        }
        print(result)
        shell(result)
    }
}

var projects: [Project] =
        [
            Project(type: .hmm, name: "openemu", root: "OpenEmu", lang: .objc),
            Project(type: .large, name: "eidolon", root: "artsy", lang: .swift,
                    setup: [
                        "bundle install",
                        "bundle exec fastlane oss",
                    ]
            ),
            Project(type: .large, name: "wwdc", root: "insidegui", lang: .swift,
                    setup: [
                        "./bootstrap.sh"
                    ]
            ),
            Project(type: .large, name: "focus-ios", root: "mozilla-mobile", lang: .swift,
                    setup: [
                        "./checkout.sh"
                    ]
            ),
            Project(type: .large, name: "wordpress-ios", root: "wordpress-mobile", lang: .swift,
                    setup: ["rake dependencies"]
            ),
            Project(type: .medium, name: "alamofire", root: "Alamofire", lang: .swift),
            Project(type: .medium, name: "onionbrowser", root: "OnionBrowser", lang: .swift,
                    setup: [
                        "rm -rf Carthage/",
                        "brew install automake libtool",
                        "git checkout 2.X",
                        "pod repo update",
                        "pod install",
                        "carthage update --platform iOS",
                    ]),
            Project(type: .medium, name: "riot-ios", root: "vector-im", lang: .swift,
                    setup: [
                        "bundle install",
                        "bundle exec pod install",
                    ]),
            Project(type: .medium, name: "signal-ios", root: "signalapp", lang: .swift,
                    setup: [
                        "gem install cocoapods-binary"
                    ]),
            Project(type: .medium, name: "wire-ios", root: "wireapp", lang: .swift,
                    setup: [
                        "./setup.sh"
                    ]),
            Project(type: .medium, name: "sequelpro", root: "sequelpro", lang: .swift),
            Project(type: .small, name: "cocoaconferences-swiftui", root: "yeswolf", lang: .swift,
                    setup: [
                        "pod install"
                    ]),
            Project(type: .small, name: "xkcd", root: "paulrehkugler", lang: .swift),
        ]
print("Checking if all repos exist...")
for project in projects {
    let check = try exists(url: project.github()!)
    if !check {
        print("Repository \(project.github()!) does not exist")
    }
    project.clone()
    project.setup()
}

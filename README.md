# NYTimes Documentation

## Overview

The NYTimes project is a Swift-based iOS application that provides a user-friendly interface to consume articles and media content from The New York Times. The project is organized into several components, each serving a specific purpose, to maintain a clean and modular codebase.

## Recording

The video recording captures the `Listing` and `Detail` Screens in two phases.

In the initial exploration of the `Listing` and `Detail` Screens, the application operates without the `Debugger`. During the initial testing phase, upon shaking the device, the `Network Configuration` Screen surfaces, offering insights into each registered API. This information encompasses details such as host, endpoint, content type, request method (GET or POST), and the Response Data Model.

Upon expanding the configuration of any API, users can activate breakpoints by tapping on the "ignore" button within the `NetworkDataDebug` section. Here, `ignore` implies that the debugger will disregard the execution of this API. Activating the breakpoint transforms the status from `ignore` to `console` signifying that the debugger will halt the API execution and output information to the Console.

The `Console`, a dedicated screen, exhibits the `JSON` response in dynamically expandable/collapsible sections. Additionally, the Console provides an editing feature, empowering users to modify values within the returned Network `JSON` and submit these changes to the user interface.

 | **Application Recording** |
 | - |
 | <video src="https://github.com/syedqamara/NYTimes/assets/5058871/97b4db4a-8baa-4d3f-821f-b64bfe64d610"> </video> |



## Core Architecuture
To establish the core architecture of the application and streamline networking with debugging capabilities, I've incorporated my own custom library called `core_architecture`. You can find the library at the following link: [core_architecture](https://github.com/syedqamara/core_architecture.git).

This library introduces abstract layers for MVVM protocols, caching mechanisms, configurations, networking components, and a built-in debugger. The built-in debugger facilitates the observation of network requests within the application, providing a seamless debugging experience.

## Folder Structure

### 1. Application
 
 This folder contains the implementation of the application layer. It further have nested folders.
 
- **DataSources:** Contains data source implementations for fetching data from The New York Times API, including articles and images.

- **Factory:** Provides dependency injection and view factory components.

- **Modules:**
  - **Detail:** Implementation of the detailed view of an article, including its media content.
  - **List:** Implementation of the list view displaying a collection of articles.

### 2. Core
 
 This folder contains the abstract layer of application, defining mocks and mock architectures to make the application more testable. 
 
- **ApplicationCore:** Manages application-specific configurations and environments.

- **DataSources:** Implements services for fetching data from The New York Times API.
    ``` swift
    // NewYorkTimes API
    protocol NYTimesDataSourcing: DataSourcing {
        func mostViewedArticlesPublisher(days: Int) -> Future<[NYTArticle], Error>
    }
    // Image Downloader
    protocol NYTimesImageDataSourcing: DataSourcing {
        func image(for urlString: String) async throws -> Data
    }
    ```
- **Mock:** Contains mock implementations for data sources and view models, facilitating testing.

- **Models:** Defines data models used in the application.

- **Module:** Contains view models and views related to the application's modules.
  - **ViewModels**
    ``` swift
    public protocol NYTListViewModeling: ViewModeling {
        var isLoading: Bool { get }
        var error: String? { get }
        var articles: [NYTArticleUIM] { get }
        func onAppear()
    }
    ```
    ``` swift
    public protocol NYTDetailViewModeling: ViewModeling {
        var article: NYTArticleUIM? { get }
    }
    ```

- **Networking:** The project encompasses configurations and endpoints essential for initiating network requests to The New York Times API. To integrate any additional REST API with the application's network library, it is imperative to register the network configuration for each API prior to launching the application. Refer to the code snippet below for guidance on registering a network configuration professionally:
    ``` swift
    public struct NYTimesConfiguration {
        @Dependency(\.registerar) private var networkRegisterar
        public init() {}
        func config(name: String, endpoint: NYTimesEndpoint, responseModel: DataModelProtocol.Type,
            do {
                try self.networkRegisterar.networkRegister(name: name, host: NYTimesHost(), endpoint: endpoint, method: method, contentType: contentType, responseType: responseModel, cachePolicy: cachePolicy, headers: headers)
            }
            catch let err {
                fatalError("NYTimesConfiguration error \(err)")
            }
        }
    }
    ```

### 3. Helpers

- **Internet:** Provides utility functions for checking internet connectivity.

- **Lotties:** Manages animations using Lottie framework.

### 4. Reusables

- **Animated:** Contains reusable components for handling animations.

- **RemoteImage:** Implements a remote image view and its associated view model.

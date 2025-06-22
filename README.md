# isolation_test

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```
graph TD
    subgraph UI Layer
        A[PostsPage] -- User Interaction --> B(Add FetchPosts Event);
        B --> C{PostsBloc};
        C -- Emits States --> D[BlocBuilder];
        D -- Rebuilds UI --> E[Display List/Loading/Error];
    end

    subgraph BLoC Layer
        C -- Calls Method --> F[PostRepository];
    end

    subgraph Data Layer
        F -- Spawns Isolate --> G(Isolate Runner);
        G -- Executes --> H(Top-level fetch function);
        H -- Uses Dio --> I[JSONPlaceholder API];
        I -- Returns JSON --> H;
        H -- Returns Data --> G;
        G -- Sends Data to Main Isolate --> F;
        F -- Parses Data & Returns List<Post> --> C;
    end

    style A fill:#BDE0FE,stroke:#333,stroke-width:2px
    style E fill:#BDE0FE,stroke:#333,stroke-width:2px
    style C fill:#FFC8DD,stroke:#333,stroke-width:2px
    style F fill:#C8E6C9,stroke:#333,stroke-width:2px
    style H fill:#FFF2CC,stroke:#333,stroke-width:2px
    style I fill:#D1C4E9,stroke:#333,stroke-width:2px
```

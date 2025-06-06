# 🐶 Dogs

Dogs is a sample app created as part of a technical challenge for the iOS Developer position. The app displays a list of dogs with relevant information and supports local data storage to 
fulfill the offline persistence requirement.

---

## 🚀 Technologies Used

- **SwiftUI**
- **MVVM Architecture**
- **Core Data** for local persistence
- **XCTest** for unit testing

---

## 🔍 Main Features

### ✉️ Remote API
- Fetches a JSON list of dogs from a remote endpoint.

### 📂 Local Persistence
- On the first app launch, the data is fetched from the endpoint.
- The data is saved to **Core Data**.
- On subsequent launches, the data is loaded from local storage without requiring a network connection.

### 📐 Clean Architecture
- Clear separation of concerns across layers:
  - `DogDTO`: Network model
  - `Dog`: Domain model
  - `DogEntity`: Core Data model
  - `DogRemoteDataSource` & `DogLocalDataSource`
  - `DogRepositoryImpl` handles business logic
  - `DogListViewModel` bridges the view and data layers

### 🌐 Clean, Responsive UI
- SwiftUI-based layout with clean visuals
- Remote images loaded using `AsyncImage`
- Dog cards with rounded corners, clear text hierarchy, and shadows

---

## 📊 Unit Testing

Unit tests are written using `XCTest`, including:

- `DogListViewModelTests`: Verifies success/failure fetch logic.
- `DogLocalDataSourceTests`: Verifies saving and loading from Core Data.

---
![image](https://github.com/user-attachments/assets/4bd87fab-08a2-4f6e-a868-c050fd153e04)



![image](https://github.com/user-attachments/assets/3d2f68b5-cdea-4db8-94d5-3c264f30564f)


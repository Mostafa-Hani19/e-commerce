# 🛍️ Modern E-Commerce App (Flutter)

> A **production-ready**, high-performance e-commerce mobile application built with **Flutter**, **Riverpod**, and **Clean Architecture principles**.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-State_Management-purple?style=for-the-badge)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-success?style=for-the-badge)

---

## 📱 App Preview

<div align="center">
  <img src="images/Mockup/MockUp%20(1).png" height="400" alt="Home Screen Mockup" />
  <img src="images/Mockup/MockUp%20(2).png" height="400" alt="Product Details Mockup" />
  <img src="images/Mockup/MockUp%20(4).png" height="400" alt="Dark Mode Mockup" />
  <img src="images/Mockup/MockUp%20(5).png" height="400" alt="Profile Mockup" />
</div>

---

## 🎨 Themes

### ☀️ Light Theme
<div align="center">
  <img src="images/ScreenShouts/LightScreens/HomeScreen.png" width="200"/>
  <img src="images/ScreenShouts/LightScreens/ProductsScreen.png" width="200"/>
  <img src="images/ScreenShouts/LightScreens/ShopingCratScreen.png" width="200"/>
  <img src="images/ScreenShouts/LightScreens/SearchScreen.png" width="200"/>
</div>

### 🌙 Dark Theme
<div align="center">
  <img src="images/ScreenShouts/DarkScreens/image (6).png" width="200"/>
  <img src="images/ScreenShouts/DarkScreens/image (9).png" width="200"/>
  <img src="images/ScreenShouts/DarkScreens/image (3).png" width="200"/>
  <img src="images/ScreenShouts/DarkScreens/image (10).png" width="200"/>
</div>

---

## ✨ Key Features

### 🚀 Performance & Architecture
- **Riverpod State Management** with advanced optimizations:
  - State Splitting
  - Derived Providers
  - Minimal UI rebuilds
- **Lazy Loading (Infinite Scroll)** for products
- **IndexedStack Navigation** to keep tabs alive
- **Clean Architecture** with Repository Pattern
- **Immutable Models** with `copyWith`

---

### 🛍️ Shopping Experience
- Browse products by category
- Real-time search with debouncing
- Product details with image carousel
- Smart cart with:
  - Subtotal
  - Tax
  - Shipping
- Wishlist system (global & persistent)

---

### 💾 Offline Persistence
- **Cart Persistence** using `shared_preferences`
- **Wishlist Persistence**
- Full **JSON Serialization** (`toJson / fromJson`) for:
  - Product
  - CartItem
  - Rating

---

### 🌐 Networking & Stability
- **Dio HTTP Client**
- **Global Dio Interceptor** for:
  - 401 / 500 errors
  - No Internet handling
- Centralized error handling with global Snackbars
- Image caching with `cached_network_image`

---

### 🎨 UI / UX
- Modern, clean UI
- **Shimmer Skeletons** instead of loaders
- Smooth animations using `flutter_animate`
- Dark & Light themes with persistence
- Responsive layout for different screen sizes

---

### 👤 User Profile
- Dynamic profile data
- Settings & preferences
- Theme switching (saved locally)

---

## 🧠 Technical Highlights (Why This Project Matters)

✔ Production-ready architecture  
✔ Optimized performance (CPU & memory)  
✔ Scalable & maintainable codebase  
✔ Clear separation of concerns  
✔ Ready for real backend integration  

This project demonstrates **senior-level Flutter development practices**.

---

## � Project Structure

A Clean Architecture influenced structure for scalability:

```
lib/
├── core/                  # Core functionality & utilities
│   ├── constants/         # API endpoints, Strings, Colors
│   ├── network/           # Dio Client & Interceptors
│   ├── providers/         # Global Riverpod Providers (Cart, User, etc.)
│   ├── theme/             # App Theme Data (Light/Dark)
│   └── widgets/           # Shared reusable widgets (Shimmer, Buttons)
├── models/                # Data Models (Product, User, CartItem)
├── presentation/          # UI Layer
│   ├── screens/           # Application Screens
│   │   ├── home/          
│   │   ├── cart/          
│   │   ├── checkout/      
│   │   └── ...            
│   └── widgets/           # Screen-specific widgets
└── main.dart              # Entry point & App Configuration
```

---

## �🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | ![Flutter](https://img.shields.io/badge/-Flutter-02569B?logo=flutter&logoColor=white) |
| **Language** | ![Dart](https://img.shields.io/badge/-Dart-0175C2?logo=dart&logoColor=white) |
| **State Management** | **Flutter Riverpod** |
| **Networking** | **Dio** |
| **Persistence** | **Shared Preferences** |
| **Styling** | **Flutter Animate**, **Animate Do** |
| **Utilities** | **Cached Network Image**, **Flutter SVG** |

---

## 🚀 Getting Started

### 1️⃣ Clone the repository
```bash
git clone https://github.com/Mostafa-Hani19/ecommerce-app.git
```

### 2️⃣ Install dependencies
```bash
cd ecommerce
flutter pub get
```

### 3️⃣ Run the app
```bash
flutter run
```

---

## 🤝 Contributing

Contributions are welcome! If you have any suggestions or improvements:

1.  Fork the repository.
2.  Create a new branch: `git checkout -b feature/your-feature`.
3.  Commit your changes: `git commit -m 'Add some feature'`.
4.  Push to the branch: `git push origin feature/your-feature`.
5.  Submit a pull request.

---

## 📞 Contact

For any inquiries or feedback, please reach out:

*   **GitHub**: [Mostafa-Hani19](https://github.com/Mostafa-Hani19)

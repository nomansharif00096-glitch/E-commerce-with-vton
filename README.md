# 🛍️ AI Virtual Try-On E-Commerce System

An AI-powered full-stack e-commerce platform that allows users to virtually try on clothes before purchasing. This project combines modern web and mobile technologies with computer vision to enhance the online fashion shopping experience.

---

## 🚀 Tech Stack

### Frontend
- 📱 Flutter (Mobile Application)
- 🌐 React.js (Web Application)

### Backend
- ⚙️ NestJS (REST API)
- 🔐 JWT Authentication
- 🗄️ Database (MySQL,Hive,Cloudinary)

### AI Module
- 🤖 Virtual Try-On System

---

## 🎯 Features

### 👤 User (Buyer)
- User Registration & Login
- Browse Products
- Add to Cart & Checkout
- Virtual Try-On (Upload image / camera)
- Order History

### 🛍️ Seller
- Add / Update / Delete Products
- Manage Inventory
- View Orders

### 🛠️ Admin
- Manage Users & Sellers
- Monitor Platform Activity
- Analytics Dashboard

---

## 🧠 Virtual Try-On (Core Feature)

The AI module allows users to visualize clothing items on their own images.

### Process:
1. Upload or capture user image
2. Detect human pose
3. Segment body regions
4. Align garment with body
5. Render final try-on image

---

## 🏗️ System Architecture

The system follows a modular architecture:

- Flutter App (Mobile Users)
- React Web App (Admin/Seller)
- NestJS Backend (API Layer)
- AI Microservice (Virtual Try-On)

All components communicate via secure REST APIs.

---

## 🔄 Development Methodology

The project follows an Agile-based phased approach:

1. Requirement Analysis
2. System Design
3. Core Feature Development
4. AI Integration
5. Testing & Evaluation

---
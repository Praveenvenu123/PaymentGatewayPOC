# 💳 Payment Gateway API POC (Cashfree + Robot Framework)

## 📌 Overview
This project demonstrates end-to-end automation of a payment gateway flow using the **Cashfree Sandbox API** and **Robot Framework**.

It includes:
- API automation using `RequestsLibrary`
- Order creation (`POST /orders`)
- Order verification (`GET /orders/{id}`)
- Ready structure for webhook simulation (Flask + ngrok)

---

## ⚙️ Folder Structure
PaymentGatewayPOC/
├── Tests/ → Test cases
├── Resources/ → Keywords and reusable logic
├── config/ → Variables and credentials
└── webhook/ (optional) → Webhook simulation


---

## 🚀 How to Run

1. Install dependencies:
   ```bash
   pip install -r requirements.txt

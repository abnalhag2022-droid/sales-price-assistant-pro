# 📡 API Endpoints

## Authentication

POST /api/v1/auth/login
- Body: { username, password }
- Response: { access_token, refresh_token }

POST /api/v1/auth/logout

GET /api/v1/auth/me

## Items

GET /api/v1/items?q=search
- Returns: List of items

GET /api/v1/items/{code}
- Returns: Item details

POST /api/v1/items
- Body: { code, name_ar }
- Admin only

## Customers

GET /api/v1/customers

GET /api/v1/customers/{id}

POST /api/v1/customers
- Admin only

## Sessions

POST /api/v1/sessions
- Body: { customer_id }

GET /api/v1/sessions/{id}

POST /api/v1/sessions/{id}/items
- Body: { item_code, quantity, price }

POST /api/v1/sessions/{id}/complete

آخر تحديث: October 2024

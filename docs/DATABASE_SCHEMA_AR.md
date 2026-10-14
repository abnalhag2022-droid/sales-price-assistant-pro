# 🗄️ قاعدة البيانات

## الجداول الرئيسية

### users
- id (UUID)
- username (VARCHAR)
- email (VARCHAR)
- password (VARCHAR)

### customers
- id (UUID)
- code (VARCHAR)
- name (VARCHAR)

### items
- id (UUID)
- code (VARCHAR)
- name_ar (VARCHAR)

### sessions
- id (UUID)
- user_id (UUID)
- customer_id (UUID)
- status (VARCHAR)

آخر تحديث: October 2024

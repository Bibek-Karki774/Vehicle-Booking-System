USE vehicle_booking;

DELETE FROM bookings;
DELETE FROM wishlist;
DELETE FROM vehicles;
DELETE FROM users;


INSERT INTO users (username, password, phone, address, driving_license, email, role, status)
VALUES
    ('admin123', '$2a$10$OmIkYe1zV50R2gvKR.pom.7GWbfyqBdgJBBqk/Fd7Cqkoq9FX.Bcq', '+977-9835025437', 'Phoolbari-11, Pokhara', '01-02-12345678', 'admin123@gmail.com', 'Admin', 'Active'),
    ('test123', '$2a$10$JAT0Ve1qiu5a7LKjboJgKu4tPERUb6h6Q.xd3TSYWcMo.8aNrF0.e', '+977-9834838217', 'Sauraha-4, Chitwan', '04-02-49382758', 'test123@gmail.com', 'Member', 'Active'),
    ('test1234', '$2a$10$5cymNhPHFJBKo7zYGamWDudO93./HcENseUejyhv9wCZuAr0hwYi.', '+977-9825493829', 'Bagar-5, Pokhara', '02-06-18275846', 'ram857@gmail.com', 'Member', 'Active'),
    ('test12345', '$2a$10$LDVzOeIdDSRxj9k8TNxOFOZ1Jp2oTN1s1hm8QkMGZBVKUhEFlAtFe', '+977-9812948392', 'Ramghat-2, Kathmandu', '02-05-28473826', 'ramkovai234@gmail.com', 'Member', 'Active'),
    ('test123456', '$2a$10$HkZeuonbnoGp9OGpV3T/WuBv5hDkPV.Ezb0OrP67Z5TCOicD3TvMa', '+977-9829574839', 'Nadipur-3, Pokhara', '10-03-28564028', 'harikosathi897@gmail.com', 'Member', 'Pending'),
    ('test1234567', '$2a$10$Jm.lCyoQmnRQGS900v.gnOpbskXix0GQfM.diZNRX/PPXr8Uf7rA6', '+977-9809684637', 'Thimi-5, Bhaktapur', '09-23-47382675', 'merosathi684@gmail.com', 'Member', 'Pending'),
    ('test12345678', '$2a$10$d9srKe5Slf16pw1mxNgXjuI.Ap/YQItb2WjHmRBDR44st//MlI8g6', '+977-9806958463', 'Imadol-10, Lalitpur', '98-07-78564038', 'timrosathi456@gmail.com', 'Member', 'Pending');


INSERT INTO vehicles (vehicle_name, vehicle_type, total_seats, vehicle_description, price_per_day)
VALUES
    ('Mahindra Scorpio', 'SUV', 8, 'Rugged SUV known for durability and rough-road performance.', 1000.00),
    ('Toyota Corolla', 'Sedan', 7, 'Reliable sedan with long-lasting performance and low maintenance.', 950.00),
    ('Toyota Fortuner', 'SUV', 8, 'Strong and powerful SUV, ideal for off-road and long-distance travel.', 2000.00),
    ('Taruck', 'SUV', 4, 'Strong and powerful SUV, ideal for off-road and long-distance travel.', 2000.00);


INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, total_amount)
VALUES
    (3, 1, '2026-03-30', '2026-03-31', 1000.00),
    (2, 2, '2026-07-12', '2026-08-02', 19950.00),
    (4, 4, '2026-02-12', '2026-02-20', 16000.00),
    (3, 1, '2026-01-02', '2026-01-10', 8000.00),
    (2, 2, '2026-04-22', '2026-04-25', 2850.00),
    (4, 3, '2026-09-12', '2026-09-16', 8000.00);


INSERT INTO wishlist (user_id, vehicle_id)
VALUES
    (3, 2),
    (4, 3),
    (3, 3),
    (4, 2),
    (3, 1);
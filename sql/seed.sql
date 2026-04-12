USE vehicle_booking;

DELETE FROM bookings;
DELETE FROM wishlist;
DELETE FROM vehicles;
DELETE FROM users;


INSERT INTO users (username, password, phone, address, driving_license, email, role)
VALUES
    ('bibek-774', 'pass1', '+977-9835029569', 'Phoolbari-11, Pokhara', 'ATX-34Y-57U', 'bibekkarki774@mail.com', 'Admin'),
    ('sangamBoss-68', 'pass2', '+977-9843829168', 'Bagar-5, Pokhara', 'TY6-XR4-DP3', 'sangam857@gmail.com', 'Member'),
    ('adean-245', 'pass3', '+977-9843028194', 'Nadipur-3, Pokhara', 'FLE-TL3-9DM', 'adean593@gmail.com', 'Member');


INSERT INTO vehicles (vehicle_name, vehicle_type, total_seats, vehicle_description, price_per_day)
VALUES
    ('Mahindra Scorpio', 'SUV', 8, 'Rugged SUV known for durability and rough-road performance.', 1000.00),
    ('Toyota Corolla', 'Sedan', 7, 'Reliable sedan with long-lasting performance and low maintenance.', 950.00),
    ('Toyota Fortuner', 'SUV', 8, 'Strong and powerful SUV, ideal for off-road and long-distance travel.', 2000.00),
    ('Taruck', 'SUV', 4, 'Strong and powerful SUV, ideal for off-road and long-distance travel.', 2000.00);


INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, total_amount)
VALUES
    (1, 1, '2026-03-30', '2026-03-31', 1000.00),   -- 1 day × 1000
    (2, 2, '2026-07-12', '2026-08-02', 19950.00),  -- 21 days × 950
    (1, 3, '2026-09-12', '2026-09-16', 8000.00);   -- 4 days × 2000


INSERT INTO wishlist (user_id, vehicle_id)
VALUES
    (1, 2),
    (1, 3),
    (2, 1);
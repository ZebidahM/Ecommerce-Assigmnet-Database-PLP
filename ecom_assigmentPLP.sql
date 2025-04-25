-- Active: 1745342901728@@127.0.0.1@3306@ecommerce
CREATE DATABASE ecommerce;
USE ecommerce;
-- Table: brand
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
INSERT INTO brand (name) VALUES 
('Nike'), 
('Samsung'), 
('Apple');

-- Table: product_category
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
INSERT INTO product_category (name) VALUES 
('Clothing'), 
('Electronics'), 
('Footwear');

-- Table: product
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10, 2),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);
INSERT INTO product (name, brand_id, category_id, base_price) VALUES 
('Air Max Sneakers', 1, 3, 120.00),
('Galaxy S22', 2, 2, 799.99),
('iPhone 14', 3, 2, 999.99);

-- Table: product_image
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    image_url TEXT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
INSERT INTO product_image (product_id, image_url) VALUES 
(1, 'https://example.com/images/airmax.jpg'),
(2, 'https://example.com/images/galaxy.jpg'),
(3, 'https://example.com/images/iphone.jpg');

-- Table: color
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);
INSERT INTO color (name) VALUES 
('Black'), 
('White'), 
('Blue');

-- Table: size_category
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
INSERT INTO size_category (name) VALUES 
('Clothing Sizes'), 
('Phone Storage');

-- Table: size_option
CREATE TABLE size_option (
    size_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT,
    label VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);
INSERT INTO size_option (size_category_id, label) VALUES 
(1, 'S'), 
(1, 'M'), 
(1, 'L'), 
(2, '128GB'), 
(2, '256GB');

-- Table: product_variation
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    color_id INT,
    size_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_id) REFERENCES size_option(size_id)
);
INSERT INTO product_variation (product_id, color_id, size_id) VALUES 
(1, 1, 1), -- Black, S
(1, 2, 2), -- White, M
(2, 3, 4), -- Blue, 128GB
(3, 1, 5); -- Black, 256GB

-- Table: product_item
CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    variation_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);
INSERT INTO product_item (variation_id, price, stock_quantity) VALUES 
(1, 120.00, 10),
(2, 125.00, 5),
(3, 799.99, 15),
(4, 999.99, 8);

-- Table: attribute_category
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
INSERT INTO attribute_category (name) VALUES 
('Physical'), 
('Technical');

-- Table: attribute_type
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL
);
INSERT INTO attribute_type (type_name) VALUES 
('text'), 
('number'), 
('boolean');

-- Table: product_attribute
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(100) NOT NULL,
    value TEXT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES 
(1, 1, 2, 'Weight', '0.9'), -- Air Max Sneakers
(2, 2, 1, 'Display Type', 'AMOLED'), -- Galaxy S22
(2, 2, 2, 'Battery Capacity', '3700'), 
(3, 2, 2, 'RAM', '6'); -- iPhone 14

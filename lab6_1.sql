CREATE TABLE medicines (
    medicine_id SERIAL PRIMARY KEY,
    
    medicine_name VARCHAR(255) NOT NULL,
    indications TEXT,
    
    unit VARCHAR(50) NOT NULL,
    
    quantity_per_package INTEGER NOT NULL CHECK (quantity_per_package > 0),
    
    manufacturer_name VARCHAR(255) NOT NULL
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    
    short_name VARCHAR(100) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    
    legal_address TEXT NOT NULL,
    
    phone VARCHAR(30),
    
    director_full_name VARCHAR(255) NOT NULL
);

CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY,
    
    medicine_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    
    delivery_date DATE NOT NULL,
    
    price_per_unit NUMERIC(10, 2) NOT NULL CHECK (price_per_unit >= 0),
    
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    
    CONSTRAINT fk_delivery_medicine
        FOREIGN KEY (medicine_id)
        REFERENCES medicines(medicine_id)
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_delivery_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
        ON DELETE RESTRICT
);

-- 1

CREATE OR REPLACE FUNCTION get_medicines_by_indication(
    p_indication TEXT
)
RETURNS TABLE (
    medicine_id INTEGER,
    medicine_name VARCHAR,
    indications TEXT,
    unit VARCHAR,
    manufacturer_name VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        m.medicine_id,
        m.medicine_name,
        m.indications,
        m.unit,
        m.manufacturer_name
    FROM medicines m
    WHERE LOWER(m.indications) LIKE LOWER('%' || p_indication || '%');
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_medicines_by_indication('жар');

-- 2

CREATE OR REPLACE FUNCTION get_delivery_dates_by_quantity(
    p_quantity INTEGER
)
RETURNS TABLE (
    delivery_date DATE,
    medicine_name VARCHAR,
    quantity INTEGER
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.delivery_date,
        m.medicine_name,
        d.quantity
    FROM deliveries d
    JOIN medicines m
        ON d.medicine_id = m.medicine_id
    WHERE d.quantity > p_quantity
    ORDER BY d.delivery_date;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_delivery_dates_by_quantity(50);

-- 3

CREATE OR REPLACE FUNCTION get_delivery_info_by_code(
    p_delivery_code INTEGER
)
RETURNS TABLE (
    delivery_id INTEGER,
    delivery_date DATE,
    total_amount NUMERIC,
    director_full_name VARCHAR,
    medicine_name VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.delivery_id,
        d.delivery_date,
        d.price_per_unit * d.quantity AS total_amount,
        s.director_full_name,
        m.medicine_name
    FROM deliveries d
    JOIN suppliers s
        ON d.supplier_id = s.supplier_id
    JOIN medicines m
        ON d.medicine_id = m.medicine_id
    WHERE d.delivery_id > p_delivery_code
    ORDER BY d.delivery_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_delivery_info_by_code(10);

-- 4

CREATE OR REPLACE FUNCTION get_medicines_by_package_or_code(
    p_package_quantity INTEGER,
    p_medicine_code INTEGER
)
RETURNS TABLE (
    medicine_id INTEGER,
    medicine_name VARCHAR,
    unit VARCHAR,
    quantity_per_package INTEGER
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        m.medicine_id,
        m.medicine_name,
        m.unit,
        m.quantity_per_package
    FROM medicines m
    WHERE
        m.quantity_per_package > p_package_quantity
        OR
        m.medicine_id < p_medicine_code
    ORDER BY m.medicine_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_medicines_by_package_or_code(20, 5);
























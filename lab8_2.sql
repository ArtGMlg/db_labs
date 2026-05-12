CREATE ROLE pharmacist
WITH
    LOGIN
    PASSWORD 'PharmPass123!';

CREATE ROLE purchase_manager
WITH
    LOGIN
    PASSWORD 'ManagerPass123!';

CREATE ROLE auditor
WITH
    LOGIN
    PASSWORD 'AuditPass123!';

-- Права фармацевта

GRANT SELECT
ON medicines
TO pharmacist;

GRANT SELECT, INSERT, UPDATE
ON deliveries
TO pharmacist;

GRANT SELECT
ON suppliers
TO pharmacist;

-- Права менеджера по закупкам

GRANT SELECT, INSERT, UPDATE
ON medicines
TO purchase_manager;

GRANT SELECT, INSERT, UPDATE
ON suppliers
TO purchase_manager;

GRANT SELECT, INSERT, UPDATE
ON deliveries
TO purchase_manager;

-- Права аудитора

GRANT SELECT
ON medicines
TO auditor;

GRANT SELECT
ON suppliers
TO auditor;

GRANT SELECT
ON deliveries
TO auditor;

-- Права на sequences

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO pharmacist;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO purchase_manager;


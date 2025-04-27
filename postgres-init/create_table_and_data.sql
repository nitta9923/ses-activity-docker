-- 部署マスタテーブル
CREATE TABLE IF NOT EXISTS departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- ロールマスタテーブル
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

-- ステータスマスタテーブル
CREATE TABLE IF NOT EXISTS statuses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    department_id INTEGER REFERENCES departments(id),
    role_id INTEGER REFERENCES roles(id),
    status_id INTEGER REFERENCES statuses(id),
    sex VARCHAR(10),
    birth_date DATE,
    nearest_station VARCHAR(255),
    education VARCHAR(255),
    is_bp BOOLEAN,
    joined_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- データ投入
COPY departments(name)
FROM '/docker-entrypoint-initdb.d/departments.csv'
DELIMITER ','
CSV HEADER;

COPY roles(name)
FROM '/docker-entrypoint-initdb.d/roles.csv'
DELIMITER ','
CSV HEADER;

COPY statuses(name)
FROM '/docker-entrypoint-initdb.d/statuses.csv'
DELIMITER ','
CSV HEADER;

COPY users(name, email, password, department_id, role_id, status_id, is_bp, joined_date, sex, birth_date, nearest_station, education, created_at, updated_at)
FROM '/docker-entrypoint-initdb.d/users.csv'
DELIMITER ','
CSV HEADER;
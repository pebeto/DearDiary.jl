const SQL_SELECT_USER_BY_USERNAME = "
SELECT
    u.ROWID as id,
    u.first_name,
    u.last_name,
    u.username,
    u.password,
    u.created_date,
    u.is_admin
FROM user u WHERE u.username = :username
"

const SQL_SELECT_USER_BY_ID = "
SELECT
    u.ROWID as id,
    u.first_name,
    u.last_name,
    u.username,
    u.password,
    u.created_date,
    u.is_admin
FROM user u WHERE u.ROWID = :id
"

const SQL_SELECT_USERS = "
SELECT
    u.ROWID as id,
    u.first_name,
    u.last_name,
    u.username,
    u.password,
    u.created_date,
    u.is_admin
FROM user u
"

const SQL_SELECT_USERS_BY_PROJECT_ID = "
SELECT
    u.ROWID as id,
    u.first_name,
    u.last_name,
    u.username,
    u.password,
    u.created_date,
    u.is_admin
FROM user u
INNER JOIN user_permission up ON u.ROWID = up.user_id
WHERE up.project_id = :project_id
"

const SQL_INSERT_USER = "
INSERT INTO user (username, password, first_name, last_name, created_date)
    VALUES (:username, :password, :first_name, :last_name, :created_date) RETURNING ROWID
"

const SQL_UPDATE_USER = "
UPDATE user SET {fields}
WHERE ROWID = :id
"

const SQL_DELETE_USER = "
DELETE FROM user
WHERE ROWID = :id
"

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    deleted_at TIMESTAMPTZ DEFAULT NULL,
    token TEXT DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS chats (
    id SERIAL PRIMARY KEY,
    chat_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS messages (
    message_id SERIAL PRIMARY KEY,
    chat_id INT REFERENCES chats(id) ON DELETE CASCADE,
    sender_id INT REFERENCES users(id) ON DELETE CASCADE,
    content TEXT,
    timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS chatMembers(
    chat_id INT REFERENCES chats(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (chat_id, user_id)
);

INSERT INTO users (username, password, email)
VALUES ('user1', 'password', 'user1@example.com');

INSERT INTO chats (chat_name, created_at, updated_at)
VALUES ('General chat', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO chatMembers (chat_id, user_id)
VALUES (1, 1);

INSERT INTO messages (chat_id, sender_id, content, timestamp)
VALUES 
    (1, 1, 'Hello, how are you?', CURRENT_TIMESTAMP),
    (1, 1, 'Estoy bien, gracias', CURRENT_TIMESTAMP),
    (1, 1, 'Что нового?', CURRENT_TIMESTAMP);
-- Active: 1689291300480@@127.0.0.1@3306
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    nick_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT DEFAULT "NORMAL" NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL
);

INSERT INTO users (id, nick_name, email, password, created_at, role)
VALUES
    --senha: Mestre@809030
	("u001", "Priscila Mordente", "priscila@email.com", "$2a$12$Peh3J/B0Ui8VGMbo2rK38uJ2NiDRSrIMLrgWQDGeKUACHnxCdYoPe","2023-02-17T23:50:32.000Z", "ADMIN"),
    --senha: arya@208090
	("u002", "Arya Stark", "arya@email.com", "$2a$12$y22Usjg0R467BPkQ8tclUOZiLHUr2v/WAEoJylt64WZna4LCV/lyS", "2023-02-17T23:50:32.000Z", "NORMAL"),
    --senha: snow@3980
    ("u003", "João das Neves", "joao@email.com", "$2a$12$1lGzN/XboaHOwmBfzvONj.yS20YDyYbYehBgAyj9sZRlVA//.JDZu", "2023-02-17T23:50:32.000Z", "NORMAL"),
    --senha: dracarys@30698
    ("u004", "Dany Targaryen", "dany@email.com", "$2a$12$j7rs.lW9xGG86bkO98OLvOdCnxTwrq2IxTNKT4oc0uE6Zb6OergKi", "2023-02-17T23:50:32.000Z", "NORMAL");

SELECT * FROM users;
DROP TABLE users;

CREATE TABLE posts (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    creator_id TEXT NOT NULL,
    content TEXT NOT NULL,
    likes INTEGER DEFAULT(0) NOT NULL,
    dislikes INTEGER DEFAULT(0) NOT NULL,
    replies INTEGER DEFAULT(0) NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL,
    updated_at TEXT NOT NULL,
    FOREIGN KEY (creator_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO posts (id, creator_id, content, likes, dislikes, replies, created_at, updated_at)
VALUES
	("p001", "u001", "Backend é melhor que frontend", 0, 0, 1, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z"),
	("p002", "u002", "O que dizemos para o Deus da morte?", 0, 1, 1, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z"),
	("p003", "u003", "Não sei de nada!", 3, 1, 1, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z"),
	("p004", "u004", "Dracarys!", 1, 0, 1, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z");

SELECT * FROM posts;
DROP TABLE posts;

CREATE TABLE likes_dislikes_post (
    user_id TEXT NOT NULL,
    post_id TEXT NOT NULL,
    likes INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO likes_dislikes_post (user_id, post_id, likes)
VALUES
	("u001", "p003", 0),
	("u002", "p001", 0),
	("u001", "p002", 1),
	("u003", "p001", 1),
	("u004", "p002", 1),
	("u003", "p004", 1);
    
SELECT * FROM likes_dislikes_post;
DROP TABLE likes_dislikes_post;


CREATE TABLE comments (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    creator_id TEXT NOT NULL,
    post_id TEXT NOT NULL,
    content TEXT NOT NULL,
    likes INTEGER DEFAULT(0) NOT NULL,
    dislikes INTEGER DEFAULT(0) NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL,
    updated_at TEXT NOT NULL,
    FOREIGN KEY (creator_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Criar tabela "comments"
CREATE TABLE comments (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    creator_id TEXT NOT NULL,
    post_id TEXT NOT NULL,
    content TEXT NOT NULL,
    likes INTEGER DEFAULT 0 NOT NULL,
    dislikes INTEGER DEFAULT 0 NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL,
    updated_at TEXT NOT NULL,
    FOREIGN KEY (creator_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Inserir dados na tabela "comments"
INSERT INTO comments (id, creator_id, post_id, content, likes, dislikes, created_at, updated_at)
VALUES
	("c001", "u001", "p004", "Dor e sofrimento!", 1, 0, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z"),
	("c003", "u002", "p003", "Não mesmo!", 1, 0, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z"),
	("c002", "u003", "p002", "¬¬", 1, 0, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z"),
	("c004", "u004", "p004", "Eu vou quebrar a roda!", 1, 0, "2023-02-17T23:50:32.000Z", "2023-02-17T23:50:32.000Z");

-- Consultar os dados da tabela "comments"
SELECT * FROM comments;
DROP TABLE comments;

-- Criar tabela "likes_dislikes_post_comment"
CREATE TABLE likes_dislikes_post_comment (
    user_id TEXT NOT NULL,
    comment_id TEXT NOT NULL,
    likes INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comments(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Inserir dados na tabela "likes_dislikes_post_comment"
INSERT INTO likes_dislikes_post_comment (user_id, comment_id, likes)
VALUES
	("u001", "c002", 1),
	("u003", "c004", 1),
	("u001", "c003", 1),
	("u002", "c001", 1);

-- Consultar os dados da tabela "likes_dislikes_post_comment"

SELECT * FROM likes_dislikes_post_comment;
DROP TABLE likes_dislikes_post_comment;


UPDATE posts
SET creator_id = "p001"
WHERE id = "u001";

SELECT * FROM posts
INNER JOIN comments
ON posts.id = comments.post_id;
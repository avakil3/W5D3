
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
    FOREIGN KEY (author_id) REFERENCES users(id)

);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)

);




-- Database Insertions below


INSERT INTO
    users (fname,lname)
VALUES
    ("Aagam", "Vakil"), 
    ("Usman", "Hameed"), 
    ("Evan","Long");

    
INSERT INTO
    questions (title,body,author_id)
VALUES  
    ("Aagam Question", "BLAH", (SELECT id FROM users WHERE fname = "Aagam" AND lname = "Vakil")), 
    ("Usman Question", "BLAH AGAIN", (SELECT id FROM users WHERE fname = "Usman" AND lname = "Hameed")), 
    ("Evan Question", "BLAH BLAH AGAIN", (SELECT id FROM users WHERE fname = "Evan" AND lname = "Long"));


INSERT INTO
    question_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Aagam" AND lname = "Vakil"), (SELECT id FROM questions WHERE title = "Aagam Question")),
    ((SELECT id FROM users WHERE fname = "Usman" AND lname = "Hameed"),(SELECT id FROM questions WHERE title = "Usman Question")), 
    ((SELECT id FROM users WHERE fname = "Evan" AND lname = "Long"), (SELECT id FROM questions WHERE title = "Evan Question")),
    ((SELECT id FROM users WHERE fname = "Evan" AND lname = "Long"), (SELECT id FROM questions WHERE title = "Aagam Question"));

INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "Aagam Question"),NULL,(SELECT id FROM users WHERE fname = "Aagam" AND lname = "Vakil"),"this is the first body of Aagam's question reply"); 


INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES  
    ((SELECT id FROM questions WHERE title = "Aagam Question"),(SELECT id FROM replies WHERE body = "this is the first body of Aagam's question reply"),(SELECT id FROM users WHERE fname = "Aagam" AND lname = "Vakil"),"this is the SECOND body of Aagam's question reply");


INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES  
    ((SELECT id FROM questions WHERE title = "Usman Question"), NULL, (SELECT id FROM users WHERE fname = "Usman" AND lname = "Hameed"), "this is the body of Usman's question reply" ); 


INSERT INTO
    question_likes (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Aagam" AND lname = "Vakil"),(SELECT id from questions WHERE title = "Usman Question")),
    ((SELECT id FROM users WHERE fname = "Usman" AND lname = "Hameed"),(SELECT id from questions WHERE title = "Aagam Question")),
    ((SELECT id FROM users WHERE fname = "Evan" AND lname = "Long"),(SELECT id from questions WHERE title = "Usman Question"));


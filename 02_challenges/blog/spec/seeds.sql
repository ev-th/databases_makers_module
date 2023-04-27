TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES ('post_1', 'content_1');
INSERT INTO posts (title, content) VALUES ('post_2', 'content_2');

INSERT INTO comments (content, author, post_id) VALUES ('comment_content_1', 'author_1', 1);
INSERT INTO comments (content, author, post_id) VALUES ('comment_content_2', 'author_2', 1);
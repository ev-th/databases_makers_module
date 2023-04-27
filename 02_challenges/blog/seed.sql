

INSERT INTO posts (title, content)
  VALUES
    ('title1', 'post_content1'),
    ('title2', 'post_content2'),
    ('title3', 'post_content3'),
    ('title4', 'post_content4'),
    ('title5', 'post_content5');

INSERT INTO comments (content, author, post_id)
  VALUES
    ('content1', 'author1', 1),
    ('content2', 'author2', 1),
    ('content3', 'author3', 2),
    ('content4', 'author4', 3),
    ('content5', 'author5', 2);
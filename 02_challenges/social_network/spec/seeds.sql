DROP TABLE IF EXISTS user_accounts, posts;

CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  number_of_views int,
  user_account_id int,
  constraint fk_user_account foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);

TRUNCATE TABLE user_accounts, posts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username) VALUES
('Email 1', 'User 1'),
('Email 2', 'User 2');

INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES
('Post 1', 'Some content', 2, 1);
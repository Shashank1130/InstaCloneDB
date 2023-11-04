---------- Creating Tables ----------

 
--- User Table ---
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
    username VARCHAR(250) UNIQUE NOT NULL,
	profile_photo_url VARCHAR(300) DEFAULT 'https://picsum.photos/100',
	bio VARCHAR(500),
	email VARCHAR(100) NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);



--- Photos Table ---
CREATE TABLE photos (
	photo_id SERIAL PRIMARY KEY,
	photo_url VARCHAR(300) NOT NULL UNIQUE,
	post_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	size FLOAT CHECK (size < 5)
);



--- Videos Table ---
CREATE TABLE videos (
	video_id SERIAL PRIMARY KEY,
	video_url VARCHAR(300) NOT NULL UNIQUE,
	post_id INTEGER NOT NULL, 
	created_at TIMESTAMP DEFAULT NOW(),
	size FLOAT CHECK (size < 15)
);



--- Post ---
CREATE TABLE post (
	post_id SERIAL PRIMARY KEY,
	photo_id INTEGER,
	video_id INTEGER,
	user_id INTEGER NOT NULL,
	caption VARCHAR(300),
	location VARCHAR(100),
	created_at TIMESTAMP DEFAULT NOW(),
	
	-- Adding foreign Keys -- 
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(photo_id) REFERENCES photos(photo_id),
	FOREIGN KEY(video_id) REFERENCES videos(video_id)
);



--- Comments ---
CREATE TABLE comments (
	comment_id SERIAL PRIMARY KEY,
	comment_text VARCHAR(300) NOT NULL,		
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY(post_id) REFERENCES post(post_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id)
);



--- Post Likes ---
CREATE TABLE post_likes (
	user_id INTEGER NOT NULL,
	post_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(post_id) REFERENCES post(post_id),
	PRIMARY KEY(user_id, post_id)
);



--- Comment Likes ---
CREATE TABLE comment_likes (
    user_id INTEGER NOT NULL,
    comment_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
	
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(comment_id) REFERENCES comments(comment_id),
	PRIMARY KEY(user_id, comment_id)
);



--- Follows Table ---
CREATE TABLE follows (
	follower_id INTEGER NOT NULL,
	followee_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY(follower_id) REFERENCES users(user_id),
	FOREIGN KEY(followee_id) REFERENCES users(user_id),
	PRIMARY KEY(follower_id, followee_id)	
);



--- Hashtags Table ---
CREATE TABLE hashtags (
	hasgtag_id SERIAL PRIMARY KEY,
	hashtag_name VARCHAR(300) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW()
);



--- Hashatag Follow Table ---
CREATE TABLE hashtag_follow (
	user_id INTEGER NOT NULL,
	hashtag_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(user_id, hashtag_id)
);



--- Post Tags ---
CREATE TABLE post_tags (
	post_id INTEGER NOT NULL,
	hashtag_id INTEGER NOT NULL,
	
	FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(post_id, hashtag_id)
);



--- Bookmarks Table ---
CREATE TABLE bookmarks (
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
  	FOREIGN KEY(post_id) REFERENCES post(post_id),
  	FOREIGN KEY(user_id) REFERENCES users(user_id),
  	PRIMARY KEY(user_id, post_id)
);



--- Login Table ---
CREATE TABLE login (
	login_id SERIAL PRIMARY KEY NOT NULL,
	user_id INTEGER NOT NULL,
	ip VARCHAR(50) NOT NULL,
	login_time TIMESTAMP NOT NULL DEFAULT NOW(),
	
	FOREIGN KEY(user_id) REFERENCES users(user_id)
);




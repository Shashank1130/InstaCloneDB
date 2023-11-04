------------- QUERIES --------------


-- Q1. Users who are from 'Maharashtra', 'West Bengal' and 'karnataka'.

SELECT * FROM post
WHERE location IN ('maharashtra', 'west bengal', 'karnataka');




-- Q2. Which hashtag in the database has the most followers?

SELECT hashtag_follow.hashtag_id, hashtags.hashtag_name AS Hashtags, COUNT(hashtag_follow.hashtag_id) AS total_follows 
FROM hashtags
INNER JOIN hashtag_follow ON hashtags.hashtag_id = hashtag_follow.hashtag_id
GROUP BY hashtags.hashtag_name, hashtag_follow.hashtag_id
ORDER BY COUNT(hashtag_follow.hashtag_id) DESC
LIMIT 5;




-- Q3. What are the top 5 most frequently used hashtags in the database?

SELECT hashtag_name AS trending_hashtag, COUNT(post_tags.hashtag_id) AS times_used
FROM hashtags
INNER JOIN post_tags ON hashtags.hashtag_id = post_tags.hashtag_id
GROUP BY hashtag_name
ORDER BY COUNT(post_tags.hashtag_id) DESC 
LIMIT 10;




-- Q4. Who is the most inactive user in the database?

SELECT user_id, username AS most_inactive_user
FROM users
WHERE user_id NOT IN (SELECT user_id FROM post);




-- Q5. What are the top 5 posts with the most likes in the database?

SELECT post_likes.post_id, COUNT(post_likes.post_id) AS total_likes
FROM post
INNER JOIN post_likes ON post.post_id = post_likes.post_id
GROUP BY post_likes.post_id
ORDER BY COUNT(post_likes.post_id) DESC
LIMIT 5;




-- Q6. What is the average number of posts per user in the database?

SELECT ROUND(COUNT(post_id) / COUNT(DISTINCT user_id), 2) AS average_post_per_user
FROM post;




-- Q7. How many times has each user logged in?

SELECT login.user_id, users.email, users.username, COUNT(login_id) AS number_of_login 
FROM login
INNER JOIN users ON login.user_id = users.user_id
GROUP BY login.user_id, users.email, users.username
ORDER BY COUNT(login_id) DESC;




-- Q8.  Which users have liked every single post in the database?	

SELECT post_likes.user_id, users.username, COUNT(post_likes.post_id) AS num_of_likes
FROM users
INNER JOIN post_likes ON users.user_id = post_likes.user_id
GROUP BY post_likes.user_id, users.username
HAVING COUNT(post_likes.post_id) = (SELECT COUNT(*) FROM post);




-- Q9. Which users have never left a comment on any post in the database?

SELECT user_id, username AS user_never_comments
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);




-- Q10. Which users have left a comment on every single post in the database?

SELECT comments.user_id, users.username, COUNT(comments.comment_id) AS number_of_comments
FROM users
INNER JOIN comments ON users.user_id = comments.user_id
GROUP BY comments.user_id, users.username
HAVING COUNT(comments.comment_id) = (SELECT COUNT(*) FROM comments);




-- Q11. Who are the users in the database that are not followed by anyone?

SELECT user_id, username AS user_not_followed_by_anyone
FROM users
WHERE user_id NOT IN (SELECT followee_id FROM follows);




-- Q12. Who are the users in the database that are not following anyone?

SELECT user_id, username AS users_not_folling_anyone
FROM users
WHERE user_id NOT IN (SELECT follower_id FROM follows);




-- Q13. Which users in the database have posted more than 5 times?

SELECT post.user_id, users.username, COUNT(post.post_id) AS post_count
FROM post
INNER JOIN users ON users.user_id = post.user_id
GROUP BY post.user_id, users.username
HAVING COUNT(post.post_id) > 5;

-- or

SELECT user_id, COUNT(user_id) AS post_count
FROM post
GROUP BY user_id
HAVING COUNT(user_id) > 5;




-- Q14. Who are the users in the database with more than 40 followers?

SELECT followee_id, COUNT(follower_id) AS follower_count
FROM follows
GROUP BY followee_id
HAVING COUNT(follower_id) > 40
ORDER BY follower_count DESC;




-- Q15. Which posts have the longest captions in the database?

SELECT post.user_id, users.username, caption, LENGTH(post.caption) AS caption_length
FROM post
INNER JOIN users ON users.user_id = post.user_id
ORDER BY caption_length DESC
LIMIT 5;
























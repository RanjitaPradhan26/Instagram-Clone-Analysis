use ig_clone; 

select * from ig_clone; 

#1.We want to reward our users who have been around the longest.Find the 5 oldest users. 

SELECT * FROM users
ORDER BY created_at asc
LIMIT 5;

#2.What day of the week do most users register on? We need to figure out when to schedule an ad campgain. 

SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 5; 

#3.To target inactive users in an email ad campaign, Find the users who have never posted a photo.

SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL; 

#4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? 

SELECT username,photos.id,photos.image_url,COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 5; 

#5.The investors want to know how many times does the average user post. 

SELECT ROUND((SELECT COUNT(*)FROM photos)/
(SELECT COUNT(*) FROM users)) as average;

#6.user ranking by postings higher to lower.

SELECT users.username,COUNT(photos.image_url)
FROM users
INNER JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY 2 DESC;

#7.total numbers of users who have posted at least one time. 

SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN photos ON users.id = photos.user_id; 

#8.A brand wants to know which hashtag to use on a post and find the top 5 most used hashtags. 

SELECT tag_name, COUNT(tag_name) AS total
FROM tags
INNER JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC; 

#9.To find out if there are bots, Find users who have liked every single photo on the site.

SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
INNER JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos); 

#10.Find the users who have created Instagram id in May and select top 5 newest joinees from it?

SELECT * FROM users
WHERE monthname(created_at) ='may'
ORDER BY created_at DESC
LIMIT 5; 

#11.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?

SELECT DISTINCT(users.id),users.username 
FROM users
INNER JOIN photos
ON photos.user_id = users.id
INNER JOIN likes
ON likes.user_id = photos.user_id
WHERE username REGEXP '^c.*[0-9]$'; 

#12.Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5. 

SELECT username,count(photos.id)
FROM users
INNER JOIN photos
ON users.id = photos.user_id
 GROUP BY username
 HAVING count(photos.id) BETWEEN 3 AND 5
 LIMIT 30;




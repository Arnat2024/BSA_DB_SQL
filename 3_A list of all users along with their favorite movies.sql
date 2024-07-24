SELECT 
    User.id AS ID,
    User.username AS Username,
    GROUP_CONCAT(Favorite_Movie.movie_id) AS "Favorite movie IDs"
FROM 
    User
LEFT JOIN 
    Favorite_Movie ON User.id = Favorite_Movie.user_id
GROUP BY 
    User.id, User.username;

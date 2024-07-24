SELECT 
    Movie.id AS ID,
    Movie.title AS Title,
    COUNT(`Character`.person_id) AS "Actors count"
FROM 
    Movie
LEFT JOIN 
    `Character` ON Movie.id = `Character`.movie_id
WHERE 
    Movie.release_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
GROUP BY 
    Movie.id, Movie.title
ORDER BY 
    "Actors count" DESC;

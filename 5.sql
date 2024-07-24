SELECT 
    Movie.id AS ID,
    Movie.title AS Title,
    Movie.release_date AS "Release date",
    Movie.duration AS Duration,
    Movie.description AS Description,
    JSON_OBJECT(
        'file_name', Poster.file_name,
        'mime_type', Poster.mime_type,
        'key', Poster.key,
        'url', Poster.url
    ) AS Poster,
    JSON_OBJECT(
        'id', Director.id,
        'first_name', Director.first_name,
        'last_name', Director.last_name
    ) AS Director
FROM 
    Movie
JOIN 
    Country ON Movie.country_id = Country.id
JOIN 
    Movie_Genre ON Movie.id = Movie_Genre.movie_id
JOIN 
    Genre ON Movie_Genre.genre_id = Genre.id
LEFT JOIN 
    File AS Poster ON Movie.poster_id = Poster.id
JOIN 
    Person AS Director ON Movie.director_id = Director.id
WHERE 
    Country.id = 1 AND
    Movie.release_date >= '2022-01-01' AND
    Movie.duration > 135 AND
    Genre.name IN ('Action', 'Drama')
GROUP BY 
    Movie.id, Movie.title, Movie.release_date, Movie.duration, Movie.description, Poster.id, Director.id
ORDER BY 
    Movie.release_date DESC;

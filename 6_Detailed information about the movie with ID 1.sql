WITH MovieDetails AS (
    SELECT
        Movie.id AS ID,
        Movie.title AS Title,
        Movie.release_date AS `Release date`,
        Movie.duration AS Duration,
        Movie.description AS Description,
        JSON_OBJECT(
            'file_name', Poster.file_name,
            'mime_type', Poster.mime_type,
            'key', Poster.`key`,
            'url', Poster.url
        ) AS Poster,
        JSON_OBJECT(
            'id', Director.id,
            'first_name', Director.first_name,
            'last_name', Director.last_name,
            'photo', JSON_OBJECT(
                'file_name', DirectorPhoto.file_name,
                'mime_type', DirectorPhoto.mime_type,
                'key', DirectorPhoto.`key`,
                'url', DirectorPhoto.url
            )
        ) AS Director
    FROM 
        Movie
    LEFT JOIN 
        File AS Poster ON Movie.poster_id = Poster.id
    JOIN 
        Person AS Director ON Movie.director_id = Director.id
    LEFT JOIN 
        Person_Photo AS DirectorPhotoRel ON Director.id = DirectorPhotoRel.person_id AND DirectorPhotoRel.is_primary = TRUE
    LEFT JOIN 
        File AS DirectorPhoto ON DirectorPhotoRel.file_id = DirectorPhoto.id
    WHERE 
        Movie.id = 1
),
Actors AS (
    SELECT
        JSON_OBJECT(
            'id', Person.id,
            'first_name', Person.first_name,
            'last_name', Person.last_name,
            'photo', JSON_OBJECT(
                'file_name', ActorPhoto.file_name,
                'mime_type', ActorPhoto.mime_type,
                'key', ActorPhoto.`key`,
                'url', ActorPhoto.url
            )
        ) AS Actor
    FROM 
        Movie_Participation
    JOIN 
        Person ON Movie_Participation.person_id = Person.id
    LEFT JOIN 
        Person_Photo AS ActorPhotoRel ON Person.id = ActorPhotoRel.person_id AND ActorPhotoRel.is_primary = TRUE
    LEFT JOIN 
        File AS ActorPhoto ON ActorPhotoRel.file_id = ActorPhoto.id
    WHERE 
        Movie_Participation.movie_id = 1
),
Genres AS (
    SELECT
        JSON_OBJECT(
            'id', Genre.id,
            'name', Genre.name
        ) AS Genre
    FROM 
        Movie_Genre
    JOIN 
        Genre ON Movie_Genre.genre_id = Genre.id
    WHERE 
        Movie_Genre.movie_id = 1
)

SELECT
    MovieDetails.ID,
    MovieDetails.Title,
    MovieDetails.`Release date`,
    MovieDetails.Duration,
    MovieDetails.Description,
    MovieDetails.Poster,
    MovieDetails.Director,
    COALESCE(
        JSON_ARRAYAGG(Actors.Actor),
        JSON_ARRAY()
    ) AS Actors,
    COALESCE(
        JSON_ARRAYAGG(Genres.Genre),
        JSON_ARRAY()
    ) AS Genres
FROM 
    MovieDetails
LEFT JOIN 
    Actors ON TRUE
LEFT JOIN 
    Genres ON TRUE
GROUP BY
    MovieDetails.ID,
    MovieDetails.Title,
    MovieDetails.`Release date`,
    MovieDetails.Duration,
    MovieDetails.Description,
    MovieDetails.Poster,
    MovieDetails.Director;

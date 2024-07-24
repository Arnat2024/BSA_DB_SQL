SELECT 
    Person.id AS "Director ID",
    CONCAT(Person.first_name, ' ', Person.last_name) AS "Director name",
    AVG(Movie.budget) AS "Average budget"
FROM 
    Person
JOIN 
    Movie ON Person.id = Movie.director_id
GROUP BY 
    Person.id, Person.first_name, Person.last_name
ORDER BY 
    "Average budget" DESC;

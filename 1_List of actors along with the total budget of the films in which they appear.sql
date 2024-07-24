SELECT 
    p.id AS ID,
    p.first_name AS "First name",
    p.last_name AS "Last name",
    SUM(m.budget) AS "Total movies budget"
FROM 
    Person p
JOIN 
    Movie_Participation mp ON p.id = mp.person_id
JOIN 
    Movie m ON mp.movie_id = m.id
GROUP BY 
    p.id, p.first_name, p.last_name
ORDER BY 
    "Total movies budget" DESC;
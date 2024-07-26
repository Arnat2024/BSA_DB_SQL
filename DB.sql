/*CREATE DATABASE movie_db;

USE movie_db;*/

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE File (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255),
    mime_type VARCHAR(50),
    `key` VARCHAR(255),
    url VARCHAR(255),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES User(id)
);

CREATE TABLE Country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);


CREATE TABLE Person (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES Country(id)
);

CREATE TABLE Person_Photo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    file_id INT,
    is_primary BOOLEAN,
    FOREIGN KEY (person_id) REFERENCES Person(id),
    FOREIGN KEY (file_id) REFERENCES File(id)
);

CREATE TABLE Movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(15, 2),
    release_date DATE,
    duration INT,
    director_id INT,
    country_id INT,
    poster_id INT,
    FOREIGN KEY (director_id) REFERENCES Person(id),
    FOREIGN KEY (country_id) REFERENCES Country(id),
    FOREIGN KEY (poster_id) REFERENCES File(id)
);

CREATE TABLE Genre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);


CREATE TABLE Movie_Genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);

CREATE TABLE `Character` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    role ENUM('leading', 'supporting', 'background'),
    movie_id INT,
    person_id INT,
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Favorite_Movie (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id)
);

CREATE TABLE Movie_Participation (
    movie_id INT,
    person_id INT,
    role ENUM('leading', 'supporting', 'background'),
    PRIMARY KEY (movie_id, person_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);


INSERT INTO User (username, first_name, last_name, email, password) VALUES
('johndoe', 'John', 'Doe', 'johndoe@example.com', 'password1'),
('janedoe', 'Jane', 'Doe', 'janedoe@example.com', 'password2'),
('alice', 'Alice', 'Smith', 'alice@example.com', 'password3');


INSERT INTO File (file_name, mime_type, `key`, url, user_id) VALUES
('poster_jurassic_park.jpg', 'image/jpeg', 'posters/jurassic_park.jpg', 'https://example.com/posters/jurassic_park.jpg', 1),
('poster_inception.jpg', 'image/jpeg', 'posters/inception.jpg', 'https://example.com/posters/inception.jpg', 2),
('poster_pulp_fiction.jpg', 'image/jpeg', 'posters/pulp_fiction.jpg', 'https://example.com/posters/pulp_fiction.jpg', 3),
('poster_fight_club.jpg', 'image/jpeg', 'posters/fight_club.jpg', 'https://example.com/posters/fight_club.jpg', 1),
('poster_avengers_endgame.jpg', 'image/jpeg', 'posters/avengers_endgame.jpg', 'https://example.com/posters/avengers_endgame.jpg', 1),
('poster_dune.jpg', 'image/jpeg', 'posters/dune.jpg', 'https://example.com/posters/dune.jpg', 1),
('poster_spider_man_no_way_home.jpg', 'image/jpeg', 'posters/spider_man_no_way_home.jpg', 'https://example.com/posters/spider_man_no_way_home.jpg', 1),
('director_photo_1.jpg', 'image/jpeg', 'photos/director_photo_1.jpg', 'https://example.com/photos/director_photo_1.jpg', 1),
('director_photo_2.jpg', 'image/jpeg', 'photos/director_photo_2.jpg', 'https://example.com/photos/director_photo_2.jpg', 2),
('director_photo_3.jpg', 'image/jpeg', 'photos/director_photo_3.jpg', 'https://example.com/photos/director_photo_3.jpg', 3);




INSERT INTO Country (name) VALUES
('USA'),
('Canada'),
('UK');


INSERT INTO Person (first_name, last_name, biography, date_of_birth, gender, country_id) VALUES
('Steven', 'Spielberg', 'American filmmaker.', '1946-12-18', 'Male', 1), -- ID 1
('Christopher', 'Nolan', 'British-American film director.', '1970-07-30', 'Male', 3), -- ID 2
('Quentin', 'Tarantino', 'American filmmaker.', '1963-03-27', 'Male', 1), -- ID 3
('Jon', 'Watts', 'American filmmaker.', '1981-06-28', 'Male', 3), -- ID 4
('Tom', 'Holland', 'British actor known for Spider-Man role.', '1996-06-01', 'Male', 3), -- ID 5
('Denis', 'Villeneuve', 'Canadian filmmaker.', '1967-10-03', 'Male', 2); -- ID 6



INSERT INTO Person_Photo (person_id, file_id, is_primary) VALUES
(1, 8, TRUE), -- Steven Spielberg
(2, 9, TRUE), -- Denis Villeneuve
(3, 10, TRUE); -- Jon Watts




INSERT INTO Movie (title, description, budget, release_date, duration, director_id, country_id, poster_id) VALUES
('Jurassic Park', 'A theme park suffers a major power breakdown that allows its cloned dinosaur exhibits to run amok.', 63000000, '1993-06-11', 127, 1, 1, 1),
('Inception', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 160000000, '2010-07-16', 148, 2, 3, 2),
('Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 8000000, '1994-10-14', 154, 3, 1, 3),
('Fight Club', 'An insomniac office worker and a soap salesman build a global organization to help vent male aggression.', 63000000, '1999-10-15', 139, 3, 1, 4),
('Avengers: Endgame', 'The Avengers assemble once more to reverse Thanos\' actions and restore balance to the universe.', 356000000, '2019-04-26', 181, 1, 1, 4),
('Dune', 'A noble family becomes embroiled in a war for control of the galaxy\'s most valuable asset while its heir becomes troubled by visions of a dark future.', 165000000, '2023-10-22', 155, 6, 1, 5),
('Spider-Man: No Way Home', 'Peter Parker seeks the help of Doctor Strange to erase his secret identity from the world’s memory.', 200000000, '2021-12-17', 148, 4, 3, 10);



INSERT INTO Genre (name) VALUES
('Action'),
('Drama'),
('Thriller');


INSERT INTO Movie_Genre (movie_id, genre_id) VALUES
(5, 1), -- Avengers: Endgame (Action)
(6, 1), -- Dune (Action)
(6, 2), -- Dune (Drama)
(7, 1), -- Spider-Man: No Way Home (Action)
(7, 2); -- Spider-Man: No Way Home (Drama)



INSERT INTO `Character` (name, description, role, movie_id, person_id) VALUES
('Dr. Alan Grant', 'A paleontologist who is invited to Jurassic Park.', 'leading', 1, 4),
('Dom Cobb', 'A professional thief who specializes in conning secrets from his victims by infiltrating their dreams.', 'leading', 2, 4),
('Vincent Vega', 'A hitman working for mob boss Marsellus Wallace.', 'leading', 3, 4),
('Tyler Durden', 'An insomniac office worker who builds a global organization.', 'leading', 5, 4),
('Spider-Man', 'A superhero with spider-like abilities.', 'leading', 7, 5),
('Paul Atreides', 'The heir to House Atreides who becomes embroiled in a struggle for control of the desert planet Arrakis.', 'leading', 6, 6);


    
INSERT INTO Favorite_Movie (user_id, movie_id) VALUES
(1, 1),
(2, 2),
(3, 3);


INSERT INTO Movie_Participation (movie_id, person_id, role) VALUES
(1, 1, 'supporting'),
(2, 2, 'leading'),
(3, 3, 'leading'),
(4, 3, 'leading'),
(5, 3, 'leading'),
(5, 1, 'leading'), 
(6, 2, 'leading'), 
(7, 3, 'leading'); 


# Movie Database

## Database structure

- **User**: Stores user information.
- **File**: Stores information about files (avatars, posters, photos).
- **Country**: Stores information about countries.
- **Person**: Stores information about people (directors, actors).
- **Movie**: Stores movie information.
- **Genre**: Stores information about movie genres.
- **Movie_Genre**: Associates movies with genres (many-to-many).
- **Character**: Stores information about characters in movies.
- **Favorite_Movie**: Stores information about users' favorite movies.
- **Person_Photo**: Stores persons' photos (main and addiotional).
- **Movie_Participation**: Stores information about actors' participation in films. 

## ER Diagram

```mermaid
erDiagram
    USER {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password
    }

    FILE {
        int id PK
        string file_name
        string mime_type
        string key
        string url
        int user_id FK
    }

    COUNTRY {
        int id PK
        string name
    }

    PERSON {
        int id PK
        string first_name
        string last_name
        string biography
        date date_of_birth
        string gender
        int country_id FK
    }

    PERSON_PHOTO {
        int id PK
        int person_id FK
        int file_id FK
        boolean is_primary
    }

    MOVIE {
        int id PK
        string title
        string description
        decimal budget
        date release_date
        int duration
        int director_id FK
        int country_id FK
        int poster_id FK
    }

    GENRE {
        int id PK
        string name
    }

    MOVIE_GENRE {
        int movie_id PK, FK
        int genre_id PK, FK
    }

    CHARACTER {
        int id PK
        string name
        string description
        string role
        int movie_id FK
        int person_id FK
    }

    FAVORITE_MOVIE {
        int user_id PK, FK
        int movie_id PK, FK
    }

    MOVIE_PARTICIPATION {
        int movie_id PK, FK
        int person_id PK, FK
        string role
    }

    USER ||--o{ FILE: "has"
    USER ||--o{ FAVORITE_MOVIE: "favorites"
    FILE ||--o| USER: "belongs to"
    FILE ||--o| PERSON_PHOTO: "is"
    FILE ||--o| MOVIE: "is poster of"
    COUNTRY ||--o| PERSON: "is origin of"
    COUNTRY ||--o| MOVIE: "is filmed in"
    PERSON ||--o{ CHARACTER: "portrays"
    PERSON ||--o{ PERSON_PHOTO: "has"
    MOVIE ||--o{ CHARACTER: "features"
    MOVIE ||--o{ FAVORITE_MOVIE: "favorited by"
    MOVIE ||--o{ MOVIE_GENRE: "has"
    GENRE ||--o{ MOVIE_GENRE: "is genre of"
    PERSON ||--o{ MOVIE: "directs"
    MOVIE ||--o{ MOVIE_PARTICIPATION: "features"
    PERSON ||--o{ MOVIE_PARTICIPATION: "participates in"

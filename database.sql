CREATE TABLE Courses(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    description text,
    created_at date,
    updated_at date,
    is_deleted bool
);
CREATE TABLE Lessons(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id bigint REFERENCES Courses(id),
    title VARCHAR(50),
    content text,
    video_url VARCHAR(150),
    position int,
    created_at date,
    updated_at date,
    deleted_at date
);
CREATE TABLE Modules(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    description text,
    created_at date,
    updated_at date,
    deleted_at date
);
CREATE TABLE Programs(
     id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
     name VARCHAR(50),
     price int,
     program_type VARCHAR(50),
     created_at date,
     updated_at date
);
CREATE TABLE Course_Modules(
    course_id bigint REFERENCES Courses(id),
    module_id bigint REFERENCES Modules(id)
);
CREATE TABLE Programs_Modules(
    module_id bigint REFERENCES Modules(id),
    program_id bigint REFERENCES Programs(id)
);
CREATE TABLE Teaching_Groups(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(50) UNIQUE,
    created_at date,
    updated_at date
);
CREATE TABLE Users(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    email VARCHAR(50),
    password_hash VARCHAR(50) UNIQUE,
    teaching_group_id VARCHAR(100),
    created_at date,
    updated_at date,
    group_id bigint REFERENCES TeachingGroups(id),
    role VARCHAR(50) CHECK (user_role IN ('student', 'teacher', 'admin')),
    deleted_at date
);
CREATE TABLE Enrollments(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES Users(id),
    program_id bigint REFERENCES  Programs(id),
    status VARCHAR(50) CHECK (sub_status IN ('active', 'pending', 'cancelled', 'completed')),
    created_at date,
    updated_at date
);
CREATE TABLE Payments(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id bigint,
    amount int,
    status VARCHAR(50) CHECK (pay_status IN ('pending', 'paid', 'failed', 'refunded')),
    paid_at date,
    created_at date,
    updated_at date
);
CREATE TABLE Program_Completions(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES Users(id),
    program_id bigint REFERENCES Programs(id),
    complete_status VARCHAR(50) CHECK (complete_status IN ('active', 'completed', 'pending', 'cancelled')),
    program_beginning date,
    program_end date,
    created_at date,
    updated_at date
);
CREATE TABLE Certificates(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES Users(id),
    program_id bigint REFERENCES Programs(id),
    url VARCHAR(100),
    issued_at date,
    created_at date,
    updated_at date
);
CREATE TABLE Quizzes(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint,
    title VARCHAR(50),
    content text,
    created_at date,
    updated_at date
);
CREATE TABLE Exercises(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint,
    name VARCHAR(50),
    url VARCHAR(100),
    created_at date,
    updated_at date
);
CREATE TABLE Discussions(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES Lessons(id),
    user_id bigint REFERENCES Users(id),
    text text,
    created_at date,
    updated_at date
);
CREATE TABLE Blogs(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    student_id bigint REFERENCES Users(id),
    article_title VARCHAR(50),
    article_txt text,
    article_status VARCHAR(50) CHECK (article_status IN ('created', 'in moderation', 'published', 'archived')),
    created_at date,
    updated_at date
);

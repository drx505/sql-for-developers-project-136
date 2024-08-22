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
    title VARCHAR(50),
    content text,
    video_link VARCHAR(150),
    posit int,
    created_at date,
    updated_at date,
    course_link VARCHAR(150),
    course_id bigint REFERENCES Courses(id),
    is_deleted bool
);
CREATE TABLE Modules(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    description text,
    created_at date,
    updated_at date
);
CREATE TABLE Programs(
     id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
     title VARCHAR(50),
     price int,
     program_type VARCHAR(50),
     created_at date,
     updated_at date
);
CREATE TABLE CoursesOfModules(
    course_id bigint REFERENCES Courses(id),
    module_id bigint REFERENCES Modules(id)
);
CREATE TABLE ModulesOfPrograms(
    module_id bigint REFERENCES Modules(id),
    program_id bigint REFERENCES Programs(id)
);
CREATE TABLE TeachingGroups(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(50) UNIQUE,
    created_at date,
    updated_at date
);
CREATE TABLE Users(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50) UNIQUE,
    group_link VARCHAR(100),
    created_at date,
    updated_at date,
    group_id bigint REFERENCES TeachingGroups(id),
    user_role VARCHAR(50)
);
CREATE TABLE Enrollments(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES Users(id),
    program_id bigint REFERENCES  Programs(id),
    sub_status VARCHAR(50),
    created_at date,
    updated_at date
);
CREATE TABLE Payments(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    sub_id bigint,
    pay_sum int,
    pay_status VARCHAR(50),
    pay_date date,
    created_at date,
    updated_at date
);
CREATE TABLE ProgramCompletions(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES Users(id),
    program_id bigint REFERENCES Programs(id),
    complete_status VARCHAR(50),
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
    certificate_date date,
    created_at date,
    updated_at date
);
CREATE TABLE Quizzes(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint,
    test_title VARCHAR(50),
    content text,
    created_at date,
    updated_at date
);
CREATE TABLE Exercises(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint,
    exercise_title VARCHAR(50),
    url VARCHAR(100),
    created_at date,
    updated_at date
);
CREATE TABLE Discussions(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES Lessons(id),
    discuss_txt text,
    created_at date,
    updated_at date
);
CREATE TABLE Blog(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    student_id bigint REFERENCES Users(id),
    article_title VARCHAR(50),
    article_txt text,
    article_status VARCHAR(50),
    created_at date,
    updated_at date
);
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
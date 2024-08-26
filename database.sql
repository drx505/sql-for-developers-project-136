CREATE TABLE courses(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    description text,
    created_at date,
    updated_at date,
    is_deleted bool
);
CREATE TABLE lessons(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id bigint REFERENCES courses(id),
    title VARCHAR(50),
    content text,
    video_url VARCHAR(150),
    position int,
    created_at date,
    updated_at date,
    deleted_at date
);
CREATE TABLE modules(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    description text,
    created_at date,
    updated_at date,
    deleted_at date
);
CREATE TABLE programs(
     id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
     name VARCHAR(50),
     price int,
     program_type VARCHAR(50),
     created_at date,
     updated_at date
);
CREATE TABLE course_modules(
    course_id bigint REFERENCES courses(id),
    module_id bigint REFERENCES modules(id),
    PRIMARY KEY (course_id, module_id)
);
CREATE TABLE programs_modules(
    module_id bigint REFERENCES modules(id),
    program_id bigint REFERENCES programs(id),
    PRIMARY KEY (program_id, module_id)
);
CREATE TABLE teaching_groups(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(50) UNIQUE,
    created_at date,
    updated_at date
);
CREATE TABLE users(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    email VARCHAR(50),
    password_hash VARCHAR(50) UNIQUE,
    teaching_group_id VARCHAR(100),
    created_at date,
    updated_at date,
    group_id bigint REFERENCES teaching_groups(id),
    role VARCHAR(50) CHECK (role IN ('student', 'teacher', 'admin')),
    deleted_at date
);
CREATE TABLE enrollments(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    status VARCHAR(50) CHECK (status IN ('active', 'pending', 'cancelled', 'completed')),
    created_at date,
    updated_at date
);
CREATE TABLE payments(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id bigint,
    amount int,
    status VARCHAR(50) CHECK (status IN ('pending', 'paid', 'failed', 'refunded')),
    paid_at date,
    created_at date,
    updated_at date
);
CREATE TABLE program_completions(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    complete_status VARCHAR(50) CHECK (complete_status IN ('active', 'completed', 'pending', 'cancelled')),
    program_beginning date,
    program_end date,
    created_at date,
    updated_at date
);
CREATE TABLE certificates(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    url VARCHAR(100),
    issued_at date,
    created_at date,
    updated_at date
);
CREATE TABLE quizzes(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint,
    title VARCHAR(50),
    content text,
    created_at date,
    updated_at date
);
CREATE TABLE exercises(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint,
    name VARCHAR(50),
    url VARCHAR(100),
    created_at date,
    updated_at date
);
CREATE TABLE discussions(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES lessons(id),
    user_id bigint REFERENCES users(id),
    text text,
    created_at date,
    updated_at date
);
CREATE TABLE blogs(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    student_id bigint REFERENCES users(id),
    article_title VARCHAR(50),
    article_txt text,
    article_status VARCHAR(50) CHECK (article_status IN ('created', 'in moderation', 'published', 'archived')),
    created_at date,
    updated_at date
);

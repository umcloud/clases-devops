-- Create the database
CREATE DATABASE IF NOT EXISTS persona_db;

-- Use the newly created database
USE persona_db;

-- Create a table for personas
CREATE TABLE IF NOT EXISTS personas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    occupation VARCHAR(100),
    bio TEXT
);

-- Insert multiple personas with Spanish names
INSERT INTO personas (name, age, occupation, bio) VALUES
('María González', 28, 'Maestra', 'Educadora apasionada con experiencia en educación primaria.'),
('Carlos Rodríguez', 35, 'Arquitecto', 'Diseñador innovador con un enfoque en sustentabilidad.'),
('Ana Martínez', 42, 'Médica', 'Especialista en pediatría con 15 años de experiencia.'),
('Javier López', 31, 'Chef', 'Experto en cocina mediterránea y fusion.'),
('Isabel Fernández', 39, 'Abogada', 'Especializada en derecho laboral y derechos humanos.'),
('Miguel Sánchez', 45, 'Empresario', 'Fundador de una startup de tecnología verde.'),
('Laura Torres', 29, 'Periodista', 'Reportera investigativa con enfoque en temas sociales.'),
('Ricardo Herrera', 33, 'Ingeniero de Software', 'Desarrollador full-stack con pasión por la IA.'),
('Elena Díaz', 37, 'Psicóloga', 'Terapeuta cognitivo-conductual con experiencia en trauma.'),
('Pablo Ruiz', 40, 'Profesor Universitario', 'Investigador en el campo de la física cuántica.');

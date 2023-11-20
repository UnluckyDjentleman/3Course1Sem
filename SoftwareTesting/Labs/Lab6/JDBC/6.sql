CREATE TABLE Cities (
    city_id INT PRIMARY KEY IDENTITY(1,1),
    city_name VARCHAR(255) NOT NULL,
    foundation_year INT NOT NULL,
    area FLOAT NOT NULL,
    population INT NOT NULL
);

CREATE TABLE Residents (
    resident_id INT PRIMARY KEY IDENTITY(1,1),
    city_id INT,
    resident_name VARCHAR(255) NOT NULL,
    language_spoken VARCHAR(255) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- Пример добавления данных в таблицу Cities для 10 городов Европы
INSERT INTO Cities (city_name, foundation_year, area, population)
VALUES 
    ('Минск', 1000, 105.4, 2141000),
    ('Витебск', 1237, 891.7, 3669491),
    ('Полоцк', 753, 1285, 2873000),
    ('Орша', 880, 604.3, 3348536),
    ('Гомель', 1275, 219.3, 872680),
    ('Брест', 1252, 188.0, 975904),
    ('Лида', 1137, 414.6, 1897491),
    ('Гродно', 880, 496.0, 1301132),
    ('Могилев', 508, 38.96, 664046),
    ('Брест', 1300, 517.2, 1790658);

INSERT INTO Residents (city_id, resident_name, language_spoken)
VALUES 
    (1, 'Алексей Смирнов', 'Белорусский'),
    (1, 'Ольга Иванова', 'Русский'),
    (2, 'Виктор Петров', 'Белорусский'),
    (2, 'Елена Сидорова', 'Белорусский'),
    (3, 'Сергей Кузнецов', 'Английский'),
    (3, 'Наталья Попова', 'Испанский'),
    (4, 'Андрей Васильев', 'Белорусский'),
    (4, 'Татьяна Павлова', 'Белорусский'),
    (5, 'Иван Соколов', 'Русский'),
    (5, 'Мария Михайлова', 'Белорусский'),
    (6, 'Дмитрий Новиков', 'Русский'),
    (6, 'Анна Федорова', 'Английский'),
    (7, 'Павел Морозов', 'Белорусский'),
    (7, 'Ирина Волкова', 'Китайский'),
    (8, 'Евгений Алексеев', 'Белорусский'),
    (8, 'Светлана Лебедева', 'Русский'),
    (9, 'Николай Осипов', 'Русский'),
    (9, 'Юлия Григорьева', 'Английский'),
    (10, 'Михаил Петров', 'Белорусский'),
    (10, 'Екатерина Никитина', 'Белорусский');


--Вывести информацию обо всех жителях заданного города, разговаривающих на заданном языке
select *
from Residents
join Cities ON Residents.city_id = Cities.city_id
where Cities.city_name = 'Минск' and Residents.language_spoken = 'Белорусский';

--Вывести информацию обо всех городах, в которых проживают жители выбранного типа
SELECT DISTINCT Cities.*
FROM Cities
JOIN Residents ON Cities.city_id = Residents.city_id
WHERE Residents.language_spoken = 'Английский';

--Информация о городе с заданным количеством населения и всех типах жителей, в нем проживающих
SELECT Cities.*, Residents.resident_name, Residents.language_spoken
FROM Cities
JOIN Residents ON Cities.city_id = Residents.city_id
WHERE Cities.population = 2141000;

--Информация о самом древнем типе жителей
SELECT *
FROM Residents
ORDER BY resident_id ASC
LIMIT 1;
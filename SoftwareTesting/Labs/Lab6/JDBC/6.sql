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

-- ������ ���������� ������ � ������� Cities ��� 10 ������� ������
INSERT INTO Cities (city_name, foundation_year, area, population)
VALUES 
    ('�����', 1000, 105.4, 2141000),
    ('�������', 1237, 891.7, 3669491),
    ('������', 753, 1285, 2873000),
    ('����', 880, 604.3, 3348536),
    ('������', 1275, 219.3, 872680),
    ('�����', 1252, 188.0, 975904),
    ('����', 1137, 414.6, 1897491),
    ('������', 880, 496.0, 1301132),
    ('�������', 508, 38.96, 664046),
    ('�����', 1300, 517.2, 1790658);

INSERT INTO Residents (city_id, resident_name, language_spoken)
VALUES 
    (1, '������� �������', '�����������'),
    (1, '����� �������', '�������'),
    (2, '������ ������', '�����������'),
    (2, '����� ��������', '�����������'),
    (3, '������ ��������', '����������'),
    (3, '������� ������', '���������'),
    (4, '������ ��������', '�����������'),
    (4, '������� �������', '�����������'),
    (5, '���� �������', '�������'),
    (5, '����� ���������', '�����������'),
    (6, '������� �������', '�������'),
    (6, '���� ��������', '����������'),
    (7, '����� �������', '�����������'),
    (7, '����� �������', '���������'),
    (8, '������� ��������', '�����������'),
    (8, '�������� ��������', '�������'),
    (9, '������� ������', '�������'),
    (9, '���� ����������', '����������'),
    (10, '������ ������', '�����������'),
    (10, '��������� ��������', '�����������');


--������� ���������� ��� ���� ������� ��������� ������, ��������������� �� �������� �����
select *
from Residents
join Cities ON Residents.city_id = Cities.city_id
where Cities.city_name = '�����' and Residents.language_spoken = '�����������';

--������� ���������� ��� ���� �������, � ������� ��������� ������ ���������� ����
SELECT DISTINCT Cities.*
FROM Cities
JOIN Residents ON Cities.city_id = Residents.city_id
WHERE Residents.language_spoken = '����������';

--���������� � ������ � �������� ����������� ��������� � ���� ����� �������, � ��� �����������
SELECT Cities.*, Residents.resident_name, Residents.language_spoken
FROM Cities
JOIN Residents ON Cities.city_id = Residents.city_id
WHERE Cities.population = 2141000;

--���������� � ����� ������� ���� �������
SELECT *
FROM Residents
ORDER BY resident_id ASC
LIMIT 1;
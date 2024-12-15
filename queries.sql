SELECT 
    t.FirstName, 
    t.LastName, 
    CASE 
        WHEN t.Gender = 'Male' THEN 'MALE'
        WHEN t.Gender = 'Female' THEN 'FEMALE'
        ELSE 'OTHER' 
    END AS Gender,
    c.Name AS CountryName, 
    c.AverageSalary
FROM Trainer t
JOIN Country c ON t.CountryID = c.CountryID;

SELECT 
    a.ActivityCode, 
    a.Schedule, 
    STRING_AGG(CONCAT(t.LastName, ', ', LEFT(t.FirstName, 1)), '; ') AS HeadTrainers
FROM Activity a
JOIN ActivityTrainer at ON a.ActivityID = at.ActivityID
JOIN Trainer t ON at.TrainerID = t.TrainerID
WHERE at.TrainerRole = 'Head Trainer'
GROUP BY a.ActivityCode, a.Schedule;

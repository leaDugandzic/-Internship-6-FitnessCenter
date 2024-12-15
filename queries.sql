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

SELECT 
    fc.Name AS FitnessCenter, 
    COUNT(a.ActivityID) AS ActivityCount
FROM FitnessCenter fc
JOIN Trainer t ON fc.FitnessCenterID = t.FitnessCenterID
JOIN ActivityTrainer at ON t.TrainerID = at.TrainerID
JOIN Activity a ON at.ActivityID = a.ActivityID
GROUP BY fc.FitnessCenterID, fc.Name
ORDER BY ActivityCount DESC
LIMIT 3;

SELECT 
    t.FirstName, 
    t.LastName,
    CASE
        WHEN COUNT(at.ActivityID) = 0 THEN 'AVAILABLE'
        WHEN COUNT(at.ActivityID) BETWEEN 1 AND 3 THEN 'ACTIVE'
        ELSE 'FULLY BOOKED'
    END AS Status
FROM Trainer t
LEFT JOIN ActivityTrainer at ON t.TrainerID = at.TrainerID
GROUP BY t.TrainerID;

SELECT DISTINCT 
    m.FirstName, 
    m.LastName
FROM Member m
JOIN Participation p ON m.MemberID = p.MemberID;

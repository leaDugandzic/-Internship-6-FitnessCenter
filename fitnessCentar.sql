CREATE TABLE FitnessCenter (
    FitnessCenterID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    WorkingHours VARCHAR(50) NOT NULL
);

CREATE TABLE Country (
    CountryID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Population INT NOT NULL,
    AverageSalary NUMERIC(10, 2) NOT NULL
);

CREATE TABLE Trainer (
    TrainerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Unknown', 'Other')),
    CountryID INT NOT NULL REFERENCES Country(CountryID),
    FitnessCenterID INT NOT NULL REFERENCES FitnessCenter(FitnessCenterID)
);

CREATE TABLE ActivityType (
    TypeID SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL CHECK (Name IN ('Strength Training', 'Cardio', 'Yoga', 'Dance', 'Injury Rehabilitation'))
);

CREATE TABLE Activity (
    ActivityID SERIAL PRIMARY KEY,
    ActivityCode VARCHAR(10) NOT NULL,
    TypeID INT NOT NULL REFERENCES ActivityType(TypeID),
    Schedule TEXT NOT NULL,
    Capacity INT NOT NULL,
    PricePerSession NUMERIC(10, 2) NOT NULL
);

CREATE TABLE ActivityTrainer (
    ActivityTrainerID SERIAL PRIMARY KEY,
    ActivityID INT NOT NULL REFERENCES Activity(ActivityID),
    TrainerID INT NOT NULL REFERENCES Trainer(TrainerID),
    TrainerRole VARCHAR(20) NOT NULL CHECK (TrainerRole IN ('Head Trainer', 'Assistant Trainer'))
);

CREATE TABLE Member (
    MemberID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

CREATE TABLE Participation (
    ParticipationID SERIAL PRIMARY KEY,
    MemberID INT NOT NULL REFERENCES Member(MemberID),
    ActivityID INT NOT NULL REFERENCES Activity(ActivityID),
    RegistrationDate TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION CheckHeadTrainerLimit()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM ActivityTrainer WHERE TrainerID = NEW.TrainerID AND TrainerRole = 'Head Trainer') >= 2 THEN
        RAISE EXCEPTION 'A trainer cannot be the head trainer for more than 2 activities.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerHeadTrainerLimit
BEFORE INSERT ON ActivityTrainer
FOR EACH ROW
WHEN (NEW.TrainerRole = 'Head Trainer')
EXECUTE FUNCTION CheckHeadTrainerLimit();

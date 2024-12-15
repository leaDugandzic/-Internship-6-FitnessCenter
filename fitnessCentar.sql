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
    Gender VARCHAR(10) CHECK (Gender IN ('MALE', 'FEMALE', 'UNKNOWN', 'OTHER')),
    CountryID INT NOT NULL REFERENCES Country(CountryID),
    FitnessCenterID INT NOT NULL REFERENCES FitnessCenter(FitnessCenterID)
);

CREATE TABLE ActivityType (
    TypeID SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL CHECK (Name IN ('Strength Training', 'Cardio', 'Yoga', 'Dance', 'Injury Rehabilitation'))
);

CREATE TABLE Activity (
    ActivityID SERIAL PRIMARY KEY,
    ActivityCode VARCHAR(10) NOT NULL UNIQUE,
    TypeID INT NOT NULL REFERENCES ActivityType(TypeID),
    Schedule TIMESTAMP NOT NULL,
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
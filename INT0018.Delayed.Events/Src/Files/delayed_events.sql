CREATE TABLE delayed_events (
    id int IDENTITY(1,1) PRIMARY KEY,
    body varchar(MAX) NOT NULL,
    timestamp timestamp NOT NULL,
    ack int NOT NULL
);

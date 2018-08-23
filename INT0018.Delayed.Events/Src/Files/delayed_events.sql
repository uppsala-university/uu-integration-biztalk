CREATE TABLE delayed_events (
    id int IDENTITY(1,1) PRIMARY KEY,
    body varchar(MAX) NOT NULL,
    eventTime datetime NOT NULL,
	eventUID varchar(MAX) NOT NULL
);

DROP TABLE IF EXISTS
    types,
    sectors,
    markets,
    tickers,
    relevant_facts_schedules,
    past_executions,
    relevant_facts;


CREATE TABLE types
(
    id    VARCHAR(36)  NOT NULL,
    label VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE sectors
(
    id    VARCHAR(36)  NOT NULL,
    label VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE markets
(
    id    VARCHAR(36)  NOT NULL,
    label VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE tickers
(
    ticker_id    VARCHAR(36)  NOT NULL, # Random UUID to relationships
    ticker_name  VARCHAR(10)  NOT NULL, # Ex: PETR4
    type_id      VARCHAR(36)  NOT NULL, # Ex: 1
    sector_id    VARCHAR(36)  NOT NULL, # Ex: 2
    market_id    VARCHAR(36)  NOT NULL, # Ex: 3
    company_name VARCHAR(255) NOT NULL, # Ex: 4
    inserted_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ticker_id),
    CONSTRAINT key_ticker_market UNIQUE (ticker_name, market_id),
    FOREIGN KEY (type_id) REFERENCES types (id),
    FOREIGN KEY (sector_id) REFERENCES sectors (id),
    FOREIGN KEY (market_id) REFERENCES markets (id)
);


CREATE TABLE relevant_facts_schedules
(
    id               VARCHAR(36) NOT NULL,
    ticker           VARCHAR(20) NOT NULL,
    last_event_date  DATETIME,
    last_event_title VARCHAR(255),
    has_data         BOOLEAN,
    updated_at       DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (ticker) REFERENCES tickers (ticker_id)
);


CREATE TABLE past_executions
(
    id          VARCHAR(36) NOT NULL,
    ticker      VARCHAR(20) NOT NULL,
    schedule_id VARCHAR(36) NOT NULL,
    updated_at  DATETIME    NOT NULL,
    facts_found INT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ticker) REFERENCES tickers (ticker_id),
    FOREIGN KEY (schedule_id) REFERENCES relevant_facts_schedules (id)
);


CREATE TABLE relevant_facts
(
    id          VARCHAR(36)  NOT NULL,
    ticker      VARCHAR(20)  NOT NULL,
    schedule_id VARCHAR(36)  NOT NULL,
    title       VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    file_path   VARCHAR(255),
    date        DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (ticker) REFERENCES tickers (ticker_id)
);


create database if not exists ${DATABASE_NAME};
use ${DATABASE_NAME};

create user ${DATABASE_USER};
grant ALL PRIVILEGES on `${DATABASE_NAME}`.* to ${DATABASE_USER};

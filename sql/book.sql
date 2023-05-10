create table book
(
    ID        int auto_increment
        primary key,
    Name      varchar(100) null,
    Author    varchar(20)  null,
    Publisher varchar(100) null,
    Price     double       null,
    ISBN      varchar(20)  null
);


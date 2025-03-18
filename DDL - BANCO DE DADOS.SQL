create table user_address(
    id serial primary key,
    country varchar(200) not null,
    state varchar(200) not null,
    city varchar(200) not null,
    zip_code varchar(200) not null,
    neighborhood varchar(200) not null,
    road varchar(200) not null,
    number_address int check (number_address > 0) not null,
    complement varchar(200) not null
);

create table citizens(
    id serial primary key,
    name varchar(200) not null,
    phone varchar(200) not null,
    email varchar(200) unique not null,
    id_user_address int not null,
    FOREIGN KEY (id_user_address) references user_address(id)
        ON DELETE SET NULL
);

create table manager(
    id serial primary key,
    name varchar(200) not null,
    phone varchar(200) not null,
    email varchar(200) unique not null,
    id_user_address int not null,
    FOREIGN KEY (id_user_address) references user_address(id)
        ON DELETE SET NULL
);

create table notification(
    id serial primary key,
    message varchar(200) not null,
    message_type varchar(200) not null,
    sent_at timestamp,
    id_citizens int not null,
    FOREIGN KEY (id_citizens) references citizens(id)
);

create table priorities(
    id serial primary key,
    level varchar(200) not null
);

create table occurence_address(
    id serial primary key,
    country varchar(200) not null,
    state varchar(200) not null, 
    city varchar(200) not null,
    zip_code varchar(200) not null,
    neighborhood varchar(200) not null,
    road varchar(200) not null,
    number_occurence varchar(200) not null,
    complement varchar(200) not null
);

create table evaluations(
    id serial primary key,
    rating int not null,
    feedback varchar(200)
);

create table category(
    id serial primary key,
    name varchar(200) not null
);

create table occurrence(
    id serial primary key,
    status varchar(200) not null,
    description varchar(200) not null,
    id_citizens int not null,
    id_priorities int not null,
    id_manager int not null,
    id_address_occurrence int not null,
    id_evaluations int not null,
    FOREIGN KEY (id_citizens) 
        REFERENCES citizens(id)
        ON DELETE SET NULL,
    FOREIGN KEY (id_priorities) 
        REFERENCES priorities(id)
        ON DELETE SET NULL,  
    FOREIGN KEY (id_manager) 
        REFERENCES manager(id)
        ON DELETE SET NULL, 
    FOREIGN KEY (id_address_occurrence) 
        REFERENCES occurence_address(id)
        ON DELETE CASCADE, 
    FOREIGN KEY (id_evaluations) 
        REFERENCES evaluations(id)
        ON DELETE SET NULL
);

create table occurrence_category(
    id serial primary key,
    id_occurrence int not null,
    id_category int not null,
    FOREIGN KEY (id_occurrence) 
        REFERENCES occurrence(id)
        ON DELETE SET NULL,
    FOREIGN KEY (id_category) 
        REFERENCES category(id)
        ON DELETE SET NULL
);

create table attachments(
    id serial primary key,
    file_path varchar(200) not null,
    id_occurrence int not null,
    FOREIGN KEY (id_occurrence) 
        REFERENCES occurrence(id)
        ON DELETE SET NULL
);

create table history(
    id serial primary key,
    change_description varchar(200) not null,
    changed_at timestamp not null,
    id_occurrence int not null,
    FOREIGN KEY (id_occurrence) 
        REFERENCES occurrence(id)
        ON DELETE SET NULL
);

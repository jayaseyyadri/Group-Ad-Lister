CREATE DATABASE IF NOT EXISTS comrade_snifter_db;

use comrade_snifter_db;
drop table IF EXISTS category;
drop table IF EXISTS drink_Category;
drop table IF EXISTS drinks;
drop table IF EXISTS users;
Create table if not exists users(
                                    id int unsigned not null auto_increment primary key,
                                    username varchar(255) not null,
                                    email varchar(255) not null,
                                    password varchar(255) not null,
                                    drink_favorite varchar(255) # a list of drink id's as favorites can be queried and pulled out as an int list
);
CREATE table if not exists drinks(
                                     id int unsigned not null auto_increment primary key,
                                     user_id int unsigned not null,
                                     name varchar(255) not null,
                                     instructions varchar(255) not null,
                                     ingredients varchar(255) not null,
                                     image TEXT,
                                     votes int not null default 0,
                                     FOREIGN KEY (user_id) references users(id)
);
create table if not exists drink_Category(
                                             id int unsigned auto_increment primary key,
                                             name varchar(255) #      BRANDY, WHISKEY, BOURBON
);
create table if not exists category(
                                       alcohol_id int unsigned not null,
                                       liquor_type int unsigned not null,
                                       FOREIGN KEY (alcohol_id) references drinks(id),
                                       FOREIGN KEY (liquor_type) references drink_Category(id)
);

insert into users(username, email, password, is_admin) VALUES ('admin', 'admin@ad.min', '$2a$12$o5y9Peq1GDMgGQiR5gyS6OtROQO4SKe0uWrSg8rq0wSNXoLEEpn5e', 1);
insert into users(username, email, password, is_admin, image) VALUES ('mattB', 'mattB@comrade.snifter', '$2a$12$SCUvA7G9YVoVjA7lpATkbeTP8Emhx.2ZTRTDfPPrTi7GKj2wkwJCC', 1, 'http://localhost:8080/resources/img/matt.jpg');
insert into users(username, email, password, is_admin, image) VALUES ('willCS', 'willCS@comrade.snifter', '$2a$12$o5y9Peq1GDMgGQiR5gyS6OtROQO4SKe0uWrSg8rq0wSNXoLEEpn5e', 1, 'http://localhost:8080/resources/img/will.jpeg');
insert into users(username, email, password, is_admin, image) VALUES ('jaya', 'jaya@comrade.snifter', '$2a$12$o5y9Peq1GDMgGQiR5gyS6OtROQO4SKe0uWrSg8rq0wSNXoLEEpn5e', 1, 'http://localhost:8080/resources/img/jaya-admin.jpg');


insert into users(username, email, password) values ('user1', 'user@u.com', '$2a$12$o5y9Peq1GDMgGQiR5gyS6OtROQO4SKe0uWrSg8rq0wSNXoLEEpn5e');


insert into drinks(user_id, name, instructions, ingredients, image, votes) VALUES (1, 'Bermuda Highball', 'Pour brandy, gin, and dry vermouth into a highball glass over ice cubes. Fill with carbonated water and stir. Add the twist of lemon and serve. (Ginger ale may be substituted for carbonated water, if preferred.', 'Brandy 3/4 oz, Gin 3/4 oz, Dry Vermouth 3/4 oz, Carbonated water, Lemon peel', 'https://www.thecocktaildb.com/images/media/drink/qrvtww1441206528.jpg', 1);
insert into drinks(user_id, name, instructions, ingredients, image, votes) VALUES (1, 'Brandon and Will''s Coke Float', 'Scoop two large scoops of vanilla ice-cream into frosted beer mug. Next, add 2 ounces Maker''s Mark. Then, pour in coke. Gently stir and enjoy.', 'Vanilla ice-cream 2 scoops, Coca-Cola 1 can, Bourbon 2 oz', 'https://www.thecocktaildb.com/images/media/drink/xspxyr1472719185.jpg', 3);
insert into drinks(user_id, name, instructions, ingredients, image, votes) VALUES (1, 'John Collins', 'Pour all ingredients directly into highball glass filled with ice. Stir gently. Garnish. Add a dash of Angostura bitters.', 'Bourbon 2 oz, Lemon juice 1 oz, Sugar 1 tsp superfine, Club soda 3 oz, Maraschino cherry 1, Orange 1', 'https://www.thecocktaildb.com/images/media/drink/0t4bv71606854479.jpg', 4);
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (1, 'Old Fashioned', 'Place sugar cube in old fashioned glass and saturate with bitters, add a dash of plain water. Muddle until dissolved. Fill the glass with ice cubes and add whiskey. Garnish with orange twist, and a cocktail cherry', 'Bourbon 4.5 cL, Angostura bitters 2 dashes, Sugar 1 cube, Water dash', 'https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg');
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (1, 'Amaretto Shake', 'Combine all ingredients in a blender and blend at high speed until smooth. Serve in chilled glass garnished with bittersweet chocolate shavings.', 'Chocolate ice-cream 2 scoops, Brandy 2 oz, Amaretto 2 oz', 'https://www.thecocktaildb.com/images/media/drink/xk79al1493069655.jpg');
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (1, 'Gentleman''s Club', 'In an old-fashioned glass almost filled with ice cubes, combine all of the ingredients. Stir well.', 'Gin 1 1/2 oz, Brandy 1 oz, Sweet Vermouth 1 oz, Club soda 1 oz', 'https://www.thecocktaildb.com/images/media/drink/k2r7wv1582481454.jpg');
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (1, 'Port Wine Cocktail', 'Stir ingredients with ice, strain into a cocktail glass, and serve.', 'Port 2 1/2 oz, Brandy 1/2 tsp', 'https://www.thecocktaildb.com/images/media/drink/qruprq1441553976.jpg');
insert into drinks(user_id, name, instructions, ingredients, image, votes) VALUES (1, 'Porto flip', 'Shake ingredients together in a mixer with ice. Strain into glass, garnish and serve.', 'Brandy 3 parts, Port 9 parts, Egg Yolk 2 parts', 'https://www.thecocktaildb.com/images/media/drink/64x5j41504351518.jpg', 8);
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (1, 'Stinger', 'Pour in a mixing glass with ice, stir and strain into a cocktail glass. May also be served on rocks in a rocks glass.', 'Brandy 1 1/2 oz, White Creme de Menthe 1/2 oz', 'https://www.thecocktaildb.com/images/media/drink/2ahv791504352433.jpg');
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (1, 'Kioki Coffee', 'Stir. Add whipped cream to the top.', 'Kahlua 1 oz, Brandy 1/2 oz, Coffee', 'https://www.thecocktaildb.com/images/media/drink/uppqty1441247374.jpg');
insert into drinks(user_id, name, instructions, ingredients, image) VALUES (3, 'Smoky Old Fashioned', 'Put the sugar, bitters and orange juice in a tumbler Old Fashioned glass and mix muddle well. Add the ice cube to the glass and pour in the whisky.  Stir a few times and garnish with the orange peel', '1 tsp demerara sugar 3-5 drops tobacco bitters squeeze fresh orange juice (about 1 tbsp) 1 large ice cube (or 2-3 small) 2 oz whiskey of choice (65 ml) orange peel for garnish', 'https://i2.wp.com/slowthecookdown.com/wp-content/uploads/2018/09/smokey-old-fashioned-sq.jpg?resize=768%2C768&ssl=1');
insert into drinks(user_id, name, instructions, ingredients) values (5, 'Long Island Iced Tea', 'Mix it up', 'Using this');

select *
from users;



#  currently one
select *
from drinks;

# currently one     after execute of delete logged in as mattB this should be 2 and the above should no longer be a valid user
select * from drinks where user_id = 12;


select *
from drink_Category;

update users set image = 'https://static6.depositphotos.com/1128837/646/v/950/depositphotos_6464166-stock-illustration-isolated-rubber-duck.jpg' where id = 1;

insert into drink_Category (name) values ('Brandy');
insert into drink_Category (name) values ('Bourbon');
insert into drink_Category (name) values ('Whiskey');
insert into drink_Category (name) values ('Fruity');
insert into drink_Category (name) values ('Desert');


insert into category(alcohol_id, liquor_type) VALUES (1, 1);
insert into category(alcohol_id, liquor_type) VALUES (2, 5);
insert into category(alcohol_id, liquor_type) VALUES (2, 2);
insert into category(alcohol_id, liquor_type) VALUES (3, 4);
insert into category(alcohol_id, liquor_type) VALUES (3, 2);
insert into category(alcohol_id, liquor_type) VALUES (4, 2);
insert into category(alcohol_id, liquor_type) VALUES (5, 1);
insert into category(alcohol_id, liquor_type) VALUES (5, 5);
insert into category(alcohol_id, liquor_type) VALUES (6, 1);
insert into category(alcohol_id, liquor_type) VALUES (7, 1);
insert into category(alcohol_id, liquor_type) VALUES (8, 1);
insert into category(alcohol_id, liquor_type) VALUES (9, 1);
insert into category(alcohol_id, liquor_type) VALUES (10, 1);
insert into category(alcohol_id, liquor_type) values (12, 3);
insert into category(alcohol_id, liquor_type) values (12, 4);

select * from category;

select * from drinks where id in (
    select alcohol_id from category where liquor_type in (
        select id from drink_Category where drink_Category.name = 'Desert'
        )
    );

select id from drink_Category where name = 'Brandy';

select * from drink_Category;
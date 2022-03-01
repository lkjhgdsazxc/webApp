CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
INSERT INTO "alembic_version" VALUES('4831e933d59a');
CREATE TABLE user (
	id INTEGER NOT NULL, 
	username VARCHAR(64), 
	email VARCHAR(120), 
	password_hash VARCHAR(128), about_me VARCHAR(140), last_seen DATETIME, 
	PRIMARY KEY (id)
);
INSERT INTO "user" VALUES(1,'john','john@example.com',NULL,NULL,NULL);
INSERT INTO "user" VALUES(2,'susan','susan@example.com',NULL,NULL,NULL);
INSERT INTO "user" VALUES(3,'Test','123@Test.com','pbkdf2:sha256:150000$Nm66jAsz$f83a33e8313fd1e286a087239a76ed7bffd67708c4da4dcfc6b3b4b13713da21','Test Edit Profile','2022-02-28 15:28:51.216107');
INSERT INTO "user" VALUES(4,'Admin','Admin@email.com','pbkdf2:sha256:150000$Wxv15cDc$e6aef2febd52da48d4b6de44a3f425fdac92f4151e9c52a01b8285b565b8ffc4',NULL,'2020-05-03 12:40:08.716761');
CREATE TABLE post (
	id INTEGER NOT NULL, 
	body VARCHAR(140), 
	timestamp DATETIME, 
	user_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES user (id)
);
INSERT INTO "post" VALUES(1,'my first post!','2020-03-08 08:58:52.298315',1);
INSERT INTO "post" VALUES(2,'Testing123
','2020-03-26 06:29:31.886450',3);
INSERT INTO "post" VALUES(3,'Test321','2020-03-26 06:29:45.682782',3);
INSERT INTO "post" VALUES(4,'123','2020-03-26 06:30:04.958390',3);
INSERT INTO "post" VALUES(5,'Test','2020-04-08 11:48:21.384074',4);
INSERT INTO "post" VALUES(6,'Hi','2020-04-08 11:49:15.259103',3);
CREATE TABLE followers (
	follower_id INTEGER, 
	followed_id INTEGER, 
	FOREIGN KEY(followed_id) REFERENCES user (id), 
	FOREIGN KEY(follower_id) REFERENCES user (id)
);
INSERT INTO "followers" VALUES(4,3);
INSERT INTO "followers" VALUES(3,4);
CREATE TABLE location (
	"Street" VARCHAR(100) NOT NULL, 
	support BOOLEAN, 
	PRIMARY KEY ("Street"), 
	CHECK (support IN (0, 1))
);
INSERT INTO "location" VALUES('Lam Tin',1);
INSERT INTO "location" VALUES('Kwun Tong',NULL);
INSERT INTO "location" VALUES('Ngau Tau Kok',NULL);
INSERT INTO "location" VALUES('Kowloon Bay',NULL);
CREATE TABLE "plan" (
	id INTEGER NOT NULL, 
	"Pname" VARCHAR(20), 
	"Price" INTEGER, 
	"Speed" VARCHAR(5), 
	PRIMARY KEY (id)
);
INSERT INTO "plan" VALUES(1,'Normal Speed',50,'100Mbps');
INSERT INTO "plan" VALUES(2,'Faster',150,'1000Mbps');
INSERT INTO "plan" VALUES(3,'Ultimate Speed',250,'2000Mbps');
CREATE TABLE mob_plan (
	id INTEGER NOT NULL, 
	"Pname" VARCHAR(20), 
	"Price" INTEGER, 
	"Data" VARCHAR(10), 
	PRIMARY KEY (id)
);
INSERT INTO "mob_plan" VALUES(11,'3G',30,'10GB');
INSERT INTO "mob_plan" VALUES(12,'4G',90,'20GB');
INSERT INTO "mob_plan" VALUES(13,'4.5G',150,'20GB');
INSERT INTO "mob_plan" VALUES(14,'5G',300,'30GB');
CREATE TABLE "pay"
(
	id INTEGER not null
		primary key
		references user,
	planid VARCHAR,
	Paydate DATETIME
);
INSERT INTO "pay" VALUES(3,'3','2020-05-03 10:01:39.155541');
INSERT INTO "pay" VALUES(4,'5G','2020-05-03 04:17:02.498034');
CREATE TABLE e_service (
	"ServiceID" INTEGER NOT NULL, 
	"ServiceName" INTEGER, 
	PRIMARY KEY ("ServiceID")
);
INSERT INTO "e_service" VALUES(1,'光纖寬頻');
INSERT INTO "e_service" VALUES(2,'流動通訊及裝置');
INSERT INTO "e_service" VALUES(3,'娛樂');
INSERT INTO "e_service" VALUES(4,'家居電話及IDD');
INSERT INTO "e_service" VALUES(5,'其他服務、資訊及下載');
INSERT INTO "e_service" VALUES(6,'賬戶及月結單');
CREATE TABLE support_tel (
	"Telno" INTEGER NOT NULL, 
	"Service" VARCHAR(20), 
	PRIMARY KEY ("Telno")
);
INSERT INTO "support_tel" VALUES(11112222,'Tech-Support');
INSERT INTO "support_tel" VALUES(22223333,'aftersell');
INSERT INTO "support_tel" VALUES(33334444,'other-problem');
CREATE TABLE global_talk (
	"Function" VARCHAR(100) NOT NULL, 
	PRIMARY KEY ("Function")
);
INSERT INTO "global_talk" VALUES('Call Hong Kong number is free!');
INSERT INTO "global_talk" VALUES('High security');
INSERT INTO "global_talk" VALUES('Save the global call fee');
CREATE TABLE referral_rewards (
	id INTEGER NOT NULL, 
	"DesignatedService" VARCHAR(100), 
	"Referrers" INTEGER, 
	PRIMARY KEY (id)
);
INSERT INTO "referral_rewards" VALUES(1,'Broadband Services',500);
INSERT INTO "referral_rewards" VALUES(2,'Mobile Services
',200);
CREATE TABLE my_tv_super (
	"PlanID" INTEGER NOT NULL, 
	"PlanLevel" VARCHAR(20), 
	channel VARCHAR(100), 
	PRIMARY KEY ("PlanID")
);
INSERT INTO "my_tv_super" VALUES(1,'myTV Silver','Discovery、BBC、Ani-One');
INSERT INTO "my_tv_super" VALUES(2,'myTV Gold','beIN SPORTS, Discovery, Disney, Blue Ant');
CREATE TABLE "permission"
(
	userID INTEGER not null
		primary key
		references user,
	userName VARCHAR(50)
		constraint permission_user_username_fk
			references user (username),
	permissionLevel VARCHAR(50)
);
INSERT INTO "permission" VALUES(1,'john','Admin');
INSERT INTO "permission" VALUES(2,'susan','Admin');
INSERT INTO "permission" VALUES(3,'Test','Staff');
INSERT INTO "permission" VALUES(4,'Admin','Admin');
CREATE UNIQUE INDEX ix_user_email ON user (email);
CREATE UNIQUE INDEX ix_user_username ON user (username);
CREATE INDEX ix_post_timestamp ON post (timestamp);
COMMIT;

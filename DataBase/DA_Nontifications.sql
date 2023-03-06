INSERT INTO Types 
(Type,										Kind) VALUES
('NOTIFICATION_COMPETITION_GREATPERSON',	'KIND_NOTIFICATION'),
('NOTIFICATION_CHINA_DYNASTY',				'KIND_NOTIFICATION'),
('NOTIFICATION_TOURISM_BONUS',				'KIND_NOTIFICATION');


INSERT INTO Notifications
(NotificationType,							SeverityType,	ExpiresEndOfTurn,	AutoNotify,	AutoActivate,	ShowIconSinglePlayer,	GroupType) VALUES
('NOTIFICATION_COMPETITION_GREATPERSON',	'MID',			1,					0,			1,				1,						'USER'),
('NOTIFICATION_CHINA_DYNASTY',				'VERY_HIGH',	1,					0,			1,				1,						'USER'),
('NOTIFICATION_TOURISM_BONUS',				'MID',			1,					0,			1,				1,						'USER');



	

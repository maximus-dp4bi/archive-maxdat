-- ***** Preload D_TEAMS ***** --

delete from D_TEAMS;

insert into	D_TEAMS (	TEAM_ID,	TEAM_NAME,	TEAM_DESCRIPTION	)
     values			(   0,		    'Unknown',	'Unknown'		    );

commit;


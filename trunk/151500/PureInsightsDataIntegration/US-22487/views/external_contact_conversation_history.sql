Select

p.conversationId,
s.sessionStartTime,
s.sessionEndTime,
s.duration as sessionDuration,
s.direction,
s.mediatype,
s.ani,
s.dnis,
ec.firstName,
ec.lastname,
ec.title,
ec.externalorganizationname
from participants p
INNER JOIN raw_external_contacts ec on p.externalContactId = ec.id  
INNER JOIN raw_sessions s on p.participantid = s.participantid
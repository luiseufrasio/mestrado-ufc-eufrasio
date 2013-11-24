select pe.FirstName, pe.LastName, pe.Email, t.TopicName
from persons pe inner join rel_person_paper rpp on  pe.PerID = rpp.PersonID
inner join papers pa on rpp.PaperID = pa.PaperID inner join rel_paper_topic rpt on pa.PaperID = rpt.PaperID
inner join topics t on rpt.TopicID = t.TopicID
order by t.TopicName
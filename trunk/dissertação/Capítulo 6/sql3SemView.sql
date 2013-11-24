select pe.FirstName, pe.LastName, count(*) as qtdeTopics
from persons pe inner join rel_person_paper rpp on  pe.PerID = rpp.PersonID
inner join papers pa on rpp.PaperID = pa.PaperID inner join rel_paper_topic rpt on pa.PaperID = rpt.PaperID
inner join topics t on rpt.TopicID = t.TopicID
group by pe.FirstName, pe.LastName
order by pe.FirstName, pe.LastName
delete from cc_s_acd_new_queues
where ACD_NEW_QUEUES_ID in  
(select ACD_NEW_QUEUES_ID from cc_s_acd_new_queues s1,
    (select application_id,contact_type,max(acd_new_queues_id) m_acd_new_queues_id
      from cc_s_acd_new_queues
      group by application_id,contact_type) s2
where s1.application_id=s2.application_id
  and s1.contact_type=s2.contact_type
  and s1.acd_new_queues_id < s2.m_acd_new_queues_id);

commit;

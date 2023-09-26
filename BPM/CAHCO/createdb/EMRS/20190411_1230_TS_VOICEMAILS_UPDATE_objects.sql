CREATE OR REPLACE Procedure MAXDAT.ts_voicemails_update
(
in_vm_id IN NUMBER,
in_vm_same_day_received           IN NUMBER,
in_vm_same_day_returned_within_sla          IN NUMBER,
in_vm_next_day_received             IN NUMBER,
in_vm_next_day_returned_within_sla            IN NUMBER,
in_vm_non_bus_received              IN NUMBER,
in_vm_non_bus_returned_within_sla            IN NUMBER,
in_vm_delete_flag IN NUMBER,
in_staff_id IN VARCHAR2
)
AS
BEGIN
if in_vm_delete_flag = 1 then
     delete from hco_f_voicemails where vm_id = in_vm_id;
     commit;
elsif 
        in_vm_id is null or in_staff_id is null
        or (in_vm_same_day_received is null AND
            in_vm_same_day_returned_within_sla is null AND
            in_vm_next_day_received is null AND
            in_vm_next_day_returned_within_sla is null AND
            in_vm_non_bus_received is null AND
            in_vm_non_bus_returned_within_sla is null)
        THEN
        /*do nothing*/
        null;
    ELSE
        UPDATE hco_f_voicemails SET
            voicemails_same_day_received=CASE WHEN in_vm_same_day_received IS NULL THEN voicemails_same_day_received ELSE in_vm_same_day_received END,
            voicemails_same_day_returned_within_sla=CASE WHEN in_vm_same_day_returned_within_sla IS NULL THEN voicemails_same_day_returned_within_sla ELSE in_vm_same_day_returned_within_sla END,
            voicemails_next_day_received=CASE WHEN in_vm_next_day_received IS NULL THEN voicemails_next_day_received ELSE in_vm_next_day_received END,
            voicemails_next_day_returned_within_sla=CASE WHEN in_vm_next_day_returned_within_sla IS NULL THEN voicemails_next_day_returned_within_sla ELSE in_vm_next_day_returned_within_sla END,
            voicemails_non_bus_received=CASE WHEN in_vm_non_bus_received IS NULL THEN voicemails_non_bus_received ELSE in_vm_non_bus_received END,
            voicemails_non_bus_returned_within_sla=CASE WHEN in_vm_non_bus_returned_within_sla IS NULL THEN voicemails_non_bus_returned_within_sla ELSE in_vm_non_bus_returned_within_sla END,
            date_updated=SYSDATE,
            updated_by=IN_STAFF_ID
        WHERE vm_id=in_vm_id;
        COMMIT;
    END IF;
    NULL;
END;

/
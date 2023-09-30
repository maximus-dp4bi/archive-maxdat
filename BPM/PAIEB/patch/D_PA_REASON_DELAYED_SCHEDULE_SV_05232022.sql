/*grant select on ATS table */

grant select on ATS.ENUM_REASON_DELAYED_SCHEDULE to MAXDAT_SUPPORT;

/* View for ENUM_REASON_DELAYED_SCHEDULE */
CREATE OR REPLACE FORCE VIEW maxdat_support.d_pa_reason_delayed_schedule_sv  AS
    SELECT
        value reason_delayed_schedule_code,
        report_label reason_delayed_schedule
    FROM
        ats.enum_reason_delayed_schedule
    WHERE
        effective_end_date IS NULL;

grant select on MAXDAT_SUPPORT.D_PA_REASON_DELAYED_SCHEDULE_SV to MAXDAT_SUPPORT_READ_ONLY;
grant select on MAXDAT_SUPPORT.D_PA_REASON_DELAYED_SCHEDULE_SV to MAXDATSUPPORT_READ_ONLY;
grant select on MAXDAT_SUPPORT.D_PA_REASON_DELAYED_SCHEDULE_SV to MAXDAT_REPORTS;



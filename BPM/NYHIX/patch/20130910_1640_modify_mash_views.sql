-- Rename project-specific views for MicroStrategy MASH reporting.
--Modified views from NYHX to NYHIX 

Rename D_NYHX_BPM_SOURCE_LKUP_SV to D_NYHIX_BPM_SOURCE_LKUP_SV;
Rename D_NYHX_BPM_DATA_MODEL_SV to D_NYHIX_BPM_DATA_MODEL_SV;
Rename D_NYHX_BUEQ_SV to D_NYHIX_BUEQ_SV;
Rename D_NYHX_PBQJ_SV to D_NYHIX_PBQJ_SV;
Rename D_NYHX_PBQJB_SV to D_NYHIX_PBQJB_SV;

commit;
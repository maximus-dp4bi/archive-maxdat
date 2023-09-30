UPDATE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
SET BATCH_DELETED = 'Y',
	BATCH_COMPLETE_DT  NULL
WHERE BATCH_GUID IN
(
'{eb389a27-a7a0-4c03-9e50-d5e1cc52b58e}',
'{290f26c4-0db8-4b5a-9fed-bae3992d8f02}',
'{f883f7ed-d987-41ed-865d-209f20c2ae86}',
'{528aae11-4403-43b1-bf87-5436c4461758}',
'{95edaefd-9e6c-45dd-bc10-a546ff8411dc}',
'{cd3b97fa-4515-4cbf-8a3d-45bb421fa26b}',
'{bde6fd41-3347-4f65-a361-9a24338e09c8}',
'{bbbe9235-97c8-42f4-99d1-918e29d88da5}',
'{d5ece6bd-e8de-4ca3-9703-0d81c8e052d5}',
'{940eb4f8-d21c-4c66-8dec-c8bf0a8eed3d}',
'{dafbab3e-1e76-4b63-82f6-7dc706de4a52}',
'{ef085ff1-1e72-4e93-9991-7ea107a742c8}',
'{eaa6be42-7db2-4e1d-ae71-6784e8ada152}',
'{db090de8-d9e2-495b-bcd8-d106cc1e87e7}',
'{42a5a56c-2fee-43b1-9ca9-9a1dc3c16e29}',
'{e3829cbe-60c0-4d4f-842e-6fc7dd202294}',
'{e324e51c-eb20-451a-a628-8b33ea81f6e6}'
);

-- COMMIT IF 17 ROWS UPDATED.

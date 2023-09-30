alter session set current_schema = cisco_enterprise_cc;

delete from cc_c_filter
where value in (6248,
6249,
6250,
6251,
6252,
6253,
6254,
6255,
6257,
6258,
6259,
6260,
6274,
6276,
6277,
6278,
6279,
6280,
6284,
6285,
6286,
6287,
6288,
6289,
6290
);

commit;
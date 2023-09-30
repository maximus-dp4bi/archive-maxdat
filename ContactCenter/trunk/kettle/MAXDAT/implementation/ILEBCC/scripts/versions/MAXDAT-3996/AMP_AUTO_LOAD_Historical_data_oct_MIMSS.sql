---	historical load (monthly) for the MI MSS IVR data, Oct 1 (full month) to today
---exec  ampexp_hist.create_hist_ampexp_golive(to_date('10/3/2016','mm/dd/yyyy'), 'weekly', 'Y', 'MI MSS', null);

exec  ampexp_hist.create_hist_ampexp_golive(to_date('10/3/2016','mm/dd/yyyy'), 'monthly', 'Y', 'MI MSS', null);



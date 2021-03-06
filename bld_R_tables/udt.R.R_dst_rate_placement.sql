
if not exists(select * from information_schema.columns
				where table_name = 'rate_placement'
					and column_name = 'ds_trend')

alter table prtl.rate_placement
add ds_trend float;

update ca_ods.prtl.rate_placement set ds_trend = i.ds_trend
from (select
		rr.cohort_date
		,rr.county_cd
		,rr.entry_point 
		,drr.trend ds_trend
			from ca_ods.prtl.rate_placement rr
			left join R.R_dst_rate_placement drr
				on rr.cohort_date = convert(datetime, drr.cohort_date) 
					and rr.county_cd = drr.county_cd
					and rr.entry_point = drr.entry_point) i
where i.cohort_date = ca_ods.prtl.rate_placement.cohort_date 
					and i.county_cd = ca_ods.prtl.rate_placement.county_cd
					and i.entry_point = ca_ods.prtl.rate_placement.entry_point

if not exists(select * from information_schema.columns
				where table_name = 'rate_referrals'
					and column_name = 'ds_trend')

alter table prtl.rate_referrals
add ds_trend float

update ca_ods.prtl.rate_referrals set ds_trend = i.ds_trend
from (select
		rr.start_date
		,rr.county_cd
		,rr.entry_point 
		,drr.trend ds_trend
			from ca_ods.prtl.rate_referrals rr
			left join R.R_dst_rate_referrals drr
				on rr.start_date = convert(datetime, drr.start_date) 
					and rr.county_cd = drr.county_cd
					and rr.entry_point = drr.entry_point) i
where i.start_date = ca_ods.prtl.rate_referrals.start_date 
					and i.county_cd = ca_ods.prtl.rate_referrals.county_cd
					and i.entry_point = ca_ods.prtl.rate_referrals.entry_point
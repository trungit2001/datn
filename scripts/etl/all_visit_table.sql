drop table if exists cdm_schema.ip_visits;
drop table if exists cdm_schema.er_visits;
drop table if exists cdm_schema.op_visits;
drop table if exists cdm_schema.all_visits;


/* Inpatient visits */
/* Collapse IP claim lines with <=1 day between them into one visit */

with cte_end_dates as (
	select
		patient
		, encounterclass
		, event_date - interval '1 day' as end_date
	from (
		select
			patient 
			, encounterclass
			, event_date 
			, event_type 
			, max(start_ordinal) over(
				partition by patient, encounterclass
				order by event_date, event_type rows unbounded preceding 
			) as start_ordinal
			, row_number() over(
				partition by patient, encounterclass
				order by event_date, event_type
			) as overall_ord
		from (
			select
				patient 
				, encounterclass 
				, "start" 		as event_date
				, -1 			as event_type
				, row_number() over(
					partition by patient, encounterclass 
					order by "start", stop
				) as start_ordinal
			from synthea_schema.encounters
			where lower(encounterclass) = 'inpatient'
			union all
			select
				patient 
				, encounterclass 
				, stop + interval '1 day'
				, 1 			as event_type
				, null
			from synthea_schema.encounters
			where lower(encounterclass) = 'inpatient'
		) as rawdata
	) as e
	where (2 * e.start_ordinal - e.overall_ord = 0)
)
, cte_visit_ends as (
	select
		min(e.id)			as encounter_id
		, e.patient 
		, e.encounterclass 
		, e."start" 		as visit_start_date
		, min(ced.end_date) as visit_end_date
	from synthea_schema.encounters e
	join cte_end_dates ced
		on e.patient = ced.patient
		and lower(e.encounterclass) = lower(ced.encounterclass)
		and ced.end_date >= e."start" 
	group by e.patient, e.encounterclass, e."start"
)
select
	t2.encounter_id
	, t2.patient
	, t2.encounterclass
	, t2.visit_start_date
	, t2.visit_end_date
into cdm_schema.ip_visits
from (
	select 
		encounter_id
		, patient
		, encounterclass
		, min(visit_start_date) as visit_start_date
		, visit_end_date
	from cte_visit_ends
	group by encounter_id, patient, encounterclass, visit_end_date
) as t2;


/* Emergency visits */
/* Collapse ER claim lines with no days between them into one visit */

select
	t2.encounter_id
	, t2.patient
	, t2.encounterclass
	, t2.visit_start_date
	, t2.visit_end_date
into cdm_schema.er_visits
from (
	select
		min(encounter_id)		as encounter_id
		, patient
		, encounterclass
		, visit_start_date
		, max(visit_end_date)	as visit_end_date
	from (
		select
			e1.id					as encounter_id
			, e1.patient 
			, e1.encounterclass 
			, e1."start" 			as visit_start_date
			, e2.stop 				as visit_end_date
		from synthea_schema.encounters e1
		join synthea_schema.encounters e2
			on e1.patient = e2.patient 
			and e1."start" = e2."start" 
			and lower(e1.encounterclass) = lower(e2.encounterclass) 
		where lower(e1.encounterclass) in ('emergency', 'urgent')
	) as t1
	group by patient, encounterclass, visit_start_date
) as t2;


/* Outpatient visits */

with cte_visits_distinct as (
	select
		min(id)				as encounter_id
		, patient 
		, encounterclass 
		, "start" 			as visit_start_date
		, stop 				as visit_end_date
	from synthea_schema.encounters
	where lower(encounterclass) in ('ambulatory', 'wellness', 'outpatient')
	group by patient, encounterclass, "start", stop
)
select
	min(encounter_id)		as encounter_id
	, patient 
	, encounterclass 
	, visit_start_date
	, max(visit_end_date) 	as visit_end_date
into cdm_schema.op_visits
from cte_visits_distinct
group by patient, encounterclass, visit_start_date;


/* All visits */

select
	*
	, row_number() over(
		order by patient
	) as visit_occurrence_id
into cdm_schema.all_visits
from (
	select *
	from cdm_schema.ip_visits
	union all
	select *
	from cdm_schema.er_visits
	union all
	select *
	from cdm_schema.op_visits
) as t1;


/* Drop temp tables */

drop table if exists cdm_schema.ip_visits;
drop table if exists cdm_schema.er_visits;
drop table if exists cdm_schema.op_visits;

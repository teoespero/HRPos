/*
	
	HRPos
	The HRPos table stores information about each and every position in the organization. Before a person 
	can be assigned to a position, the position must be defined here and connected to the 
	HRPosAcct table (for the accounts that pay for the position). While this table is not fiscal year 
	oriented, the HRPosAcct table is.
*/

select 
	DistrictID,
	rtrim(DistrictAbbrev) as DistrictAbbrev,
	DistrictTitle
from tblDistrict

select 
	(select DistrictId from tblDistrict) as OrgId,
	pcd.SlotNum as PosID,
	null as PosTypeId,
	CONVERT(VARCHAR(10), pcd.EffectiveDate, 110) as DateFrom,
	CONVERT(VARCHAR(10), pcd.InactiveDate, 110) as DateThru,
	null as DateApproval,
	null as PreviousJob,
	pcd.Comments as Comment,
	cl.ClassDescription,
	sc.SubClassDesc,
	jt.JobTitleID,
	jt.JobTitle,
	st.StatusID,
	st.[Status]
from tblPositionControlDetails pcd
inner join
	tblJobTitles jt
	on pcd.pcJobTitleID = jt.JobTitleID
	and pcd.InactiveDate is null
inner join
	tblSubClassifications sc
	on jt.SubClassificationID = sc.SubClassificationID
inner join
	tblClassifications cl
	on cl.ClassificationID = sc.scClassificationID
left join
	tblStatus st
	on st.StatusID = pcd.StatusID
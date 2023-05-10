---first exploer the data
select*
from [Housing_Data]



--------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------


----the PropertyAddress----
select
PropertyAddress
from [Housing_Data]
where PropertyAddress is null 

select
*
from [Housing_Data]
--where PropertyAddress is null
order BY ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress) 
from [Housing_Data]a
join [Housing_Data]b
on a.ParcelID=b.ParcelID and a.UniqueID<>b.UniqueID
where a.PropertyAddress is null

update a 
set PropertyAddress =ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Housing_Data]a
join [Housing_Data]b
on a.ParcelID=b.ParcelID and a.UniqueID<>b.UniqueID
where a.PropertyAddress is null

select PropertyAddress  --- NO nulls  
from [Housing_Data]
where PropertyAddress is null
 ---------------------------------------- 
 --------------------------------------------------------------------------------------------------------------------------------------------------------
select ----------------------------------------------------------------------------------------

select format(Acreage,'0.00')
from [Housing_Data]

update [Housing_Data]
set Acreage =format(Acreage,'0.00')


--------------------------------------------------------------------------------------
---spilt the PropertyAdderss and Owneraddress 
-----frist Owneraddress

select 
    SUBSTRING(OwnerAddress, 1, CHARINDEX(',', OwnerAddress) - 1) , 
    SUBSTRING(OwnerAddress, CHARINDEX(',', OwnerAddress) + 1, LEN(OwnerAddress))
from[Housing_Data]



alter table [Housing_Data]
add Owner_stree_addres nvarchar (255); 

update [Housing_Data]
set Owner_stree_addres =SUBSTRING(OwnerAddress,1, CHARINDEX(',', OwnerAddress) -1)

alter table [Housing_Data]
add Owner_city nvarchar (255); 

update [Housing_Data]
set Owner_city = SUBSTRING(OwnerAddress, CHARINDEX(',', OwnerAddress) + 1, LEN(OwnerAddress))
--PropertyAddress-----------------------------------------------------------------


select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) , 
    SUBSTRING(OwnerAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

from [Housing_Data]

alter table [Housing_Data]
add p_stree_addres nvarchar (255); 

update [Housing_Data]
set p_stree_addres =SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress) -1)

alter table [Housing_Data]
add p_city  nvarchar (255); 

update [Housing_Data]
set p_city = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1, LEN(PropertyAddress))
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------

-----just check--------------------------------------------------------------------------------------------------------------------------------
select  UniqueID
from [Housing_Data]
where UniqueID is null 

--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
select distinct(SoldAsVacant), count(SoldAsVacant)
from [Housing_Data]
group by SoldAsVacant


select
SoldAsVacant,
case
    when SoldAsVacant = 'N'  then 'No'
	when SoldAsVacant = 'Y'  then 'Yes'
	else  SoldAsVacant 
	END
from [Housing_Data]


update [Housing_Data]
set SoldAsVacant = case
    when SoldAsVacant = 'N'  then 'No'
	when SoldAsVacant = 'Y'  then 'Yes'
	else  SoldAsVacant 
	END

-----------------------------------------------
----------------------------------------------------------
----------------------------------------------------------------------------------
---remove duplicate___
----with function

with removecte as (
select * , row_NUMBER () OVER( partition by
ParcelID ,Houses_Addresses,City,TaxDistrict,LegalReference ,SalePrice,SaleDate
order by UniqueID) _remove
from [Housing_Data]
)
select *
from removecte
where _remove >1
order by   SaleDate


-----------------------=================
with removecte as (
select * , row_NUMBER () OVER( partition by
ParcelID ,Houses_Addresses,City,TaxDistrict,LegalReference ,SalePrice,SaleDate
order by UniqueID) _remove
from [Housing_Data]
)
delete 
from removecte
where _remove >1
------------done------------------------
------------------------------------------------------------------------------------------------------






SELECT [UniqueID]
      ,[ParcelID]
      ,[City]
      ,[Houses_Addresses ]
      ,[LandUse]
      ,[Acreage]
      ,[YearBuilt]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[SalePrice]
      ,[SaleDate]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[LegalReference]
      ,[TaxDistrict]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [Housing_Data]
GO


create procedure sp_crudTrips

@operationId int = 1,
@tripMasterId bigint = null,
@vehicleId int = null,
@routeId int = null,
@startDate varchar(10) = '',
@endDate varchar(10) = '',
@driverId int = null, 
@tripDetailList tripDetailListType readonly

as

begin

	if(@operationId in (0,1))
	begin
		select 
			tm.tripMasterId,
			tm.vehicleId,
			sv.vehicleNumber, 
			tm.routeId,
			ri.routeName,
			tm.startDate,
			tm.endDate,
			tm.driverId,
			tm.totalTripExpense
		from 
			tripMaster tm
			inner join setupVehicles sv on sv.vehicleId = tm.vehicleId
			inner join routeInfo ri on ri.routeId = tm.routeId
			--inner join  on ri.routeId = tm.routeId
		where 
			(tm.tripMasterId = @tripMasterId or @tripMasterId is null) and
			(tm.vehicleId = @vehicleId or @vehicleId is null) and
			(tm.routeId = @routeId or @routeId is null) and
			(tm.driverId = @driverId and @driverId is null) and
			tm.isDeleted = 0
	end
	if(@operationId = 5)
	begin
		select 
			td.expenceId,
			ex.setupDetailName expenseName,
			td.tripDetailId,
			td.expenseAmount
		from 
			tripDetail td
			inner join setupDetail ex on ex.setupDetailId = td.expenseId
		where 
			td.tripMasterId = @tripMasterId
	end

	begin try
	begin transaction

		if(@operationId = 2)
		begin
			insert into tripMaster (
				)
			values (
				)
		end

		if(@operationId = 3)
		begin
		end

		if(@operationId = 4)
		begin
		end

	commit transaction
	end try

end
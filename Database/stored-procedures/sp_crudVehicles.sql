alter procedure sp_crudVehicles

@operationId int = 1,
@vehicleId int = null,
@vehicleNumber varchar(30) = null,
@registrationNumber varchar(50) = null,
@engineNumber varchar(50) = null,
@vehicleType bigint = null,
@vehicleMode bigint = null,
@color bigint = null,
@measurement varchar(30) = null,
@userId int = null

as

begin

	if(@operationId in (1,0))
	begin
		select
			sv.vehicleId,
			sv.vehicleNumber,
			sv.engineNumber,
			sv.registrationNumber,
			sv.measurement,
			sv.color,
			clr.setupDetailName colorName,
			sv.vehicleType,
			vty.setupDetailName vehicleTypeName,
			sv.vehicleMode,
			vmd.setupDetailName vehicleModeName
		from
			setupVehicles sv
			inner join setupDetail clr on clr.setupDetailId = sv.color
			inner join setupDetail vmd on vmd.setupDetailId = sv.vehicleMode
			inner join setupDetail vty on vty.setupDetailId = sv.vehicleType
		where 
			sv.isDeleted = 0 and
			(sv.vehicleNumber = @vehicleNumber or @vehicleNumber is null) and
			(sv.vehicleType = @vehicleType or @vehicleType is null) and
			(sv.vehicleMode = @vehicleMode or @vehicleMode is null)
		order by sv.createdOn desc

		if(@operationId = 1)
		begin
			select setupDetailId, setupDetailName, setupMasterId from setupDetail where setupMasterId = (select setupMasterId from setupMaster where flexString1 = 'COLOR' and isDeleted = 1)
			select setupDetailId, setupDetailName, setupMasterId from setupDetail where setupMasterId = (select setupMasterId from setupMaster where flexString1 = 'VEHICLE_TYPE' and isDeleted = 1)
			select setupDetailId, setupDetailName, setupMasterId from setupDetail where setupMasterId = (select setupMasterId from setupMaster where flexString1 = 'VEHICLE_MODE' and isDeleted = 1)
		end
	end

	begin try
	begin transaction
	
		if(@operationId = 2)
		begin
			insert into setupVehicles (
				vehicleNumber,
				registrationNumber,
				engineNumber,
				color,
				measurement,
				vehicleMode,
				vehicleType,
				isDeleted,
				createdBy,
				createdOn )
			values (
				@vehicleNumber,
				@registrationNumber,
				@engineNumber,
				@color,
				@measurement,
				@vehicleMode,
				@vehicleType,
				0,
				@userId,
				GETDATE() )

			exec sp_crudVehicles 1
		end

		if(@operationId = 3)
		begin
			update setupVehicles set 
				engineNumber = @engineNumber,
				color = @color,
				measurement = @measurement,
				vehicleMode = @vehicleMode,
				vehicleType = @vehicleType,
				updatedBy = @userId,
				updatedOn = GETDATE()
			where
				vehicleId = @vehicleId
			
			exec sp_crudVehicles 1
		end

		if(@operationId = 4)
		begin
			update setupVehicles set
				isDeleted = 1
			where vehicleId = @vehicleId
			
			exec sp_crudVehicles 1
		end

	commit transaction
	end try
	begin catch
		rollback transaction
	end catch

end
alter procedure sp_crudSetupMasterDetail

@operationId int = 1,
@setupMasterId int = null,
@setupDetailId bigint = null,
@setupDetailName varchar(max) = '',
@flexString1 varchar(max) = '',
@flexString2 varchar(max) = '',
@flexInt1 int = null,
@flexInt2 int = null,
@userId int = null

as

begin 

	if(@operationId in (1,0))
	begin
		select 
			sd.setupDetailId, 
			sd.setupDetailName, 
			sd.flexString1, 
			sd.flexString2, 
			sd.flexInt1, 
			sd.flexInt2,
			sm.setupMasterId,
			sm.setupMasterName
		from 
			setupDetail sd
			inner join setupMaster sm on sm.setupMasterId = sd.setupDetailId
		where
			(sd.setupDetailId = @setupDetailId or @setupDetailId is null) and
			(sm.setupMasterId = @setupMasterId or @setupMasterId is null) and
			(sm.flexInt1 = @flexInt1 or @flexInt1 is null) and
			(sm.flexInt2 = @flexInt2 or @flexInt2 is null) and
			(sm.flexString1 = @flexString1 or @flexString1 is null) and
			(sm.flexString2 = @flexString2 or @flexString2 is null) and 
			sd.isDeleted = 0

		if(@operationId = 1)
		begin
			select setupMasterId, setupMasterName, flexInt1, flexString1 from setupMaster where isDeleted = 0
		end
	end

	begin try
	begin transaction
	
	if(@operationId = 2)
	begin 
		insert into setupDetail (
			setupDetailName,
			setupMasterId,
			flexString1,
			flexString2,
			flexInt1,
			flexInt2,
			createdBy,
			createdOn,
			isDeleted)
		values (
			@setupDetailName,
			@setupMasterId,
			@flexString1,
			@flexString2,
			@flexInt1,
			@flexInt2,
			@userId,
			GETDATE(),
			0)
	end
	
	if(@operationId = 3)
	begin 
		update setupDetail set 
			setupDetailName = @setupDetailName,
			flexString1 = @flexString1,
			flexString2 = @flexString2,
			flexInt1 = @flexInt1,
			flexInt2 = @flexInt2,
			updatedBy = @userId,
			updatedOn = GETDATE()
		where
			setupDetailId = @setupDetailId
	end

	if(@operationId = 4)
	begin
		update setupDetail set
			isDeleted = 1,
			updatedBy = @userId,
			updatedOn = GETDATE()
		where setupDetailId = @setupDetailId
	end

	commit transaction
	end try
	begin catch
		rollback transaction
	end catch

end 
go 
 
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
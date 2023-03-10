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
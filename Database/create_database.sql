--create database logisticsErp
--go

-- use logisticsErp

create table employees (
	employeeId int primary key identity(1,1) not null,
	firstName varchar(100) not null,
	lastName varchar(100) not null,
	email varchar(100) null,
	mobile varchar(20) null,
	phone varchar(20) null,
	cnic varchar(20) null,
	address varchar(max) null,

)
go

create table users (
	userId int primary key identity(1,1) not null,
	username varchar(50) null,
	password varchar(50) not null
	--employeeId int foreign key references employeeId(employees) null,
)
go

create table loginHistory (
	userId int foreign key references users(userId),
	loginDateTime datetime not null,
	loginIp varchar(20) not null
)
go

create table menus (
	menuId int primary key identity(1,1) not null,
	menuName varchar(200) not null,
	menuRoute varchar(max) null,
	isParent bit not null,
	parentId int foreign key references menus(menuId) null,
	menuIcon varchar(max) null,
	menuSortOrder int null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table roles (
	roleId int primary key identity(1,1) not null,
	roleName varchar(100) not null,
	userId int foreign key references users(userId) not null,
	isActive bit not null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table accessRightViewer (
	arvId int primary key identity(1,1) not null,
	roleId int foreign key references roles(roleId) not null,
	menuId int foreign key references menus(menuId) not null,
	canView bit not null,
	canCreate bit not null,
	canUpdate bit not null,
	canDelete bit not null,
	canDownload bit not null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table setupMaster (
	setupMasterId int primary key identity(1,1) not null,
	setupMasterName varchar(max) not null,
	flexString1 varchar(max) null,
	flexString2 varchar(max) null,
	flexInt1 int null,
	flexInt2 int null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table setupDetail (
	setupDetailId bigint primary key identity(1,1) not null,
	setupDetailName varchar(max) not null,
	setupMasterId int foreign key references setupMaster(setupMasterId) not null,
	flexString1 varchar(max) null,
	flexString2 varchar(max) null,
	flexInt1 int null,
	flexInt2 int null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table setupVehicles (
	vehicleId int primary key identity(1,1) not null,
	vehicleNumber varchar(30) not null,
	registrationNumber varchar(50) null,
	engineNumber varchar(50) null,
	color bigint foreign key references setupDetail(setupDetailId) null,
	measurement varchar(20) null,
	vehicleType bigint foreign key references setupDetail(setupDetailId) null,
	vehicleMode bigint foreign key references setupDetail(setupDetailId) null,
	totalPrice float null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table vehiclePriceChart (
	vpcId int primary key identity(1,1) not null,
	vehicleId int foreign key references setupVehicles(vehicleId) null,
	priceName varchar(200) not null,
	amount float not null,
	isPercent bit not null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table vehicleAttachment (
	vattId int primary key identity(1,1) not null,
	vehicleId int foreign key references setupVehicles(vehicleId) not null,
	attachementPath varchar(max) not null,
	mimeType varchar(50) not null,
	originalName varchar(max) null
)
go

create table routeInfo (
	routeId int primary key identity(1,1) not null,
	routeName varchar(max) not null,
	fromLocation varchar(max) null,
	toLocation varchar(max) null,
	totalDistance float null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table customers (
	customerId int primary key identity(1,1) not null,
	customerName varchar(100) not null,
	ntn varchar(20) null,
	pocName varchar(100) null,
	pocContact varchar(50) null,
	pocEmail varchar(100) null,
	address varchar(max),
	city bigint foreign key references setupDetail(setupDetailId) null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table customerRoleMapping (
	crmId bigint primary key identity(1,1) not null,
	customerId int foreign key references customers(customerId) not null,
	roleId int foreign key references roles(roleId) not null,
	isDeleted bit not null
)
go

create table tripMaster (
	tripMasterId bigint primary key identity(1,1) not null,
	vehicleId int foreign key references setupVehicles(vehicleId) not null,
	customerId int foreign key references customers(customerId) not null,
	startDate date not null,
	endDate date not null,
	routeId int foreign key references routeInfo(routeId) not null,
	driverId int foreign key references routeInfo(routeId) not null,
	dayCount int not null,
	totalTripExpense float null,
	createdBy int foreign key references users(userId) not null,
	createdOn datetime not null,
	updatedBy int foreign key references users(userId) null,
	updatedOn datetime null,
	isDeleted bit not null
)
go

create table tripDetail (
	tripDetailId bigint primary key identity(1,1) not null,
	tripMasterId bigint foreign key references tripMaster(tripMasterId) not null,
	expenseId bigint foreign key references setupDetail(setupDetailId) not null,
	expenseAmount float not null,
)
go

create table tripAttachments (
	tripAttachmentId bigint primary key identity(1,1) not null,
	tripMasterId bigint foreign key references tripMaster(tripMasterId) not null,
	originalName varchar(max) not null,
	filePath varchar(max) not null
)
go


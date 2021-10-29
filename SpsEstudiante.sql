use DBAtencionCliente
go

if OBJECT_ID('spListarEstudiante') is not null
	drop proc spListarEstudiante
go

create proc spListarEstudiante as begin
	select CodigoUAC, Nombre, Apellidos, Grado, Celular from Estudiante
end


if OBJECT_ID('spAgregarEstudiante') is not null
	drop proc spAgregarEstudiante
go

create proc spAgregarEstudiante @CodigoUAC varchar(10),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Grado varchar(20),
								@Celular varchar(10) as begin
	
	if not exists (select CodigoUAC from Estudiante where CodigoUAC = @CodigoUAC) begin
		insert into Estudiante (CodigoUAC, Nombre, Apellidos, Grado, Celular) values (@CodigoUAC, @Nombre, @Apellidos, @Grado, @Celular) 
		select CodError = 0, Mensaje = 'Estudiante insertado correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al insertar al estudiante'
end

spAgregarEstudiante '018100264A', 'Erian', 'Bejar Vera', 'Pre grado', '984000765'
spAgregarEstudiante '018101082D', 'Gianfranco Victor', 'Neyra Ccoralla', 'Pre grado', '927764508'
spAgregarEstudiante '018101424B', 'Shannon Elison', 'Sanchez Jimenez', 'Pre grado', '927061725'
spAgregarEstudiante '018100768J', 'Daniel Emilio', 'Holguin Figueira', 'Pre grado', '994224969'

if OBJECT_ID('spActualizarEstudiante') is not null
	drop proc spActualizarEstudiante
go

create proc spActualizarEstudiante @CodigoUAC varchar(10),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Grado varchar(20),
								@Celular varchar(10) as begin
	
	if exists (select CodigoUAC from Estudiante where CodigoUAC = @CodigoUAC) begin
		update Estudiante set Nombre = @Nombre, Apellidos = @Apellidos, Grado = @Grado, Celular = @Celular where CodigoUAC = @CodigoUAC
		select CodError = 0, Mensaje = 'Estudiante actualizado correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al actualizar al estudiante'
end

if OBJECT_ID('spEliminarEstudiante') is not null
	drop proc spEliminarEstudiante
go

create proc spEliminarEstudiante @CodigoUAC varchar(10) as begin
	if exists (select CodigoUAC from Estudiante where CodigoUAC = @CodigoUAC) begin
		delete from Estudiante where CodigoUAC = @CodigoUAC
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente al estudiante'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al eliminar al estudiante'
end 


if OBJECT_ID('spBuscarEstudiante') is not null
	drop proc spBuscarEstudiante
go

create proc spBuscarEstudiante @Busqueda varchar(50), @Criterio varchar(20) as begin 
	if (@Criterio = 'Codigo') -- busqueda exacta
		select CodigoUAC, Nombre, Apellidos, Grado, Celular from Estudiante where CodigoUAC = @Busqueda
	else if (@Criterio = 'Nombre') -- Busqueda sensitiva
		select CodigoUAC, Nombre, Apellidos, Grado, Celular from Estudiante where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Apellidos') 
		select CodigoUAC, Nombre, Apellidos, Grado, Celular from Estudiante where Apellidos like '%' + @Busqueda + '%'
	else if (@Criterio = 'Grado')
		select CodigoUAC, Nombre, Apellidos, Grado, Celular from Estudiante where Grado like '%' + @Busqueda + '%'
	else if (@Criterio = 'Celular')
		select CodigoUAC, Nombre, Apellidos, Grado, Celular from Estudiante where Celular like '%' + @Busqueda + '%'
end




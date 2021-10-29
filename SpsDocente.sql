use DBAtencionCliente
go

if OBJECT_ID('spListarDocente') is not null
	drop proc spListarDocente
go

create proc spListarDocente as begin
	select CodigoUAC, Nombre, Apellidos,Celular from Docente
end



if OBJECT_ID('spAgregarDocente') is not null
	drop proc spAgregarDocente
go

create proc spAgregarDocente @CodigoUAC varchar(10),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Celular varchar(10) as begin
	
	if not exists (select CodigoUAC from Docente where CodigoUAC = @CodigoUAC) begin
		insert into Docente (CodigoUAC, Nombre, Apellidos,Celular) values (@CodigoUAC, @Nombre, @Apellidos, @Celular) 
		select CodError = 0, Mensaje = 'Docente insertado correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al insertar al Docente'
end




if OBJECT_ID('spActualizarDocente') is not null
	drop proc spActualizarDocente
go

create proc spActualizarDocente @CodigoUAC varchar(10),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Celular varchar(10) as begin
	
	if exists (select CodigoUAC from Docente where CodigoUAC = @CodigoUAC) begin
		update Docente set Nombre = @Nombre, Apellidos = @Apellidos, Celular = @Celular where CodigoUAC = @CodigoUAC
		select CodError = 0, Mensaje = 'Docente actualizado correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al actualizar al Docente'
end

if OBJECT_ID('spEliminarDocente') is not null
	drop proc spEliminarDocente
go

create proc spEliminarDocente @CodigoUAC varchar(10) as begin
	if exists (select CodigoUAC from Docente where CodigoUAC = @CodigoUAC) begin
		delete from Docente where CodigoUAC = @CodigoUAC
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente al Docente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al eliminar al Docente'
end 


if OBJECT_ID('spBuscarDocente') is not null
	drop proc spBuscarDocente
go

create proc spBuscarDocente @Busqueda varchar(50), @Criterio varchar(20) as begin 
	if (@Criterio = 'Codigo') -- busqueda exacta
		select CodigoUAC, Nombre, Apellidos,Celular from Docente where CodigoUAC = @Busqueda
	else if (@Criterio = 'Nombre') -- Busqueda sensitiva
		select CodigoUAC, Nombre, Apellidos,  Celular from Docente where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Apellidos') 
		select CodigoUAC, Nombre, Apellidos, Celular from Docente where Apellidos like '%' + @Busqueda + '%'
	else if (@Criterio = 'Celular')
		select CodigoUAC, Nombre, Apellidos, Celular from Docente where Celular like '%' + @Busqueda + '%'
end



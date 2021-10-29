use DBAtencionCliente
go

if OBJECT_ID('spListarAdministrador') is not null
	drop proc spListarAdministrador
go

create proc spListarAdministrador as begin
	select DNI, Nombre, Apellidos,Celular from Administrador
end



if OBJECT_ID('spAgregarAdministrador') is not null
	drop proc spAgregarAdministrador
go

create proc spAgregarAdministrador @DNI varchar(8),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Celular varchar(10) as begin
	
	if not exists (select DNI from Administrador where DNI = @DNI) begin
		insert into Administrador (DNI, Nombre, Apellidos,Celular) values (@DNI, @Nombre, @Apellidos, @Celular) 
		select CodError = 0, Mensaje = 'Administrador insertado correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al insertar al Administrador'
end




if OBJECT_ID('spActualizarAdministrador') is not null
	drop proc spActualizarAdministrador
go

create proc spActualizarAdministrador @DNI varchar(8),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Celular varchar(10) as begin
	
	if exists (select DNI from Administrador where DNI = @DNI) begin
		update Administrador set Nombre = @Nombre, Apellidos = @Apellidos, Celular = @Celular where DNI = @DNI
		select CodError = 0, Mensaje = 'Administrador actualizado correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al actualizar al Administrador'
end

if OBJECT_ID('spEliminarAdministrador') is not null
	drop proc spEliminarAdministrador
go

create proc spEliminarAdministrador @DNI varchar(8) as begin
	if exists (select DNI from Administrador where DNI = @DNI) begin
		delete from Administrador where DNI = @DNI
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente al Administrador'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al eliminar al Administrador'
end 


if OBJECT_ID('spBuscarAdministrador') is not null
	drop proc spBuscarAdministrador
go

create proc spBuscarAdministrador @Busqueda varchar(50), @Criterio varchar(20) as begin 
	if (@Criterio = 'Codigo') -- busqueda exacta
		select DNI, Nombre, Apellidos,Celular from Administrador where DNI = @Busqueda
	else if (@Criterio = 'Nombre') -- Busqueda sensitiva
		select DNI, Nombre, Apellidos,  Celular from Administrador where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Apellidos') 
		select DNI, Nombre, Apellidos, Celular from Administrador where Apellidos like '%' + @Busqueda + '%'
	else if (@Criterio = 'Celular')
		select DNI, Nombre, Apellidos, Celular from Administrador where Celular like '%' + @Busqueda + '%'
end



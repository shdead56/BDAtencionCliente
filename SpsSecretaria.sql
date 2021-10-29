use DBAtencionCliente
go

if OBJECT_ID('spListarSecretaria') is not null
	drop proc spListarSecretaria
go

create proc spListarSecretaria as begin
	select DNI, Nombre, Apellidos,Celular from Secretaria
end



if OBJECT_ID('spAgregarSecretaria') is not null
	drop proc spAgregarSecretaria
go

create proc spAgregarSecretaria @DNI varchar(8),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Celular varchar(10) as begin
	
	if not exists (select DNI from Secretaria where DNI = @DNI) begin
		insert into Secretaria (DNI, Nombre, Apellidos,Celular) values (@DNI, @Nombre, @Apellidos, @Celular) 
		select CodError = 0, Mensaje = 'Secretaria insertada correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al insertar a Secretaria'
end




if OBJECT_ID('spActualizarSecretaria') is not null
	drop proc spActualizarSecretaria
go

create proc spActualizarSecretaria @DNI varchar(8),
								@Nombre varchar(50),
								@Apellidos varchar(50),
								@Celular varchar(10) as begin
	
	if exists (select DNI from Secretaria where DNI = @DNI) begin
		update Secretaria set Nombre = @Nombre, Apellidos = @Apellidos, Celular = @Celular where DNI = @DNI
		select CodError = 0, Mensaje = 'Secretaria actualizada correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al actualizar a Secretaria'
end

if OBJECT_ID('spEliminarSecretaria') is not null
	drop proc spEliminarSecretaria
go

create proc spEliminarSecretaria @DNI varchar(8) as begin
	if exists (select DNI from Secretaria where DNI = @DNI) begin
		delete from Secretaria where DNI = @DNI
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente a la Secretaria'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al eliminar a Secretaria'
end 


if OBJECT_ID('spBuscarSecretaria') is not null
	drop proc spBuscarSecretaria
go

create proc spBuscarSecretaria @Busqueda varchar(50), @Criterio varchar(20) as begin 
	if (@Criterio = 'Codigo') -- busqueda exacta
		select DNI, Nombre, Apellidos,Celular from Secretaria where DNI = @Busqueda
	else if (@Criterio = 'Nombre') -- Busqueda sensitiva
		select DNI, Nombre, Apellidos,  Celular from Secretaria where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Apellidos') 
		select DNI, Nombre, Apellidos, Celular from Secretaria where Apellidos like '%' + @Busqueda + '%'
	else if (@Criterio = 'Celular')
		select DNI, Nombre, Apellidos, Celular from Secretaria where Celular like '%' + @Busqueda + '%'
end



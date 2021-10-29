use DBAtencionCliente
go

if OBJECT_ID('spAgregarMensaje') is not null
	drop proc spAgregarMensaje
go

create proc spAgregarMensaje @Id varchar(5),
							 @Cuerpo text,
							 @Archivo varbinary(max),
							 @Fecha datetime,
							 @Solicitud varchar(5),
							 @Estudiante varchar(10),
							 @Docente varchar(10),
							 @Administrador varchar(8),
							 @Secretaria varchar(8) as begin

	if not exists (select Id from Mensaje where Id = @Id) begin
		if exists (select Id from Solicitud where Id = @Solicitud) begin
			insert into Mensaje (Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria) values (@Id, @Cuerpo, @Archivo, @Fecha, @Solicitud, @Estudiante, @Docente, @Administrador, @Secretaria)
			select CodError = 0, Mensaje = 'Mensaje insertado correctamente'
		end 
		else 
			select CodError = 1, Mensaje = 'Error al insertar mensaje. Solicitud faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al insertar mensaje'
end 

if OBJECT_ID('spActualizarMensaje') is not null
	drop proc spActualizarMensaje
go

create proc spActualizarMensaje @Id varchar(5),
							 @Cuerpo text,
							 @Archivo varbinary(max),
							 @Fecha datetime,
							 @Solicitud varchar(5),
							 @Estudiante varchar(10),
							 @Docente varchar(10),
							 @Administrador varchar(8),
							 @Secretaria varchar(8) as begin

	if exists (select Id from Mensaje where Id = @Id) begin
		if exists (select Id from Solicitud where Id = @Solicitud) begin
			update Mensaje set Cuerpo = @Cuerpo, Archivo = @Archivo, Fecha = @Fecha, Solicitud = @Solicitud, Estudiante = @Estudiante, Docente = @Docente, Administrador = @Administrador, Secretaria = @Secretaria where Id = @Id
			select CodError = 0, Mensaje = 'Mensaje actualizado correctamente'
		end 
		else 
			select CodError = 1, Mensaje = 'Error al actualizar mensaje. Solicitud faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al actualizar mensaje'
end 

if OBJECT_ID('spEliminarMensaje') is not null
	drop proc spEliminarMensaje
go

create proc spEliminarMensaje @Id varchar(5) as begin
	if exists (select Id from Mensaje where Id = @Id) begin
		delete from Mensaje where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente el mensaje'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar el mensaje'
end

if OBJECT_ID('spListarMensaje') is not null
	drop proc spListarMensaje
go

create proc spListarMensaje as begin
	select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje
end


if OBJECT_ID('spBuscarMensaje') is not null
	drop proc spBuscarMensaje
go


create proc spBuscarMensaje @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Id = @Busqueda
	else if (@Criterio = 'Administrador')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Administrador = @Busqueda
	else if (@Criterio = 'Fecha')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Fecha = @Busqueda
	else if (@Criterio = 'Cuerpo')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Cuerpo like '%' + @Busqueda + '%'
	else if (@Criterio = 'Solicitud')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Solicitud = @Busqueda
	else if (@Criterio = 'Secretaria')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Secretaria = @Busqueda
	else if (@Criterio = 'Docente')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Docente = @Busqueda
	else if (@Criterio = 'Estudiante')
		select Id, Cuerpo, Archivo, Fecha, Solicitud, Estudiante, Docente, Administrador, Secretaria from Mensaje where Estudiante = @Busqueda
end


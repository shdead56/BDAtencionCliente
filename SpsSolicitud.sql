use DBAtencionCliente
go

if OBJECT_ID('spAgregarSolicitud') is not null
	drop proc spAgregarSolicitud
go

create proc spAgregarSolicitud @Id varchar(5),
							   @Encabezado varchar(50),
							   @Descripcion text,
							   @Archivo varbinary(max),
							   @Fecha datetime,
							   @Categoria varchar(10),
							   @Estudiante varchar(10) as begin

	if not exists (select Id from Solicitud where Id = @Id) begin
		if exists (select Id from Categoria where Id = @Categoria) begin
			if exists (select CodigoUAC from Estudiante where CodigoUAC = @Estudiante) begin
				insert into Solicitud (Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante) values (@Id, @Encabezado, @Descripcion, @Archivo, @Fecha, @Categoria, @Estudiante) 
				select CodError = 0, Mensaje = 'Solicitud insertada correctamente'
			end
			else 
				select CodError = 1, Mensaje = 'Error al insertar solicitud. Estudiante faltante'
		end
		else 
			select CodError = 1, Mensaje = 'Error al insertar solicitud. Categoria faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al insertar solicitud'
end

if OBJECT_ID('spActualizarSolicitud') is not null
	drop proc spActualizarSolicitud
go

create proc spActualizarSolicitud @Id varchar(5),
							   @Encabezado varchar(50),
							   @Descripcion text,
							   @Archivo varbinary(max),
							   @Fecha datetime,
							   @Categoria varchar(10),
							   @Estudiante varchar(10) as begin

	if exists (select Id from Solicitud where Id = @Id) begin
		if exists (select Id from Categoria where Id = @Categoria) begin
			if exists (select CodigoUAC from Estudiante where CodigoUAC = @Estudiante) begin
				update Solicitud set Encabezado = @Encabezado, Descripcion = @Descripcion, Archivo = @Archivo, Fecha = @Fecha, Categoria = @Categoria, Estudiante = @Estudiante where Id = @Id
				select CodError = 0, Mensaje = 'Solicitud actualizada correctamente'
			end
			else 
				select CodError = 1, Mensaje = 'Error al actualizar solicitud. Estudiante faltante'
		end
		else 
			select CodError = 1, Mensaje = 'Error al actualizar solicitud. Categoria faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al actualizar solicitud'
end


if OBJECT_ID('spEliminarSolicitud') is not null
	drop proc spEliminarSolicitud
go

create proc spEliminarSolicitud @Id varchar(5) as begin
	if exists (select Id from Solicitud where Id = @Id) begin
		delete from Solicitud where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente la solicitud'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar la solicitud'
end

if OBJECT_ID('spListarSolicitud') is not null
	drop proc spListarSolicitud
go

create proc spListarSolicitud as begin
	select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud
end

if OBJECT_ID('spBuscarSolicitud') is not null
	drop proc spBuscarSolicitud
go

create proc spBuscarSolicitud @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id')
		select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud where Id = @Busqueda
	else if (@Criterio = 'Encabezado')
		select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud where Encabezado like '%' + @Busqueda + '%'
	else if (@Criterio = 'Descripcion')
		select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud where Descripcion like '%' + @Busqueda + '%'
	else if (@Criterio = 'Fecha')
		select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud where Fecha = @Busqueda
	else if (@Criterio = 'Categoria')
		select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud where Categoria = @Busqueda
	else if (@Criterio = 'Estudiante')
		select Id, Encabezado, Descripcion, Archivo, Fecha, Categoria, Estudiante from Solicitud where Estudiante = @Busqueda
end
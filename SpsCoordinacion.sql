use DBAtencionCliente
go

if OBJECT_ID('spAgregarCoordinacion') is not null
	drop proc spAgregarCoordinacion
go

create proc spAgregarCoordinacion @Id varchar(10),
								  @Nombre varchar(40),
								  @Docente varchar(10) as begin

	if not exists (select Id from Coordinacion where Id = @Id) begin
		if exists (select CodigoUAC from Docente where CodigoUAC = @Docente) begin
			insert into Coordinacion (Id, Nombre, Docente) values (@Id, @Nombre, @Docente)
			select CodError = 0, Mensaje = 'Coordinacion insertada correctamente'
		end
		else 
			select CodError = 1, Mensaje = 'Error al insertar coordinacion. Docente faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al insertar coordinacion'
end

if OBJECT_ID('spActualizarCoordinacion') is not null
	drop proc spActualizarCoordinacion
go

create proc spActualizarCoordinacion @Id varchar(10),
									  @Nombre varchar(40),
									  @Docente varchar(10) as begin

	if exists (select Id from Coordinacion where Id = @Id) begin
		if exists (select CodigoUAC from Docente where CodigoUAC = @Docente) begin
			update Coordinacion set Nombre = @Nombre, Docente = @Docente where Id = @Id
			select CodError = 0, Mensaje = 'Coordinacion actualizada correctamente'
		end
		else 
			select CodError = 1, Mensaje = 'Error al actualizar coordinacion. Docente faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al actualizar coordinacion'
end

if OBJECT_ID('spListarCoordinacion') is not null
	drop proc spListarCoordinacion
go

create proc spListarCoordinacion as begin
	select Id, Nombre, Docente from Coordinacion
end

if OBJECT_ID('spEliminarCoordinacion') is not null
	drop proc spEliminarCoordinacion
go

create proc spEliminarCoordinacion @Id varchar(10) as begin
	if exists (select Id from Coordinacion where Id = @Id) begin
		delete from Coordinacion where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente la coordinacion'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar la coordinacion'
end


if OBJECT_ID('spBuscarCoordinacion') is not null
	drop proc spBuscarCoordinacion
go

create proc spBuscarCoordinacion @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id')
		select Id, Nombre, Docente from Coordinacion where Id = @Busqueda
	else if (@Criterio = 'Nombre')
		select Id, Nombre, Docente from Coordinacion where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Docente')
		select Id, Nombre, Docente from Coordinacion where Docente = @Busqueda

end


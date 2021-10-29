use DBAtencionCliente
go

if OBJECT_ID('spAgregarCategoria') is not null
	drop proc spAgregarCategoria
go

create proc spAgregarCategoria @Id varchar(10),
							   @Nombre varchar(40),
							   @Descripcion varchar(200),
							   @Coordinacion varchar(10),
							   @Prioridad varchar(5) as begin

	if not exists (select Id from Categoria where Id = @Id) begin
		if exists (select Id from Coordinacion where Id = @Coordinacion) begin
			if exists (select Id from Prioridad where Id = @Prioridad) begin
				insert into Categoria (Id, Nombre, Descripcion, Coordinacion, Prioridad) values (@Id, @Nombre, @Descripcion, @Coordinacion, @Prioridad)
				select CodError = 0, Mensaje = 'Categoria insertada correctamente'
			end 
			else 
				select CodError = 1, Mensaje = 'Error al insertar categoria. Prioridad faltante'
		end
		else 
			select CodError = 1, Mensaje = 'Error al insertar categoria. Coordinacion faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al insertar la categoria'
end


if OBJECT_ID('spListarCategoria') is not null
	drop proc spListarCategoria
go

create proc spListarCategoria as begin
	select Id, Nombre, Coordinacion, Prioridad from Categoria
end


if OBJECT_ID('spActualizarCategoria') is not null
	drop proc spActualizarCategoria
go

create proc spActualizarCategoria @Id varchar(10),
								   @Nombre varchar(40),
								   @Descripcion varchar(200),
								   @Coordinacion varchar(10),
								   @Prioridad varchar(5) as begin
	
	if exists (select Id from Categoria where Id = @Id) begin
		if exists (select Id from Coordinacion where Id = @Coordinacion) begin
			if exists (select Id from Prioridad where Id = @Prioridad) begin
				update Categoria set Nombre = @Nombre, Descripcion = @Descripcion, Coordinacion = @Coordinacion, Prioridad = @Prioridad where Id = @Id
				select CodError = 0, Mensaje = 'Categoria actualizada correctamente'
			end 
			else 
				select CodError = 1, Mensaje = 'Error al actualizar categoria. Prioridad faltante'
		end
		else 
			select CodError = 1, Mensaje = 'Error al actualizar categoria. Coordinacion faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al actualizar la categoria'
end


if OBJECT_ID('spEliminarCategoria') is not null
	drop proc spEliminarCategoria
go

create proc spEliminarCategoria @Id varchar(10) as begin
	if exists (select Id from Categoria where Id = @Id) begin
		delete from Categoria where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente la categoria'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar la categoria'
end


if OBJECT_ID('spBuscarCategoria') is not null
	drop proc spBuscarCategoria
go

create proc spBuscarCategoria @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id')
		select Id, Nombre, Descripcion, Coordinacion, Prioridad from Categoria where Id = @Busqueda
	else if (@Criterio = 'Nombre')
		select Id, Nombre, Descripcion, Coordinacion, Prioridad from Categoria where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Coordinacion')
		select Id, Nombre, Descripcion, Coordinacion, Prioridad from Categoria where Coordinacion = @Busqueda
	else if (@Criterio = 'Prioridad')
			select Id, Nombre, Descripcion, Coordinacion, Prioridad from Categoria where Prioridad = @Busqueda
	else if (@Criterio = 'Descripcion')
			select Id, Nombre, Descripcion, Coordinacion, Prioridad from Categoria where Descripcion like '%' + @Busqueda + '%'
end
use DBAtencionCliente
go

if OBJECT_ID('spAgregarTipo') is not null
	drop proc spAgregarTipo
go

create proc spAgregarTipo @Id varchar(10),
						 @Nombre varchar(20),
						 @Prioridad varchar(5) as begin

	if not exists (select Id from Tipo where Id = @Id) begin

		if exists (select Id from Prioridad where Id = @Prioridad) begin
			insert into Tipo (Id, Nombre, Prioridad) values (@Id, @Nombre, @Prioridad)
			select CodError = 0, Mensaje = 'Tipo insertado correctamente'
		end
		else 
			select CodError = 1, Mensaje = 'Error al insertar tipo. Prioridad faltante'
	end
	else
		select CodError = 1, Mensaje = 'Error al insertar el tipo'
end


if OBJECT_ID('spListarTipo') is not null
	drop proc spListarTipo
go

create proc spListarTipo as begin
	select Id, Nombre, Prioridad from Tipo
end


if OBJECT_ID('spActualizarTipo') is not null
	drop proc spActualizarTipo
go

create proc spActualizarTipo @Id varchar(10),
							 @Nombre varchar(20),
							 @Prioridad varchar(5) as begin

	if exists (select Id from Tipo where Id = @Id) begin

		if exists (select Id from Prioridad where Id = @Prioridad) begin
			update Tipo set Nombre = @Nombre, Prioridad = @Prioridad where Id = @Id 
			select CodError = 0, Mensaje = 'Tipo actualizado correctamente'
		end
		else 
			select CodError = 1, Mensaje = 'Error al actualizar tipo. Prioridad faltante'
	end
	else
		select CodError = 1, Mensaje = 'Error al actualizar el tipo'
end

if OBJECT_ID('spEliminarTipo') is not null
	drop proc spEliminarTipo
go

create proc spEliminarTipo @Id varchar(10) as begin
	if exists (select Id from Tipo where Id = @Id) begin
		delete from Tipo where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente el tipo'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar el tipo'
end

if OBJECT_ID('spBuscarTipo') is not null
	drop proc spBuscarTipo
go

create proc spBuscarTipo @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id') 
		select Id, Nombre, Prioridad from Tipo where Id = @Busqueda
	else if (@Criterio = 'Nombre') 
		select Id, Nombre, Prioridad from Tipo where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Prioridad') 
		select Id, Nombre, Prioridad from Tipo where Prioridad like '%' + @Busqueda + '%'
end


use DBAtencionCliente
go

if OBJECT_ID('spListarPrioridad') is not null
	drop proc spListarPrioridad
go

create proc spListarPrioridad as begin
	select Id, Nombre, Nivel from Prioridad
end



if OBJECT_ID('spAgregarPrioridad') is not null
	drop proc spAgregarPrioridad
go

create proc spAgregarPrioridad @Id varchar(5),
								@Nombre varchar(10),
								@Nivel int as begin
	
	if not exists (select Id from Prioridad where Id = @Id) begin
		insert into Prioridad (Id, Nombre, Nivel) values (@Id, @Nombre,  @Nivel) 
		select CodError = 0, Mensaje = 'Prioridad insertada correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al insertar la Prioridad'
end




if OBJECT_ID('spActualizarPrioridad') is not null
	drop proc spActualizarPrioridad
go

create proc spActualizarPrioridad @Id varchar(5),
								@Nombre varchar(10),
								@Nivel int as begin
	
	if exists (select Id from Prioridad where Id = @Id) begin
		update Prioridad set Nombre = @Nombre , Nivel = @Nivel where Id = @Id
		select CodError = 0, Mensaje = 'Prioridad actualizada correctamente'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al actualizar la Prioridad'
end

if OBJECT_ID('spEliminarPrioridad') is not null
	drop proc spEliminarPrioridad
go

create proc spEliminarPrioridad @Id varchar(5) as begin
	if exists (select Id from Prioridad where Id = @Id) begin
		delete from Prioridad where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente la Prioridad'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al eliminar la Prioridad'
end 


if OBJECT_ID('spBuscarPrioridad') is not null
	drop proc spBuscarPrioridad
go

create proc spBuscarPrioridad @Busqueda varchar(50), @Criterio varchar(20) as begin 
	if (@Criterio = 'Codigo') -- busqueda exacta
		select Id, Nombre, Nivel from Prioridad where Id = @Busqueda
	else if (@Criterio = 'Nombre') -- Busqueda sensitiva
		select Id, Nombre,  Nivel from Prioridad where Nombre like '%' + @Busqueda + '%'
	else if (@Criterio = 'Nivel')
		select Id, Nombre, Nivel from Prioridad where Nivel like '%' + @Busqueda + '%'
end



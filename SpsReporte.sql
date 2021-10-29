use DBAtencionCliente
go

if OBJECT_ID('spAgregarReporte') is not null
	drop proc spAgregarReporte
go

create proc spAgregarReporte @Id varchar(5),
							 @Administrador varchar(8),
							 @Detalle varchar(40),
							 @Fecha datetime as begin
	if not exists (select Id from Reporte where Id = @Id) begin
		if exists (select DNI from Administrador where DNI = @Administrador) begin
			insert into Reporte (Id, Administrador, Detalle, Fecha) values (@Id, @Administrador, @Detalle, @Fecha)
			select CodError = 0, Mensaje = 'Reporte insertado correctamente'
		end 
		else 
			select CodError = 1, Mensaje = 'Error al insertar reporte. Administrador faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al insertar reporte'
end 

if OBJECT_ID('spActualizarReporte') is not null
	drop proc spActualizarReporte
go

create proc spActualizarReporte @Id varchar(5),
							 @Administrador varchar(8),
							 @Detalle varchar(40),
							 @Fecha datetime as begin
	if exists (select Id from Reporte where Id = @Id) begin
		if exists (select DNI from Administrador where DNI = @Administrador) begin
			update Reporte set Administrador = @Administrador, Detalle = @Detalle, Fecha = @Fecha where Id = @Id
			select CodError = 0, Mensaje = 'Reporte actualizado correctamente'
		end 
		else 
			select CodError = 1, Mensaje = 'Error al actualizar reporte. Administrador faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al actualizar reporte'
end 

if OBJECT_ID('spEliminarReporte') is not null
	drop proc spEliminarReporte
go

create proc spEliminarReporte @Id varchar(5) as begin
	if exists (select Id from Reporte where Id = @Id) begin
		delete from Reporte where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente el reporte'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar el reporte'
end

if OBJECT_ID('spListarReporte') is not null
	drop proc spListarReporte
go

create proc spListarReporte as begin
	select Id, Administrador, Detalle, Fecha from Reporte
end

if OBJECT_ID('spBuscarReporte') is not null
	drop proc spBuscarReporte
go

create proc spBuscarReporte @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id')
		select Id, Administrador, Detalle, Fecha from Reporte where Id = @Busqueda
	else if (@Criterio = 'Administrador')
		select Id, Administrador, Detalle, Fecha from Reporte where Administrador = @Busqueda
	else if (@Criterio = 'Fecha')
		select Id, Administrador, Detalle, Fecha from Reporte where Fecha = @Busqueda
	else if (@Criterio = 'Detalle')
		select Id, Administrador, Detalle, Fecha from Reporte where Detalle like '%' + @Busqueda + '%'
	
end
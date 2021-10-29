use DBAtencionCliente
go

if OBJECT_ID('spAgregarPreguntaFrecuente') is not null
	drop proc spAgregarPreguntaFrecuente
go

create proc spAgregarPreguntaFrecuente @Id varchar(5),
									   @Administrador varchar(8),
									   @Pregunta varchar(100),
									   @Respuesta varchar(100) as begin 
	if not exists (select Id from PreguntaFrecuente where Id = @Id) begin
		if exists (select DNI from Administrador where DNI = @Administrador) begin
			insert into PreguntaFrecuente (Id, Administrador, Pregunta, Respuesta) values (@Id, @Administrador, @Pregunta, @Respuesta)
			select CodError = 0, Mensaje = 'Pregunta frecuente insertada correctamente'
		end 
		else 
			select CodError = 1, Mensaje = 'Error al insertar pregunta frecuente. Administrador faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al insertar pregunta frecuente'
end 

if OBJECT_ID('spActualizarPreguntaFrecuente') is not null
	drop proc spActualizarPreguntaFrecuente
go

create proc spActualizarPreguntaFrecuente @Id varchar(5),
									   @Administrador varchar(8),
									   @Pregunta varchar(100),
									   @Respuesta varchar(100) as begin 
	if exists (select Id from PreguntaFrecuente where Id = @Id) begin
		if exists (select DNI from Administrador where DNI = @Administrador) begin
			update PreguntaFrecuente set Administrador = @Administrador, Pregunta = @Pregunta, Respuesta = @Respuesta where Id = @Id
			select CodError = 0, Mensaje = 'Pregunta frecuente actualizada correctamente'
		end 
		else 
			select CodError = 1, Mensaje = 'Error al actualizar pregunta frecuente. Administrador faltante'
	end
	else 
		select CodError = 1, Mensaje = 'Error al actualizar pregunta frecuente'
end 


if OBJECT_ID('spEliminarPreguntaFrecuente') is not null
	drop proc spEliminarPreguntaFrecuente
go

create proc spEliminarPreguntaFrecuente @Id varchar(5) as begin
	if exists (select Id from PreguntaFrecuente where Id = @Id) begin
		delete from PreguntaFrecuente where Id = @Id
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente la pregunta frecuente'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar la pregunta frecuente'
end


if OBJECT_ID('spListarPreguntaFrecuente') is not null
	drop proc spListarPreguntaFrecuente
go

create proc spListarPreguntaFrecuente as begin
	select Id, Administrador, Pregunta, Respuesta from PreguntaFrecuente
end

if OBJECT_ID('spBuscarPreguntaFrecuente') is not null
	drop proc spBuscarPreguntaFrecuente
go

create proc spBuscarPreguntaFrecuente @Busqueda varchar(50), @Criterio varchar(20) as begin
	if (@Criterio = 'Id')
		select Id, Administrador, Pregunta, Respuesta from PreguntaFrecuente where Id = @Busqueda
	else if (@Criterio = 'Administrador')
		select Id, Administrador, Pregunta, Respuesta from PreguntaFrecuente where Administrador = @Busqueda
	else if (@Criterio = 'Pregunta')
		select Id, Administrador, Pregunta, Respuesta from PreguntaFrecuente where Pregunta like '%' + @Busqueda + '%'
	else if (@Criterio = 'Respuesta')
		select Id, Administrador, Pregunta, Respuesta from PreguntaFrecuente where Respuesta like '%' + @Busqueda + '%'
	
end
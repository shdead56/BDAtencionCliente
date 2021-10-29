use DBAtencionCliente
go

if OBJECT_ID('spAgregarCategoriaTipo') is not null
	drop proc spAgregarCategoriaTipo
go

create proc spAgregarCategoriaTipo @Categoria varchar(10),
								   @Tipo varchar(10) as begin

	if exists (select Id from Categoria where Id = @Categoria) begin 
		if exists (select Id from Tipo where Id = @Tipo) begin 
			if not exists (select Categoria, Tipo from CategoriaTipo where Categoria = @Categoria and Tipo = @Tipo) begin
				insert into CategoriaTipo (Categoria, Tipo) values (@Categoria, @Tipo) 
				select CodError = 0, Mensaje = 'CategoriaTipo insertado correctamente'
			end
			else 
				select CodError = 1, Mensaje = 'Error al insertar CategoriaTipo'
		end
		else 
			select CodError = 1, Mensaje = 'Error al insertar CategoriaTipo. Falta Tipo'
	end 
	else 
		select CodError = 1, Mensaje = 'Error al insertar CategoriaTipo. Falta Categoria'
end

if OBJECT_ID('spEliminarCategoriaTipo') is not null
	drop proc spEliminarCategoriaTipo
go

create proc spEliminarCategoriaTipo @Categoria varchar(10), @Tipo varchar(10) as begin
	if exists (select Categoria, Tipo from CategoriaTipo where Categoria = @Categoria and Tipo = @Tipo) begin
		delete from CategoriaTipo where Categoria = @Categoria and Tipo = @Tipo
		select CodError = 0, Mensaje = 'Se ha eliminado correctamente la CategoriaTipo'
	end
	else 
		select CodError = 1, Mensaje = 'Error al eliminar la CategoriaTipo'
end

if OBJECT_ID('spListarCategoriaTipo') is not null
	drop proc spListarCategoriaTipo
go


create proc spListarCategoriaTipo as begin
	select Categoria, Tipo from CategoriaTipo 
end


if OBJECT_ID('spBuscarCategoriaTipo') is not null
	drop proc spBuscarCategoriaTipo
go

create proc spBuscarCategoriaTipo @Categoria varchar(10), @Tipo varchar(10) as begin
	select Categoria, Tipo from CategoriaTipo where Categoria = @Categoria and Tipo = @Tipo
end


INSERT INTO PRODUCTOR (productor_id, rfc, direccion, nombre_productor, apellido_pat_productor, apellido_mat_productor)
VALUES 
(1, 'RFC00000001', 'Calle Falsa 123, Guasave, Sinaloa, México', 'Juan', 'Pérez', 'García'),
(2, 'RFC00000002', 'Avenida Siempre Viva 456, Culiacán, Sinaloa, México', 'María', 'López', 'Martínez'),
(3, 'RFC00000003', 'Boulevard del Sol 789, Ahome, Sinaloa, México', 'Carlos', 'Hernández', 'Sánchez'),
(4, 'RFC00000004', 'Plaza Central 101, León, Guanajuato, México', 'Laura', 'Rodríguez', 'Gómez'),
(5, 'RFC00000005', 'Camino Real 202, Irapuato, Guanajuato, México', 'Luis', 'Fernández', 'Díaz'),
(6, 'RFC00000006', 'Callejón de la Luna 303, Celaya, Guanajuato, México', 'Ana', 'Martínez', 'Vázquez'),
(7, 'RFC00000007', 'Sendero del Mar 404, Obregón, Sonora, México', 'Pedro', 'González', 'Ramírez'),
(8, 'RFC00000008', 'Autopista del Norte 505, Los Mochis, Sinaloa, México', 'Sofía', 'Morales', 'Torres'),
(9, 'RFC00000009', 'Calle de los Pinos 606, Huamantla, Tlaxcala, México', 'Miguel', 'Gutiérrez', 'Flores'),
(10, 'RFC00000010', 'Avenida de los Andes 707, Cuauhtémoc, Chihuahua, México', 'Elena', 'Jiménez', 'Rojas');


INSERT INTO CUENTA_CLABE (productor_id, clabe)
VALUES 
(1, 123456789012345678),
(2, 234567890123456789),
(3, 345678901234567890),
(4, 456789012345678901),
(5, 567890123456789012),
(6, 678901234567890123),
(7, 789012345678901234),
(8, 890123456789012345),
(9, 901234567890123456),
(10, 123450987654321098);
TABLE lugar;                       -- #LISTO   T: 1580 (1520 EMP, 59 D)

/* TIENDA Y  PRODUCTOS*/    
TABLE tienda;                      -- #LISTO   T: 59
TABLE rol;                         -- #        T: 9
TABLE privilegio;                  -- #        T: 7
TABLE privilegio_rol;              -- #        T: 7

/* EMPLEADOS */
TABLE empleado;                    -- #        T: 590   (531 update)
TABLE horario;                     -- #        T: 14 (7 MAÑANA, 7 TARDE)
TABLE horario_empleado;            -- #        T: 0
TABLE beneficio;                   -- #        T: 20
TABLE beneficio_empleado;          -- #        T: 0
TABLE control_entrada;             -- #        T: 0
TABLE vacaciones;                  -- #        T: 0

/*CLIENTES*/
TABLE cliente;                     -- #        T: 300/590 (80% NATURAL, 20% JURIDICO) ()
TABLE tipo_pago;                   -- #LISTO   T: 5
TABLE moneda;                      -- #LISTO   T: 5
TABLE cotizacion;                  -- #LISTO   T: 8
TABLE metodo_pago;                 -- #LISTO   T: 178 (2 NATURAL, 1 JURIDICO X TIENDA)

/*CLIENTES , PROVEEDORES, EMPLEADOS 
Y PERSONAS CONTACTO*/
TABLE usuario;                     -- #        T: 
TABLE proveedor;                   -- #        T: 21/336 (1 POR MUNICIPIO)
TABLE persona_contacto;            -- #        T: 
TABLE telefono;                    -- #        T: 

/*PRODUCTO , CARRITO, ORDENES*/
TABLE marca;                       -- #LISTO   T: 15 (11 PROPIA, 4 NO PROPIA)
TABLE rubro;                       -- #LISTO   T: 18
TABLE producto;                    -- #LISTO   T: 110 (10 POR MARCA PROPIA)
TABLE descuento;                   -- #LISTO   T: 6
TABLE estatus_reposicion;          -- #LISTO   T: 4
TABLE orden_reposicion;            -- #        T: 
TABLE zona;                        -- #LISTO   T: 8 
TABLE almacen;                     -- #        T: 
TABLE pasillo;                     -- #        T: 
                                   

/*CARRITO Y COMPRAS*/
TABLE carrito;                     -- #        T: 
TABLE carrito_producto;            -- #        T: 
TABLE estatus_despacho;            -- #LISTO   T: 3
TABLE compra;                      -- #        T: (300 WEB / 120 FISICAS)  POR TIENDA ... 2 WEB Y 1 FISICA POR 1 CLIENTE, 1 COMPRAN       ))))
TABLE metodo_pago_compra;          -- #        T: 
var datosProductos = []
$(document).ready(function () {
    $('#ID_PRO').numeric();
    consultar()
    allUnidades('ID_LOCAL')
    $('#btnEnviarEditar').hide()
    $('#ID_GRUPO').prop('disabled', true)
    $('#ID_LINEA').prop('disabled', true)
})
$(document).on('click', '#btnGrupoTiendas', function (event) {
    $('#BUSCAR').val('')
    $('#btnAgregar').click()
    consultar()
})

$(document).on('keyup', '#BUSCAR', function (event) {
    var queryResult = Enumerable.From(datosProductos)
        .Where(p => p.NOMBRE.toLowerCase().indexOf($('#BUSCAR').val()) != -1 || p.NOMBREUNIDAD.toLowerCase().indexOf($('#BUSCAR').val()) != -1
            || p.CLAVEP.toLowerCase().indexOf($('#BUSCAR').val()) != -1)
        .ToArray();
    llenarTabla(queryResult)
})
$(document).on('change', '#ID_LOCAL', function (event) {
    $('#ID_GRUPO').prop('disabled', false)
    $('#ID_LINEA').prop('disabled', false)
    allGrupos('ID_GRUPO',$("#ID_LOCAL").val())
    allLineas('ID_LINEA',$("#ID_LOCAL").val())
})
$(document).on('keyup', '#IMAGEN', function (event) {
    $("#imgPro").attr("src", $('#IMAGEN').val());

})
$(document).on('click', '#btnAgregar', function (event) {

    $('#h4Titulo').text('Agregar')
    limpiar()
    $('#ID_PRO').prop('disabled', true)
    $('#ID_GRUPO').prop('disabled', true)
});
$(document).on('click', '#btnEnviarAgregar', function (event) {
    var ocultoCB = $('#OCULTO').prop('checked') ? 1 : 0
    var mayoredadCB = $('#MAYOR_EDAD').prop('checked') ? 1 : 0
    var datosProductos = {
        CLAVE_: $('#CLAVE').val(),
        COLOR_: $('#COLOR').val(),
        DESCRIPCION_: $('#DESCRIPCION').val(),
        ID_GRUPO_: $('#ID_GRUPO').val(),
        ID_LINEA_: $('#ID_LINEA').val(),
        ID_LOCAL_: $('#ID_LOCAL').val(),
        ID_ORDEN_: $('#ID_ORDEN').val(),
        ID_PRINTER_: $('#ID_PRINTER').val(),
        ID_PRO_: $('#ID_PRO').val(),
        NOMBRE_: $('#NOMBRE').val(),
        OCULTO_: ocultoCB,
        PRED_TSERV_: $('#PRED_TSERV').val(),
        PRID_KDS_: $('#PRID_KDS').val(),
        TIPO_: $('#TIPO').val(),
        DESCRIPCIOND_: $('#DESCRIPCIOND').val(),
        IMAGEN_: $('#IMAGEN').val(),
        KCAL_: $('#KCAL').val(),
        KCALMAX_: $('#KCALMAX').val(),
        NOMBREPRODBASE_: $('#NOMBREPRODBASE').val(),
        MAYOR_EDAD_: mayoredadCB

    };
    $.ajax({
        url: 'AdminProductos.aspx/add',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        data: JSON.stringify(datosProductos),
        success: function (data) {
            mcxDialog.alert(data.d, {
                titleText: "Shake shack",
                sureBtnText: "Ok"
            });
            limpiar()
            consultar()
        },
        error: function (err) {
            alert(err);
        }
    });
});
$(document).on('click', '#btnEnviarEditar', function (event) {
    var ocultoCB = $('#OCULTO').prop('checked') ? 1 : 0
    var mayoredadCB = $('#MAYOR_EDAD').prop('checked') ? 1 : 0
    var datosProductos = {
        CLAVE_: $('#CLAVE').val(),
        COLOR_: $('#COLOR').val(),
        DESCRIPCION_: $('#DESCRIPCION').val(),
        ID_GRUPO_: $('#ID_GRUPO').val(),
        ID_LINEA_: $('#ID_LINEA').val(),
        ID_LOCAL_: $('#ID_LOCAL').val(),
        ID_ORDEN_: $('#ID_ORDEN').val(),
        ID_PRINTER_: $('#ID_PRINTER').val(),
        ID_PRO_: $('#ID_PRO').val(),
        NOMBRE_: $('#NOMBRE').val(),
        OCULTO_: ocultoCB,
        PRED_TSERV_: $('#PRED_TSERV').val(),
        PRID_KDS_: $('#PRID_KDS').val(),
        TIPO_: $('#TIPO').val(),
        DESCRIPCIOND_: $('#DESCRIPCIOND').val(),
        IMAGEN_: $('#IMAGEN').val(),
        KCAL_: $('#KCAL').val(),
        KCALMAX_: $('#KCALMAX').val(),
        NOMBREPRODBASE_: $('#NOMBREPRODBASE').val(),
        MAYOR_EDAD_: mayoredadCB
    };
    $.ajax({
        url: 'AdminProductos.aspx/edit',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        data: JSON.stringify(datosProductos),
        success: function (data) {
            mcxDialog.alert(data.d, {
                titleText: "Shake shack",
                sureBtnText: "Ok"
            });
            $('#btnEnviarEditar').hide()
            $('#btnEnviarAgregar').show()
            $('#h4Titulo').text('Agregar')
            limpiar()
            consultar()
        },
        error: function (err) {
            alert(err);
        }
    });
});
function llenarTabla(datos) {
    var html = ''
    if (datos.length > 0) {
        $.each(datos, function (index, value) {
            html += '<tbody  class="table">'
            html += '<tr >'
            html += '<td width="10%">' + value.ID_PRO
            html += '</td>'
            html += '<td width="30%">' + value.NOMBRE
            html += '</td>'
            html += '<td width="20%">' + value.CLAVEP
            html += '</td>'
            html += '<td width="15%">' + value.NOMBREUNIDAD
            html += '</td>'
            html += '<td width="10%"><a class="delUnidad" onclick="eliminar(' + value.ID_PRO + ',' + value.ID_LOCAL + ')" ><i class="fa fa-times fa-2x" aria-hidden="true"></i></a><a class="editUnidad" onclick="editar(' + value.ID_PRO + ',' + value.ID_LOCAL + ')"><i class="fa fa-pencil-square-o fa-2x" aria-hidden="true"></i></a>'
            html += '</td>'
            html += '</tr>'
            html += '</tbody >'
        })
    }
    else {
        html += '<tbody>'
        html += '<tr >'
        html += '<td alig="center" colspan="4">' + 'Sin resultados'
        html += '</td>'
        html += '</tr>'
        html += '</tbody>'
    }
    $("#tablaGrupos tbody").empty()
    $("#tablaGrupos").append(html)
}
function consultar() {
    $.ajax({
        url: 'AdminProductos.aspx/get',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        success: function (data) {
            datosProductos = data.d
            llenarTabla(datosProductos)
        },
        error: function (err) {
            alert(err);
        }
    });
}
function eliminar(idP, idL) {
    var datosProductos = { ID_PRO_: idP, ID_LOCAL_: idL};
    mcxDialog.confirm("¿Desea realizar esta acción?", {
        sureBtnText: "Si",
        sureBtnClick: function () {
            $.ajax({
                url: 'AdminProductos.aspx/delete',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datosProductos),
                dataType: "json",
                method: 'post',
                success: function (data) {
                    mcxDialog.alert(data.d, {
                        titleText: "Shake shack",
                        sureBtnText: "Ok"
                    });
                    consultar()
                },
                error: function (err) {
                    alert(err);
                }
            });
        }
    });
}
function editar(idP,idL) {
    $('#btnEnviarEditar').show()
    $('#btnEnviarAgregar').hide()
    $('#h4Titulo').text('Editar')
    $('#ID_PRO').prop('disabled', true)
    var queryResult = Enumerable.From(datosProductos)
        .Where(p => p.ID_PRO == idP && p.ID_LOCAL == idL)
        .FirstOrDefault();
    if (queryResult) {
        $('#CLAVE').val(queryResult.CLAVE),
            $('#COLOR').val(queryResult.COLOR)
            $('#DESCRIPCION').val(queryResult.DESCRIPCION)
            $('#ID_LOCAL').val(queryResult.ID_LOCAL)
        allGrupos('ID_GRUPO', $("#ID_LOCAL").val())
        allLineas('ID_LINEA', $("#ID_LOCAL").val())
        $('#ID_GRUPO').prop('disabled', false)
        $('#ID_LINEA').prop('disabled', false)
            $('#ID_GRUPO').val(queryResult.ID_GRUPO)
            $('#ID_LINEA').val(queryResult.ID_LINEA)
            $('#ID_ORDEN').val(queryResult.ID_ORDEN)
            $('#ID_PRINTER').val(queryResult.ID_PRINTER)
            $('#ID_PRO').val(queryResult.ID_PRO)
            $('#NOMBRE').val(queryResult.NOMBRE)
            $('#PRED_TSERV').val(queryResult.PRED_TSERV)
            $('#PRID_KDS').val(queryResult.PRID_KDS)
        $('#TIPO').val(queryResult.TIPO)
        queryResult.OCULTO == 1 ? $('#OCULTO').prop("checked", true) : $('#OCULTO').prop("checked", false)
        $('#DESCRIPCIOND').val(queryResult.DESCRIPCIOND)
        $('#IMAGEN').val(queryResult.IMAGEN)
        $('#KCAL').val(queryResult.KCAL)
        $('#KCALMAX').val(queryResult.KCALMAX)
        $('#NOMBREPRODBASE').val(queryResult.NOMBREPRODBASE)
        $("#imgPro").attr("src", queryResult.IMAGEN);
        queryResult.MAYOR_EDAD == 1 ? $('#MAYOR_EDAD').prop("checked", true) : $('#MAYOR_EDAD').prop("checked", false)

    }
}
function limpiar() {
    $('#CLAVE').val('')
        $('#COLOR').val('')
        $('#DESCRIPCION').val('')
        $('#ID_GRUPO').val('')
        $('#ID_LINEA').val('')
        $('#ID_LOCAL').val(0)
        $('#ID_ORDEN').val('')
        $('#ID_PRINTER').val('')
        $('#ID_PRO').val('')
        $('#NOMBRE').val('')
        $('#OCULTO').val('')
        $('#PRED_TSERV').val('')
        $('#PRID_KDS').val('')
        $('#TIPO').val('')
    $('#DESCRIPCIOND').val('')
    $('#IMAGEN').val('')
    $('#KCAL').val('')
    $('#KCALMAX').val('')
    $('#NOMBREPRODBASE').val('')
    $("#imgPro").attr("src", '');
}
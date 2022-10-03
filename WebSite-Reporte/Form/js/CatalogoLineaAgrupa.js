var datosLineaAgrupa = []
$(document).ready(function () {
    $('#ID_LINEAAGRUPA').numeric();
    consultar()
    allUnidades('ID_LOCAL')
    $('#btnEnviarEditar').hide()
})
$(document).on('click', '#btnGrupoTiendas', function (event) {
    $('#BUSCAR').val('')
    $('#btnAgregar').click()
    consultar()
})
$(document).on('keyup', '#BUSCAR', function (event) {
    var queryResult = Enumerable.From(datosLineaAgrupa)
        .Where(p => p.DESCRIPCION.toLowerCase().indexOf($('#BUSCAR').val()) != -1 || p.NOMBREUNIDAD.toLowerCase().indexOf($('#BUSCAR').val()) != -1)
        .ToArray();
    llenarTabla(queryResult)
})
$(document).on('click', '#btnAgregar', function (event) {
    $('#h4Titulo').text('Agregar')
    limpiar()
});
$(document).on('click', '#btnEnviarAgregar', function (event) {
    var activoCB = $('#ACTIVO').prop('checked') ? 1 : 0
    var mayorCB = $('#MAYOR_EDAD').prop('checked') ? 1 : 0
    var datosLineaAgrupa = {
        ID_LINEAAGRUPA_: $('#ID_LINEAAGRUPA').val(),
        ID_LOCAL_: $('#ID_LOCAL').val(),
        DESCRIPCION_: $('#DESCRIPCION').val(),
        DESC_LARGA_: $('#DESC_LARGA').val(),
        ORDEN_: $('#ORDEN').val(),
        MAYOR_EDAD_: mayorCB,
        ACTIVO_: activoCB
    };
    $.ajax({
        url: 'AdminLineaAgrupa.aspx/add',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        data: JSON.stringify(datosLineaAgrupa),
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
    var activoCB = $('#ACTIVO').prop('checked') ? 1 : 0
    var mayorCB = $('#MAYOR_EDAD').prop('checked') ? 1 : 0
    var datosLineaAgrupa = {
        ID_LINEAAGRUPA_: $('#ID_LINEAAGRUPA').val(),
        ID_LOCAL_: $('#ID_LOCAL').val(),
        DESCRIPCION_: $('#DESCRIPCION').val(),
        DESC_LARGA_: $('#DESC_LARGA').val(),
        ORDEN_: $('#ORDEN').val(),
        MAYOR_EDAD_: mayorCB,
        ACTIVO_: activoCB
    };
    $.ajax({
        url: 'AdminLineaAgrupa.aspx/edit',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        data: JSON.stringify(datosLineaAgrupa),
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
            html += '<td width="50%">' + value.ID_LINEAAGRUPA
            html += '</td>'
            html += '<td width="50%">' + value.NOMBREUNIDAD
            html += '</td>'
            html += '<td width="50%">' + value.DESCRIPCION
            html += '</td>'
            html += '<td width="50%"><a class="delUnidad" onclick="eliminar(' + value.ID_LINEAAGRUPA + ',' + value.ID_LOCAL + ')" ><i class="fa fa-times fa-2x" aria-hidden="true"></i></a><a class="editUnidad" onclick="editar(' + value.ID_LINEAAGRUPA + ',' + value.ID_LOCAL + ')"><i class="fa fa-pencil-square-o fa-2x" aria-hidden="true"></i></a>'
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
        url: 'AdminLineaAgrupa.aspx/get',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        success: function (data) {
            datosLineaAgrupa = data.d
            //console.log(datosLineaAgrupa)
            llenarTabla(datosLineaAgrupa)  
        },
        error: function (err) {
            alert(err);
        }
    });
}
function eliminar(idLA,idL) {
    //alert()

    var datosLineaAgrupa = {
        ID_LINEAAGRUPA_: idLA,
        ID_LOCAL_: idL
    };
    mcxDialog.confirm("¿Desea realizar esta acción?", {
        sureBtnText: "Si",
        sureBtnClick: function () {
            $.ajax({
                url: 'AdminLineaAgrupa.aspx/delete',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datosLineaAgrupa),
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
function editar(idLA, idL) {
    console.log(datosLineaAgrupa)
    $('#btnEnviarEditar').show()
    $('#btnEnviarAgregar').hide()
    $('#h4Titulo').text('Editar')
    $('#ID_LINEAAGRUPA').prop('disabled', true)
    $('#ID_LOCAL').prop('disabled', true)
    var queryResult = Enumerable.From(datosLineaAgrupa)
        .Where(p => p.ID_LINEAAGRUPA == idLA && p.ID_LOCAL == idL)
        .FirstOrDefault();
    console.log(idLA+''+ idL)
    console.log(queryResult)
    if (queryResult) {
        $('#ID_LINEAAGRUPA').val(queryResult.ID_LINEAAGRUPA),
            $('#ID_LOCAL').val(queryResult.ID_LOCAL),
            $('#DESCRIPCION').val(queryResult.DESCRIPCION),
            $('#DESC_LARGA').val(queryResult.DESC_LARGA),
            $('#ORDEN').val(queryResult.ORDEN),
        queryResult.ACTIVO == 1 ? $('#ACTIVO').prop("checked", true) : $('#ACTIVO').prop("checked", false)
        queryResult.MAYOR_EDAD == 1 ? $('#MAYOR_EDAD').prop("checked", true) : $('#MAYOR_EDAD').prop("checked", false)
    }
}
function limpiar() {
    $('#ID_LINEAAGRUPA').val('')
    $('#ID_LOCAL').val(0)
    $('#DESCRIPCION').val('')
    $('#DESC_LARGA').val('')
    $('#ORDEN').val('')
    $('#MAYOR_EDAD').val('')
    $('#ACTIVO').val('')
}
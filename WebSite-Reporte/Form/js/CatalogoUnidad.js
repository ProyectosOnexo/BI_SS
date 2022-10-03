var datos = []
$(document).ready(function () {
    $('#ID_LOCAL').numeric();
    consultar()
    $('#btnEnviarEditar').hide()
})
$(document).on('click', '#btnGrupoTiendas', function (event) {
    $('#BUSCAR').val('')
    $('#btnAgregar').click()
    consultar()
})
$(document).on('keyup', '#BUSCAR', function (event) {
    console.log($('#BUSCAR').val())
    var queryResult = Enumerable.From(datos)
        .Where(p => p.NOMBRE.toLowerCase().indexOf($('#BUSCAR').val()) != -1)
        .ToArray();
    llenarTabla(queryResult)
})
$(document).on('click', '#btnAgregar', function (event) {
    $('#h4Titulo').text('Agregar')
    limpiar()
});
$(document).on('click', '#btnEnviarAgregar', function (event) {
    var factivoCB = $('#FACTIVA').prop('checked') ? 1 : 0
    var datos = {
        ID_LOCAL_: $('#ID_LOCAL').val(),
        FACTIVA_: factivoCB,
        NOMBRE_: $('#NOMBRE').val(),
        DI_CALNUM1_: $('#DI_CALNUM1').val(),
        DI_CALNUM2_: $('#DI_CALNUM2').val(),
        DI_COL_1_: $('#DI_COL_1').val(),
        DI_COL_2_: $('#DI_COL_2').val(),
        DI_CPLUGA1_: $('#DI_CPLUGA1').val(),
        DI_CPLUGA2_: $('#DI_CPLUGA2').val(),
        LUGAR_: $('#LUGAR').val(),
        ESTADO_: $('#ESTADO').val()
    };
    $.ajax({
        url: 'AdminUnidades.aspx/add',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        data: JSON.stringify(datos),
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
    var factivoCB = $('#FACTIVA').prop('checked') ? 1 : 0
    var datos = {
        ID_LOCAL_: $('#ID_LOCAL').val(),
        FACTIVA_: factivoCB,
        NOMBRE_: $('#NOMBRE').val(),
        DI_CALNUM1_: $('#DI_CALNUM1').val(),
        DI_CALNUM2_: $('#DI_CALNUM2').val(),
        DI_COL_1_: $('#DI_COL_1').val(),
        DI_COL_2_: $('#DI_COL_2').val(),
        DI_CPLUGA1_: $('#DI_CPLUGA1').val(),
        DI_CPLUGA2_: $('#DI_CPLUGA2').val(),
        LUGAR_: $('#LUGAR').val(),
        ESTADO_: $('#ESTADO').val()
    };
    $.ajax({
        url: 'AdminUnidades.aspx/edit',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        data: JSON.stringify(datos),
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
    console.log(datos)
    var html = ''
    if (datos.length > 0) {
        $.each(datos, function (index, value) {
            html += '<tbody  class="table">'
            html += '<tr >'
            html += '<td width="50%">' + value.ID_LOCAL
            html += '</td>'
            html += '<td width="50%">' + value.NOMBRE
            html += '</td>'
            html += '<td width="50%">' + value.LUGAR
            html += '</td>'
            //html += '<td width="50%" align="center"><a class="delUnidad" onclick="eliminar(' + value.ID_LOCAL + ')" ><i class="fa fa-times fa-2x" aria-hidden="true"></i></a><a class="delUnidad" onclick="editar(' + value.ID_LOCAL + ')"><i class="fa fa-pencil-square-o fa-2x" aria-hidden="true"></i></span></a>'
            //html += '</td>'
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
        url: 'AdminUnidades.aspx/get',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        success: function (data) {
            datos = data.d
            llenarTabla(datos)
        },
        error: function (err) {
            alert(err);
        }
    });
}
function eliminar(id) {

    var datos = { ID_LOCAL_: id };
    mcxDialog.confirm("¿Desea realizar esta acción?", {
        sureBtnText: "Si",
        sureBtnClick: function () {
            $.ajax({
                url: 'AdminUnidades.aspx/delete',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
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
function editar(id) {
    $('#btnEnviarEditar').show()
    $('#btnEnviarAgregar').hide()
    $('#h4Titulo').text('Editar')
    $('#ID_LOCAL').prop('disabled',true)
    var queryResult = Enumerable.From(datos)
        .Where(p => p.ID_LOCAL == id)
        .FirstOrDefault();
    if (queryResult) {
        $('#ID_LOCAL').val(queryResult.ID_LOCAL),
            //$('#FACTIVA').val(queryResult.FACTIVA),
            queryResult.FACTIVA == 1 ? $('#FACTIVA').prop("checked", true) : $('#FACTIVA').prop("checked", false)
        $('#NOMBRE').val(queryResult.NOMBRE),
        $('#DI_CALNUM1').val(queryResult.DI_CALNUM1),
        $('#DI_CALNUM2').val(queryResult.DI_CALNUM2),
        $('#DI_COL_1').val(queryResult.DI_COL_1),
        $('#DI_COL_2').val(queryResult.DI_COL_2),
        $('#DI_CPLUGA1').val(queryResult.DI_CPLUGA1),
        $('#DI_CPLUGA2').val(queryResult.DI_CPLUGA2),
        $('#LUGAR').val(queryResult.LUGAR),
        $('#ESTADO').val(queryResult.ESTADO)
    }
}
function limpiar(){
    $('#ID_LOCAL').val('')
    $('#ID_CRTA').val('')
    $('#FACTIVA').val('')
    $('#NOMBRE').val('')
    $('#DI_CALNUM1').val('')
    $('#DI_CALNUM2').val('')
    $('#DI_COL_1').val('')
    $('#DI_COL_2').val('')
    $('#DI_CPLUGA1').val('')
    $('#DI_CPLUGA2').val('')
    $('#LUGAR').val('')
    $('#ESTADO').val('')
}
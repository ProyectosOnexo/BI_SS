var unidades = []
var grupos = []
function allUnidades(elemento) {
    $('#' + elemento).empty()
    $.ajax({
        url: 'AdminUnidades.aspx/get',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        success: function (data) {
            datos = data.d
            var html = ''
            console.log(data.d)
            //html += "<option value='0' >Selecciona una Unidad</option>"
            if (data.d.length > 0) {
                $.each(data.d, function (index, value) {
                    html += "<option value='" + value.ID_LOCAL + "' >" + value.NOMBRE+"</option>"
                })
            }
            $('#' + elemento).empty()  
            $('#' + elemento).append(html)
        },
        error: function (err) {
            alert(err);
        }
    });
}

function allGrupos(elemento, unidad) {
    var datos = {
        UNIDAD_: unidad
    };
    $('#' + elemento).empty()
    $.ajax({
        url: 'AdminLineaAgrupa.aspx/getPorUnidad',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        method: 'post',
        async:false,
        data: JSON.stringify(datos),
        success: function (data) {
            grupos = data.d
            var html = ''
            console.log(data.d)
            //html += "<option value='0' >Selecciona un Grupo</option>"
            if (data.d.length > 0) {
                $.each(data.d, function (index, value) {
                    html += "<option value='" + value.ID_LINEAAGRUPA + "' >" + value.DESCRIPCION + "</option>"
                })
            }

            $('#' + elemento).append(html)
        },
        error: function (err) {
            alert(err);
        }
    });
}
function allLineas(elemento, unidad) {
    var datos = {
        UNIDAD_: unidad
    };
    $('#' + elemento).empty()
    $.ajax({
        url: 'AdminProductos.aspx/getLineas',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        method: 'post',
        data: JSON.stringify(datos),
        success: function (data) {
            datos = data.d
            var html = ''
            console.log(data.d)
           // html += "<option value='0' >Selecciona una Linea</option>"
            if (data.d.length > 0) {
                $.each(data.d, function (index, value) {
                    html += "<option value='" + value.ID_LINEA + "' >" + value.LINEA + "</option>"
                })
            }
            $('#' + elemento).append(html)
        },
        error: function (err) {
            alert(err);
        }
    });
}
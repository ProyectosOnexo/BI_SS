var totalProductos =0
$(document).ready(function () {
    BuscarOrden()
    Productos('hamburquesas')
    $("ul.tabs li").click(function () {

        $("ul.tabs li").removeClass("active"); //Remove any "active" class
        $(this).addClass("active"); //Add "active" class to selected tab
        $(".tab_content").hide(); //Hide all tab content

        var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to          identify the active tab + content
        $(activeTab).fadeIn(); //Fade in the active ID content
        return false;
    });
    $('.ancla').click(function (e) {
        e.preventDefault();
        var strAncla = $(this).attr('href');
        $('body,html').stop(true, true).animate({
            scrollTop: $(strAncla).offset().top
        }, 1000);
    });
})
function Productos(linea) {
    var datos = { 'linea': linea };
    $.ajax({
        url: 'ShakeShak.aspx/GetProductos',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(datos),
        async: false,
        dataType: "json",
        method: 'post',
        success: function (data) {
            var html = ''
           // console.log(data.d)
            if (data.d.length > 0) {
                $.each(data.d, function (index, value) {
                    html += '<div class="card col-sm-4 col-xs-6">' +
                        '<div class="card " style="width: 100%;">' +
                        '<div class="card-body" id="producto_' + value.Id_producto + '">' +
                        '<img class="card-img-top" src="https://media.koala.fuzzhq.com/resize?source=https://koala-api-production.s3.amazonaws.com/global-products/1x1_5a813616-599f-40f8-95e4-413ac3cce3b4.jpeg&height=400&width=9999&max_quality=85" alt="Card image cap" />' +
                        '<h5 class="card-title" id="nombre_' + value.Id_producto + '">' + value.Nombre+ '</h5>' +
                        '<input type="hidden" id="modif_' + value.Id_producto + '" value="-1" />' +
                        '<h4 id="price_' + value.Id_producto + '">' + formatDollar(value.Precio) + '</h4>' +
                        '</div>' +
                        '<div class="card-footer oculta" style="" id="footer_' + value.Id_producto + '">' 

                    var datos2 = { 'id_pro': value.Id_producto };
                    $.ajax({
                        url: 'ShakeShak.aspx/GetModificadores',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos2),
                        dataType: "json",
                        async: false,
                        method: 'post',
                        success: function (data2) {
                            var html2 = ''
                            //console.log(data2.d)
                            if (data2.d.length > 0) {
                                $.each(data2.d, function (index2, value2) {
                                    html += '<table id="m_' + value.Id_producto + '">' +
                                        '<tr class="numero">' +
                                        '<td class="float-left m_' + value2.Id_op + ' "><div id="m_' + value2.Id_op + '" class="modificador select">' + value2.Modificador + '</div></td>' +
                                        '</tr>' +
                                        '</table>'
                                })
                            }
                            else {

                            }
                            //console.log(html)
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                        html+='<input type="number" name="edad" min="1" max="99" step="1" value="1" required="required" id="quan_' + value.Id_producto+ '" />' +
                        '<button class="addProducto btn btn-primary" id="pro_' + value.Id_producto + '">+ Agregar</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>'
                })
            }
            else {
                html += '<tbody>'
                html += '<tr >'
                html += '<td alig="center">' + 'sin productos'
                html += '</td>'
                html += '</tr>'
                html += '</tbody>'
            }
            //console.log(html)
            $('#divHamburguesas').html('');
            $('#divHamburguesas').html(html);
        },
        error: function (err) {
            alert(err);
        }
    });
}
function BuscarOrden(e) {
    var datos = { 'a': 'a' };
    $.ajax({
        url: 'ShakeShak.aspx/BuscarOrden',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(datos),
        dataType: "json",
        method: 'post',
        success: function (data) {
            var html = ''
            console.log(data.d)
            if (data.d.length > 0) {
                totalProductos = data.d.length
                $.each(data.d, function (index, value) {
                    html += '<table>'
                    html += '<td width="40%"><input type="hidden" id="posicion_'+value.Id_producto+'" value="'+value.Num+'"/>' + value.Nombre
                    html += '</td>'
                    html += '<td width="10%">' + value.Cantidad
                    html += '</td>'
                    html += '<td width="20%">' + value.Precio
                    html += '</td>'
                    html += '<td width="20%">' + (value.Cantidad * value.Precio)
                    html += '</td>'
                    html += '<td width="20%"><input type="button" id="del_' + value.Id_producto +'" value="eliminar" />'
                    html += '</td>'
                    html += '</tr>'
                    html += '</table>'
                })
            }
            else {
                html += '<tbody>'
                html += '<tr >'
                html += '<td alig="center">' + 'sin productos'
                html += '</td>'
                html += '</tr>'
                html += '</tbody>'
            }
            $('#divOrden').html('');
            $('#divOrden').html(html);
        },
        error: function (err) {
            alert(err);
        }
    });
}

$(document).on('click', '.addProducto', function (event) {
    var id = $(this).attr('id')
    var id_pro = id.split('_')[1]
    var price = $("#price_" + id_pro).text()
    var quan = $("#quan_" + id_pro).val()
    var id_modif = $("#modif_" + id_pro).val()
    var nombre = $("#nombre_" + id_pro).text()
    price = price.split('.')[0].replace('$', '').replace(',', '')
    //alert(id_pro + ' ' + price + ' ' + quan)
    var modificadores = id_pro+','
    $("#m_"+id_pro+" tbody tr").each(function (index) {
         var campo1, campo2;
         $(this).children("td").each(function (index2) {
             switch (index2) {
                  case 0:
                     campo1 = $(this).html();
                     break;
                  /*case 1:
                     campo2 = $(this).html();
                     break;*/
            }
         })
        modificadores += campo1.substring(11, 14)
        if (campo1.includes('select'))
            modificadores += '|+1,'
        else
            modificadores += '|-1,'  
       /* modificadores += campo2.substring(11, 14)
        if (campo2.includes('select'))
            modificadores += '|+1,'
        else
            modificadores += '|-1,'  */
    })
    //console.log(modificadores);
    var datos = { 'id_producto': id_pro, 'cantidad': quan, 'precio': price, 'modificador': modificadores, num: totalProductos + 1,'nombre':nombre,'id_modif':id_modif };
    
    $.ajax({
        url: 'ShakeShak.aspx/AddProducto',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(datos),
        dataType: "json",
        method: 'post',
        success: function (data) {
            $(".modificador").removeClass("select")
            $(".modificador").addClass("select")
            BuscarOrden()
        },
        error: function (err) {
            alert(err);
        }
    });
    
});

$(document).on('click', '.delProducto', function (event) {
    var id = $(this).attr('id')
    var id_pro = id.split('_')[1]
    var posicion = $("#posicion_" + id_pro).val()
    var datos = { 'posicion': posicion };
    $.ajax({
        url: 'ShakeShak.aspx/DelProducto',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(datos),
        dataType: "json",
        method: 'post',
        success: function (data) {
            BuscarOrden()
        },
        error: function (err) {
            alert(err);
        }
    });
});

$(document).on('click', '#btnTerminar', function (event) {
    window.location = "Finalizar.aspx";
});
$(document).on('click', '#Login', function (event) {
    window.location = "LoginOrden.aspx";
});
function Terminar() {
    var datos = { 'a': 'a' };
    $.ajax({
        url: 'ShakeShak.aspx/Terminar',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(datos),
        dataType: "json",
        method: 'post',
        success: function (data) {
            $("#qr").html( data.d )
            BuscarOrden()
        },
        error: function (err) {
            alert(err);
        }
    });
}
$(document).on('click', '.card-body', function (event) {
    var id = $(this).attr('id')
    var id_pro = id.split('_')[1]
    if ($("#footer_" + id_pro).hasClass("oculta")) {

        console.log('tiene ')
        $("#footer_" + id_pro).addClass("visible")
        $("#footer_" + id_pro).removeClass("oculta")
    }
    else {
        console.log('no tiene')
        $("#footer_" + id_pro).addClass("oculta")
        $("#footer_" + id_pro).removeClass("visible")
    }
});

$(document).on('click', '.modificador', function (event) {
    var id = $(this).attr('id')
    var id_pro = id.split('_')[1]
    if ($(this).hasClass("select"))
        $(this).removeClass("select")
    else
        $(this).addClass("select")
});

function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}
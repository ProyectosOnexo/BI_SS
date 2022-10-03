<%@ Page Language="C#" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Form_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content1" runat="Server" >
    <link href="css/StyleReporteDiario.css" rel="stylesheet" />
    <style>

        #containerIndex{
            margin-top: -20px;
            position: fixed;
            left: 0;
            right: 0;
            margin-left: auto;
            margin-right: auto;
            width: 15%;
        }

        ul.tabs {
	        margin: 0;
	        padding: 0;
	        float: left;
	        list-style: none;
	        height: 32px; /*--Set height of tabs--*/
	        border-bottom: 1px solid #999;
	        border-left: 1px solid #999;
	        width: 100%;
        }
        ul.tabs li {
	        float: left;
	        margin: 0;
	        padding: 0;
	        height: 31px; /*--Subtract 1px from the height of the unordered list--*/
	        line-height: 31px; /*--Vertically aligns the text within the tab--*/
	        border: 1px solid #999;
	        border-left: none;
	        margin-bottom: -1px; /*--Pull the list item down 1px--*/
	        overflow: hidden;
	        position: relative;
	        background: #e0e0e0;
        }
        ul.tabs li a {
	        text-decoration: none;
	        color: #000;
	        display: block;
	        font-size: 1.2em;
	        padding: 0 20px;
	        border: 1px solid #fff; /*--Gives the bevel look with a 1px white border inside the list item--*/
	        outline: none;
        }
        ul.tabs li a:hover {
	        background: #ccc;
        }
        html ul.tabs li.active, html ul.tabs li.active a:hover  { /*--Makes sure that the active tab does not
                listen to the hover properties--*/
	        background: #fff;
	        border-bottom: 1px solid #fff; /*--Makes the active tab look like it's connected with
                its content--*/
        }

        .tab_container {
	        border: 1px solid #999;
	        border-top: none;
	        overflow: hidden;
	        clear: both;
	        float: left; width: 100%;
	        background: #fff;
        }
        .tab_content {
	        padding: 20px;
	        font-size: 1.2em;
        }

        .btn {
            background-color: #fff !important;
            border: 1px solid #6db23f;
            color: #939393 !important;
        }

        .table-cont{
            /**make table can scroll**/
            max-height: 180px;
            overflow: auto;
            margin: 20px 10px;
            /*box-shadow: 0 0 2px 3px #ddd;*/
        }
        #tablaVH tr:hover{
            background-color:#ededed;
        }
         #tablaC tr:hover{
            background-color:#ededed;
        }
        #tablaDesc tr:hover{
            background-color:#ededed;
        }
        #tablaDescD tr:hover{
            background-color:#ededed;
        }
        #tablaMP tr:hover{
            background-color:#ededed;
        }

        #menuFlotante {
            position: fixed;
            bottom: 0%;
            right: 1%;
            margin-top: -50px;
            margin-left: -100px;
            background-color:#000;
            width:100%;
        }
        #menuFlotante ul li {
            list-style-type: none;
        }   
        #menuFlotante ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333333;
        }
        #menuFlotante li {
           float: left;
           width:20%
        }
        #menuFlotante a {
           text-decoration: none;
           color: #fff; /* Color texto */
           background-color: transparent; /* Color Fondo */
           display: block;
           padding-top: 3px;
           padding-right: 6px;
           padding-bottom: 3px;
           padding-left: 6px;
           font-size:10px;
        }
        /*#menuFlotante  a:hover {
            background-color: #ededed!important;
        }*/
  </style>
    
    <script>   
        window.onload = function(){
            var tableCont = document.querySelector('#table-cont')
            function scrollHandle(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }  
            tableCont.addEventListener('scroll', scrollHandle)

            /*cancelaciones*/
            var tableContC = document.querySelector('#table-contC')
            function scrollHandleC(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }  
            tableContC.addEventListener('scroll', scrollHandleC)
            /*descuentos*/
            var tableContD = document.querySelector('#table-contD')
            function scrollHandleD(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }  
            tableContD.addEventListener('scroll', scrollHandleD)
            
            var tableContDD = document.querySelector('#table-contDD')
            function scrollHandleDD(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }  
            tableContDD.addEventListener('scroll', scrollHandleDD)
            /*metodos de´pago*/
            var tableContP = document.querySelector('#table-contP')
            function scrollHandleP(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }  
            tableContP.addEventListener('scroll', scrollHandleP)
        }

        var colores = ['#6db23f','#92c164','#b1d18d','#cde1b6','#6db23f','#92c164','#b1d18d','#cde1b6']
        var num = 35
        var pref = "Content1_"
        var retAux = [
                { y: '2006', a: 100, b: 90, c: 50 },
                { y: '2007', a: 75, b: 65, c: 20 },
                { y: '2008', a: 50, b: 40, c: 50 },
                { y: '2009', a: 75, b: 65, c: 25 }
            ];
        var ret = [
                { y: '2006', a: 100, b: 90, c: 50 },
                { y: '2007', a: 75, b: 65, c: 20 },
                { y: '2008', a: 50, b: 40, c: 50 },
                { y: '2009', a: 75, b: 65, c: 25 }
        ];
         function dataGrafica(a, b, c) {     
                ret = JSON.parse(JSON.stringify(retAux));   
            if (a == false) {

                for (var i = 0; i < ret.length; i++)
                    delete ret[i].a;
            }
            if (b == false) {

                for (var i = 0; i < ret.length; i++)
                    delete ret[i].b;
            }
            if (c == false) {

                for (var i = 0; i < ret.length; i++)
                    delete ret[i].c;
            }
            return ret;
        };
        
        $(document).ready(function () {

            
            $('input[name="date1"]').daterangepicker({
                    locale: {
                            format: 'DD/MM/YYYY',
                        "daysOfWeek": [
                            "Do",
                            "Lu",
                            "Ma",
                            "Mi",
                            "Ju",
                            "Vi",
                            "Sa"                    
                        ],
                        "monthNames": [
                            "Enero",
                            "Febrero",
                            "Marzo",
                            "Abril",
                            "Mayo",
                            "Junio",
                            "Julio",
                            "Agosto",
                            "Septiembre",
                            "Octubre",
                            "Noviembre",
                            "Diciembre"
                        ]
                    }
          });
            var idioma = '<%=Session["lang"]%>'
            var tiendas
            if (idioma == 'en') {
                $('#btn1').attr('value', 'Search')
            }
           $(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to          identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

            $('.ancla').click(function(e){				
            e.preventDefault();	
		    var strAncla=$(this).attr('href'); 
			$('body,html').stop(true,true).animate({				
				scrollTop: $(strAncla).offset().top
			},1000);
            });

            var barChartData = {
                labels: ['11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23','0','1'],
                datasets: [{
                    label: 'Horario',
                    backgroundColor: ['#6db23f','#92c164','#b1d18d','#cde1b6', '#6db23f','#92c164','#b1d18d','#cde1b6','#6db23f','#92c164','#b1d18d','#cde1b6','#6db23f','#92c164'],
				borderColor: ['#6db23f','#92c164','#b1d18d','#cde1b6', '#6db23f','#92c164','#b1d18d','#cde1b6','#6db23f','#92c164','#b1d18d','#cde1b6','#6db23f','#92c164'],
				borderWidth: 1,
				data: [
					  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				    ]
			    }]

            };
            var barChartDataDesayunos = {
                labels: ['7', '8', '9', '10', '11', '12'],
                datasets: [{
                    label: 'Dataset 1',
                    backgroundColor: ['rgb(153,204,255)', 'rgb(153,204,255)', 'rgb(153,204,255)', 'rgb(153,204,255)', 'rgb(153,204,255)', 'rgb(153,204,255)'],
				borderWidth: 1,
				data: [
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]
            };
            var barChartDataComidas = {
                labels: [ '13', '14', '15', '16', '17'],
                datasets: [{
                    label: 'Dataset 1',
                    backgroundColor: [ 'rgb(255,153,0)', 'rgb(255,153,0)', 'rgb(255,153,0)', 'rgb(255,153,0)', 'rgb(255,153,0)'],
				borderWidth: 1,
				data: [
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]

            };
            var barChartDataCenas = {
                labels: [ '18', '19', '20', '21', '22', '23'],
                datasets: [{
                    label: 'Dataset 1',
                    backgroundColor: ['rgb(0,0,102)', 'rgb(0,0,102)', 'rgb(0,0,102)', 'rgb(0,0,102)', 'rgb(0,0,102)', 'rgb(0,0,102)'],
				    data: [
					        randomScalingFactor(),
					        randomScalingFactor(),
					        randomScalingFactor(),
					        randomScalingFactor(),
					        randomScalingFactor(),
					        randomScalingFactor()
				        ]
			    }]

            };
            /*data cancelaciones*/
            var barChartDataCancelaciones = {
                labels: ['1'],
                datasets: [{
                    label: 'Cancelaciones',
                    backgroundColor: [colores[Math.floor(Math.random()*8)]],
				    data: [ randomScalingFactor(), ]
			    }]
            };
            /*data descuentos*/
            var barChartDataDescuentos = {
                labels: ['1'],
                datasets: [{
                    label: 'Descuentos',
                    backgroundColor: [colores[Math.floor(Math.random()*8)]],
				    borderWidth: 1,
				    data: [ randomScalingFactor(),
				    ]
			    }]
            };
            var pieChartDataDescuentos = {
                labels: [],
                datasets: [{
                    label: 'Descuentos',
                    backgroundColor: [],
				    borderColor:[],
				    borderWidth: 1,
				    data: [ randomScalingFactor()
				    ]
			    }]
            };
            var pieChartDataStatus = {
                labels: ['No preparado', 'Preparado'],
                datasets: [{
                    label: 'Status de cancelación',
                    backgroundColor: [colores[Math.floor(Math.random()*8)], colores[Math.floor(Math.random()*8)]],
				    data: [
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]
            };
            var pieChartDataTipos = {
                labels: ['Comandera', 'Caja'],
                datasets: [{
                    label: 'Tipo de cancelación',
                    backgroundColor: [colores[Math.floor(Math.random()*8)], colores[Math.floor(Math.random()*8)]],
				    data: [
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]
            };
            var pieChartDataDesc = {
                labels: ['1','2'],
                datasets: [{
                    label: 'Cliente',
                    backgroundColor: [colores[Math.floor(Math.random()*8)], colores[Math.floor(Math.random()*8)]],
				    data: [
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]
            };
            /*data MP1*/
            var barChartDataMP1 = {
                labels: ['Efectivo', 'Débito', 'Crédito', 'Otros'],
                datasets: [{
                    label: 'Métodos de pago',
                    backgroundColor: ['#6db23f','#92c164','#b1d18d','#cde1b6'],
				    data: [
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]
            };
            /*data MP2*/
            var barChartDataMP2 = {
                labels: ['Efectivo', 'Débito', 'Crédito', 'Otros'],
                datasets: [{
                    label: 'Dataset 1',
                    backgroundColor: ['#6db23f','#92c164','#b1d18d','#cde1b6'],
				    data: [
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor(),
					    randomScalingFactor()
				    ]
			    }]
            };
            /*data mp3*/
            var barChartDataMP3 = {
                labels: ['1'],
                datasets: [{
                    label:'Métodos de pago',
                    backgroundColor: [colores[Math.floor(Math.random() * 85)]],
                    data: [randomScalingFactor(),
                    ]
			    }]
            };
            /*data mp4*/
            var barChartDataMP4 = {
                labels: ['1'],
                datasets: [{
                    label: 'Métodos de pago',
                    backgroundColor: [colores[Math.floor(Math.random()*8)]],
				    data: [ randomScalingFactor(), ]
			    }]
            };

            $('.thisOne').sortable({
                revert: true
            });
            var date_input = $('#' + pref + 'date1'); //our date input has the name "date"
            var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
            var options = {
                format: 'dd/mm/yyyy',
                container: container,
                todayHighlight: true,
                autoclose: true,
                language: 'es',
            };
            date_input.datepicker(options);


            var date_input2 = $('#' + pref + 'date2'); //our date input has the name "date"
            var container2 = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
            var options2 = {
                format: 'dd/mm/yyyy',
                container: container,
                todayHighlight: true,
                autoclose: true,
                language: 'es'
            };
            date_input2.datepicker(options2);
            
            var z = new Date();
            var n;
            if (z.getHours()< 12)
                n = new Date(z.setDate(z.getDate() - 1));
            else
                n = new Date(z.setDate(z.getDate()));
            console.log(z.getHours())
            y = n.getFullYear(); m = n.getMonth() + 1; d = n.getDate();
            $('#' + pref + 'date1').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date2').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            /*vertical bar*/ 
            var ctx = document.getElementById('canvas').getContext('2d');
			var myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
                        position: 'left',
                        display:false
					},
					title: {
						display: false,
						text: 'Ventas por horas'
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                            fontSize: 8,
                            beginAtZero: true,
                            stepSize: 20,
                            maxTicksLimit: 3
                        },
                            display:false
                        }]
                    }
                }
            });
            var ctx = document.getElementById('canvas').getContext('2d');
			var myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
                        position: 'left',
                        display:false
					},
					title: {
						display: false,
						text: 'Ventas por horas'
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                            fontSize: 8,
                            beginAtZero: true,
                            stepSize: 20,
                            maxTicksLimit: 3
                        },
                            display:false
                        }]
                    }
                }
            });
            var ctxDesayunos = document.getElementById('canvasDesayunos').getContext('2d');
			var myBarDesayunos = new Chart(ctxDesayunos, {
				type: 'bar',
				data: barChartDataDesayunos,
				options: {
					responsive: false,
					legend: {
                        position: 'left',
                        display:false
					}
                }
            });
            var ctxComidas = document.getElementById('canvasComidas').getContext('2d');
			var myBarComidas = new Chart(ctxComidas, {
				type: 'bar',
				data: barChartDataComidas,
				options: {
					responsive: false,
					legend: {
                        position: 'left',
                        display:false
					}
                }
            });
            var ctxCenas = document.getElementById('canvasCenas').getContext('2d');
			var myBarCenas = new Chart(ctxCenas, {
				type: 'bar',
				data: barChartDataCenas,
				options: {
					responsive: false,
					legend: {
                        position: 'left',
                        display:false
					}
                }
            });
            /*vertical bar*/ 
            /*cancelaciones bar*/
            var ctxHorizontal = document.getElementById('canvasC1').getContext('2d');
			var myBarHorizontal = new Chart(ctxHorizontal, {
				type: 'horizontalBar',
				data: barChartDataCancelaciones,
				options: {
					responsive: false,
					legend: {
                        position: 'left',
                        display:false
					},
					title: {
						display: false,
						text: 'Motivos de cancelaciones'
                    }
                }
            });
            /*cancelaciones bar*/ 
            /*descuentos bar*/
            var ctxDescHorizontal = document.getElementById('canvasDesc2').getContext('2d');
			var myBarDesHorizontalD = new Chart(ctxDescHorizontal, {
				type: 'horizontalBar',
				data: barChartDataDescuentos,
				options: {
					responsive: false,
					legend: {
                        position: 'left',
                        display:false
					},
					title: {
						display: false,
						text: 'Concepto del descuento'
                    }
                }
            });
            var ctxPieStatus = document.getElementById('canvasStatus').getContext('2d');
			var pieChartStatus= new Chart(ctxPieStatus, {
				type: 'pie',
				data: pieChartDataStatus   ,
				options: {
                    responsive: false,
                    legend: {
                        position: 'right',
                    }
                }
            });
            var ctxPieTipos = document.getElementById('canvasTipos').getContext('2d');
			var pieChartTipos= new Chart(ctxPieTipos, {
				type: 'pie',
				data: pieChartDataTipos   ,
				options: {
					responsive: false,
                    legend: {
                        position: 'right',
                    }
                }
            });
             var ctxPieDesc = document.getElementById('canvasDesc1').getContext('2d');
			var pieChartDesc= new Chart(ctxPieDesc, {
				type: 'pie',
				data: pieChartDataDesc   ,
				options: {
					responsive: false,
                    legend: {
                        position: 'right',
                    }
                }
            });
            /*descuentos bar*/
            var ctxMP1= document.getElementById('canvasMP1').getContext('2d');
			var myBarDesHorizontalMP1= new Chart(ctxMP1, {
				type: 'horizontalBar',
				data: barChartDataMP1   ,
				options: {
					responsive: false
                }
            });
            var ctxMP2 = document.getElementById('canvasMP2').getContext('2d');
			var myBarDesHorizontalMP2= new Chart(ctxMP2, {
				type: 'pie',
				data: barChartDataMP2   ,
				options: {
					responsive: false,
                    legend: {
                        position: 'right',
                    }
                }
            });
            var ctxMP3 = document.getElementById('canvasMP3').getContext('2d');
			var myBarDesHorizontalMP3= new Chart(ctxMP3, {
				type: 'horizontalBar',
				data: barChartDataMP3   ,
				options: {
					responsive: false
                }
            });
            var ctxMP4 = document.getElementById('canvasMP4').getContext('2d');
			var myBarDesHorizontalMP4= new Chart(ctxMP4, {
				type: 'horizontalBar',
				data: barChartDataMP4   ,
				options: {
					responsive: false
                }
            });
            /*
            var chart = Morris.Donut({
                element: 'dona',
                data: [
                    { value: 15, label: 'Venta' },
                    { value: 50, label: 'Presupuesto' }
                ],
                backgroundColor: '#ccc',
                labelColor: '#606060',
                colors: [
                    '#6db23f',
                    '#939393'
                ],
                formatter: function (x) { return x },
                resize: true,
                redraw: true
            });
            $('#graf1').on('change', function () {
                $('#graf3').prop('checked', false)
                var isChecked1 = $('#graf1').is(':checked');
                var isChecked2 = $('#graf2').is(':checked');
                var isChecked3 = $('#graf3').is(':checked');
                if($('#graf1').is(':checked'))
                    $(".cuadroVen").css('display', 'block')
                else
                    $(".cuadroVen").css('display', 'none')
                
                if($('#graf2').is(':checked'))
                    $(".cuadroPres").css('display', 'block')
                else
                    $(".cuadroPres").css('display', 'none')
                
                if($('#graf3').is(':checked'))
                    $(".cuadroTic").css('display', 'block')
                else
                    $(".cuadroTic").css('display','none')
                area.setData(dataGrafica(isChecked1, isChecked2, isChecked3));

            });
            $('#graf2').on('change', function () {
                $('#graf3').prop('checked', false)
                var isChecked1 = $('#graf1').is(':checked');
                var isChecked2 = $('#graf2').is(':checked');
                var isChecked3 = $('#graf3').is(':checked');
                if($('#graf1').is(':checked'))
                    $(".cuadroVen").css('display', 'block')
                else
                    $(".cuadroVen").css('display', 'none')
                
                if($('#graf2').is(':checked'))
                    $(".cuadroPres").css('display', 'block')
                else
                    $(".cuadroPres").css('display', 'none')
                
                if($('#graf3').is(':checked'))
                    $(".cuadroTic").css('display', 'block')
                else
                    $(".cuadroTic").css('display','none')
                area.setData(dataGrafica(isChecked1, isChecked2, isChecked3));
            });
            $('#graf3').on('change', function () {
                $('#graf1').prop('checked', false)
                $('#graf2').prop('checked', false)
                var isChecked1 = $('#graf1').is(':checked');
                var isChecked2 = $('#graf2').is(':checked');
                var isChecked3 = $('#graf3').is(':checked');
                if($('#graf1').is(':checked'))
                    $(".cuadroVen").css('display', 'block')
                else
                    $(".cuadroVen").css('display', 'none')
                
                if($('#graf2').is(':checked'))
                    $(".cuadroPres").css('display', 'block')
                else
                    $(".cuadroPres").css('display', 'none')
                
                if($('#graf3').is(':checked'))
                    $(".cuadroTic").css('display', 'block')
                else
                    $(".cuadroTic").css('display','none')
                area.setData(dataGrafica(isChecked1, isChecked2, isChecked3));
            });


            var area = Morris.Line({
                element: 'area',
                data: dataGrafica(),
                xkey: 'y',
                ykeys: ['a', 'b', 'c'],
                labels: ['Venta', 'Presupuesto', 'Tickets'],
                lineColors: ['#6db23f', '#939393', '#6db23f'],
                resize: true,
                redraw: true
            });
            var isChecked11 = $('#graf1').is(':checked');
            var isChecked21 = $('#graf2').is(':checked');
            var isChecked31 = $('#graf3').is(':checked');
                if($('#graf1').is(':checked'))
                    $(".cuadroVen").css('display', 'block')
                else
                    $(".cuadroVen").css('display', 'none')
                
                if($('#graf2').is(':checked'))
                    $(".cuadroPres").css('display', 'block')
                else
                    $(".cuadroPres").css('display', 'none')
                
                if($('#graf3').is(':checked'))
                    $(".cuadroTic").css('display', 'block')
                else
                    $(".cuadroTic").css('display','none')
            area.setData(dataGrafica(isChecked11, isChecked21, isChecked31));
            */
            var fecha = '<%=Session["fecha"]%>'
            var sucursal = '<%=Session["sucursal"]%>'
            $('#date1').val(fecha)
            //console.log(fecha+' ' +fecha2+ ' '+sucursal)
            /**llenar info/ */
            $('#' + pref + "DropDownList12 option[value='" + sucursal + "']").attr("selected", true);
            /*$('#' + pref + 'date1').val(fecha)
            $('#' + pref + 'date2').val(fecha2*/
            //llenadoInfo()
            llenadoGraficas()
                //imagenes();
            $("#btn1").click(function () {
                //llenadoInfo()
                llenadoGraficas()
            });

            function llenadoInfo() {
            var datos = { 'f1': $('#date1').val(),  'tienda': $('#' + pref + 'DropDownList12').val() };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaDashboard_',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    async:false,
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = ''
                        /*
                        $.each(data.d.ListTabla, function (index, value) {
                            html += '<table class="table">'
                            html += '<tr >'
                            html += '<td width="25%">' + value.Sucursal
                            html += '</td>'
                            html += '<td width="25%">' + value.VentaBruta
                            html += '</td>'
                            html += '<td width="25%">' + value.VentaNeta
                            html += '</td>'
                            html += '<td width="25%">' + value.Tickets
                            html += '</td>'
                            html += '</tr>'
                            html += '</table>'
                        })
                        $("#divDashContenido").html(html)
                        chart.setData([
                            { label: "Venta", value: data.d.Dona.Venta },
                            { label: "Presupuesto", value: data.d.Dona.Presupuesto },
                        ]);
                        jsonObj = [];
                        $.each(data.d.ListArea, function (index, value) {
                            item = {}
                            item["y"] = value.ValorY;
                            item["a"] = value.ValorA;
                            item["b"] = value.ValorB;
                            item["c"] = value.ValorC;
                            jsonObj.push(item);
                        });
                        retAux = jsonObj
                        ret = jsonObj                        
                        //area.setData( jsonObj);
                        var isChecked1 = $('#graf1').is(':checked');
                        var isChecked2 = $('#graf2').is(':checked');
                        var isChecked3 = $('#graf3').is(':checked');
                            if($('#graf1').is(':checked'))
                                $(".cuadroVen").css('display', 'block')
                            else
                                $(".cuadroVen").css('display', 'none')                
                            if($('#graf2').is(':checked'))
                                $(".cuadroPres").css('display', 'block')
                            else
                                $(".cuadroPres").css('display', 'none')
                
                            if($('#graf3').is(':checked'))
                                $(".cuadroTic").css('display', 'block')
                            else
                                $(".cuadroTic").css('display','none')
                        area.setData(dataGrafica(isChecked1, isChecked2, isChecked3));
                        */
                        console.log(data.d)
                        $("#txtVentas").html(data.d.Tendencia)
                        $("#txtVentas2").html(data.d.Ventas)
                        $("#txtPresupuesto").html(data.d.Presupuesto)
                        $("#txtTickets").html(data.d.Tickets)
                        $("#txtTicketsProm").html(data.d.TicketsPromedio)
                        //var total =parseFloat( data.d.Ventas) + parseFloat(data.d.Presupuesto)
                        //$('#txtTotal').html(total)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }

            function llenadoGraficas() {
                 var fecha2 = $('#date1').val()
                    var sucursal2 = '<%=Session["sucursal"]%>'
                //var datos = { 'f1': fecha2, 'f2': fecha2, 'tienda': $('#' + pref + 'DropDownList12').val() };
                var datos = { 'f1': fecha2, 'tienda': sucursal2 };
                console.log(datos)
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaDashboardNuevo_',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    async:false,
                    method: 'post',
                    success: function (data) {
                        var html = ''
                        console.log(data.d.ListVentasH)
                        $.each(data.d.ListVentasH, function (index, value) {
                            html += '<tbody >'
                            html += '<tr >'
                            html += '<td >' + value.Descripcion
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Total)
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Comidas)
                            html += '</td>'
                            html += '<td >' + formatPorcentaje(value.PComidas)
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Cenas)
                            html += '</td>'
                            html += '<td >' + formatPorcentaje(value.PCenas)
                            html += '</td>'
                            html += '</tr>'
                            html += '</tbody>'
                        })
                        $("#tablaVH tbody").empty();
                        $("#tablaVH").append(html)

                        html = ''
                        $.each(data.d.ListVentasC, function (index, value) {
                            html += '<tbody >'
                            html += '<tr >'
                            html += '<td >' + value.Descripcion
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Monto)
                            html += '</td>'
                            html += '<td >' + value.Porciones
                            html += '</td>'
                            html += '</tr>'
                            html += '</tbody>'
                        })
                        $("#tablaC tbody").empty();
                        $("#tablaC").append(html)


                        html = ''
                        $.each(data.d.ListVentasD, function (index, value) {
                            html += '<tbody >'
                            html += '<tr >'
                            html += '<td >' + value.Nombre
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Venta)
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Descuento)
                            html += '</td>'
                            html += '<td >' + formatDollar(value.ImporteCDescuento)
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Neto)
                            html += '</td>'
                            html += '<td >' + formatPorcentaje(value.Descu)
                            html += '</td>'
                            html += '<td >' + value.Porciones
                            html += '</td>'
                            html += '</tr>'
                            html += '</tbody>'
                        })
                        $("#tablaDesc tbody").empty();
                        $("#tablaDesc").append(html)
                        var i = 0
                        barChartData.datasets.forEach(function (dataset) {
                            dataset.data = dataset.data.map(function () {
                                i++
                                return data.d.ListGaficaH[i-1].Registros;
                            });

                        });
                        myBar.update();
                        
                        var l1 = barChartDataCancelaciones.datasets[0].data.length
                        for (var x1 = 0; x1 < l1; x1++) {
                            barChartDataCancelaciones.labels.splice(-1, 1);
                            barChartDataCancelaciones.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        myBarHorizontal.update();
                        i = 0;
                        $.each(data.d.ListGaficaC, function (index, value) {
                            barChartDataCancelaciones.labels.push(value.Descripcion);
                            barChartDataCancelaciones.datasets[barChartDataCancelaciones.datasets.length - 1].data.push(value.Registros);
                            barChartDataCancelaciones.datasets[barChartDataCancelaciones.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random()*8)];
                            myBarHorizontal.update();
                            i++
                        })
                        var l11 = pieChartDataStatus.datasets[0].data.length
                        for (var x1 = 0; x1 < l11; x1++) {
                            pieChartDataStatus.labels.splice(-1, 1);
                            pieChartDataStatus.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        pieChartStatus.update();
                        i = 0;
                        $.each(data.d.ListStatusCancel, function (index, value) {
                            pieChartDataStatus.labels.push(value.Descripcion);
                            pieChartDataStatus.datasets[pieChartDataStatus.datasets.length - 1].data.push(value.Valor);
                            pieChartDataStatus.datasets[pieChartDataStatus.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random()*8)];
                            pieChartStatus.update();
                            i++
                        })
                        var l12 = pieChartDataTipos.datasets[0].data.length
                        for (var x1 = 0; x1 < l12; x1++) {
                            pieChartDataTipos.labels.splice(-1, 1);
                            pieChartDataTipos.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        pieChartTipos.update();
                        i = 0;
                        $.each(data.d.ListTipoCancel, function (index, value) {
                            pieChartDataTipos.labels.push(value.Descripcion);
                            pieChartDataTipos.datasets[pieChartDataTipos.datasets.length - 1].data.push(value.Valor);
                            pieChartDataTipos.datasets[pieChartDataTipos.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random()*8)];
                            pieChartTipos.update();
                            i++
                        })
                        /*descuentos*/
                        
                        var l2 = barChartDataDescuentos.datasets[0].data.length
                        for (var x = 0; x < l2; x++) {
                            barChartDataDescuentos.labels.splice(-1, 1);
                            barChartDataDescuentos.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        myBarDesHorizontalD.update();
                        i=0
                        $.each(data.d.ListGaficaD, function (index, value) {
                                barChartDataDescuentos.labels.push(value.Descripcion);
                                barChartDataDescuentos.datasets[barChartDataDescuentos.datasets.length - 1].data.push(value.Registros);
                                barChartDataDescuentos.datasets[barChartDataDescuentos.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random() * 85)];
                                myBarDesHorizontalD.update();
                                i++
                        })  

                        var l3 = pieChartDataDesc.datasets[0].data.length
                        for (var x = 0; x < l3; x++) {
                            pieChartDataDesc.labels.splice(-1, 1);
                            pieChartDataDesc.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        pieChartDesc.update();
                        i=0
                        $.each(data.d.ListGaficaD, function (index, value) {
                            if (i < 6) {
                            //if (value.Registros > 0) {
                            pieChartDataDesc.labels.push(value.Descripcion);
                            pieChartDataDesc.datasets[barChartDataDescuentos.datasets.length-1].data.push(value.Registros);
                            pieChartDataDesc.datasets[barChartDataDescuentos.datasets.length-1].backgroundColor[i] = colores[Math.floor(Math.random()*8)]; 
                            pieChartDesc.update();
                            i++
                            }
                        })   

                        html = ''
                        $.each(data.d.ListMP, function (index, value) {
                            html += '<tbody >'
                            if (value.Tipo == 1)//decimal
                            {
                                html += '<tr >'
                                html += '<td >' + value.Descripcion
                                html += '</td>'
                                html += '<td >' + formatDollar(value.Efectivo)
                                html += '</td>'
                                html += '<td >' + formatDollar(value.Debito)
                                html += '</td>'
                                html += '<td >' + formatDollar(value.Credito)
                                html += '</td>'
                                html += '<td >' + formatDollar(value.Otros)
                                html += '</td>'
                                html += '<td >' + formatDollar(value.Total)
                                html += '</td>'
                                html += '</tr>'
                            }
                            if (value.Tipo == 0)//entero
                            {
                                html += '<tr >'
                                html += '<td >' + value.Descripcion
                                html += '</td>'
                                html += '<td >' + value.Efectivo
                                html += '</td>'
                                html += '<td >' + value.Debito
                                html += '</td>'
                                html += '<td >' + value.Credito
                                html += '</td>'
                                html += '<td >' + value.Otros
                                html += '</td>'
                                html += '<td >' + value.Total
                                html += '</td>'
                                html += '</tr>'
                            }
                            if (value.Tipo == 2)//porcentaje {
                            {
                                html += '<tr >'
                                html += '<td >' + value.Descripcion
                                html += '</td>'
                                html += '<td >' + formatPorcentaje(value.Efectivo)
                                html += '</td>'
                                html += '<td >' + formatPorcentaje(value.Debito)
                                html += '</td>'
                                html += '<td >' + formatPorcentaje(value.Credito)
                                html += '</td>'
                                html += '<td >' + formatPorcentaje(value.Otros)
                                html += '</td>'
                                html += '<td >' + formatPorcentaje(value.Total)
                                html += '</td>'
                                html += '</tr>'
                            }
                            if (value.Tipo == 3)//--- {
                            {
                                var y =0
                            }
                            html += '</tbody>'
                        })
                        $("#tablaMP tbody").empty();
                        $("#tablaMP").append(html)
                        /*===========================================================================*/
                        var l8 = barChartDataMP1.datasets[0].data.length
                        for (var x = 0; x < l8; x++) {
                            barChartDataMP1.labels.splice(-1, 1);
                            barChartDataMP1.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        myBarDesHorizontalMP1.update();
                        i=0
                        $.each(data.d.ListMP, function (index, value) {
                            if (value.Tipo == 1) {
                                barChartDataMP1.labels.push('Efectivo');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push(value.Efectivo);
                                myBarDesHorizontalMP1.update();

                                barChartDataMP1.labels.push('Débito');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push(value.Debito);
                                myBarDesHorizontalMP1.update();

                                barChartDataMP1.labels.push('Crédito');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push(value.Credito);
                                myBarDesHorizontalMP1.update();

                                barChartDataMP1.labels.push('Otros');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push(value.Otros);
                                myBarDesHorizontalMP1.update();

                                i++
                            }
                        })   
                        /*for (var x1 = 0; x1 < l8; x1++) {
                            barChartDataMP1.labels.splice(-1, 1);
                            barChartDataMP1.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        myBarDesHorizontalMP1.update();

                        i = 0;
                        $.each(data.d.ListMP, function (index, value) {
                            if (value.Tipo == 0) { 
                                console.log(data.d.ListMP)
                                barChartDataMP1.labels.push('Efectivo');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push((value.Efectivo/(value.Efectivo+value.Debito+value.Credito+value.Otros)).toFixed(1));
                                //barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random() * 85)];
                                myBarDesHorizontalMP1.update();
                                i++                                
                                barChartDataMP1.labels.push('Débito');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push((value.Debito/(value.Efectivo+value.Debito+value.Credito+value.Otros)).toFixed(1));
                                //barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random() * 85)];
                                myBarDesHorizontalMP1.update();
                                i++                                
                                barChartDataMP1.labels.push('Crédito');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push((value.Credito/(value.Efectivo+value.Debito+value.Credito+value.Otros)).toFixed(1));
                                //barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random() * 85)];
                                myBarDesHorizontalMP1.update();
                                i++                                
                                barChartDataMP1.labels.push('Otros');
                                barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].data.push((value.Otros/(value.Efectivo+value.Debito+value.Credito+value.Otros)).toFixed(1));
                                //barChartDataMP1.datasets[barChartDataMP1.datasets.length - 1].backgroundColor[i] = colores[Math.floor(Math.random() * 85)];
                                myBarDesHorizontalMP1.update();
                                i++
                            }
                        })*/
                        /*============================================================*/
                        var l9 = barChartDataMP2.datasets[0].data.length
                        for (var x1 = 0; x1 < l9; x1++) {
                            barChartDataMP2.labels.splice(-1, 1);
                            barChartDataMP2.datasets.forEach(function (dataset) {
                                dataset.data.pop();
                            });
                        }
                        myBarDesHorizontalMP2.update();

                        i = 0;
                        //console.log('tx #')
                        //console.log(data.d.ListMP)
                        $.each(data.d.ListMP, function (index, value) {
                            if (value.Tipo == 0) { 
                                //console.log(data.d.ListMP)
                                barChartDataMP2.labels.push('Efectivo');
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].data.push(Math.round(100*((value.Efectivo/(value.Efectivo+value.Debito+value.Credito+value.Otros)))).toFixed(0));
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].backgroundColor[i] = colores[1];
                                myBarDesHorizontalMP2.update();
                                i++                                
                                barChartDataMP2.labels.push('Débito');
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].data.push(Math.round(100*((value.Debito/(value.Efectivo+value.Debito+value.Credito+value.Otros)))).toFixed(0));
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].backgroundColor[i] = colores[3];
                                myBarDesHorizontalMP2.update();
                                i++                                
                                barChartDataMP2.labels.push('Crédito');
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].data.push(Math.round(100*((value.Credito/(value.Efectivo+value.Debito+value.Credito+value.Otros)))).toFixed(0));
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].backgroundColor[i] = colores[3];
                                myBarDesHorizontalMP2.update();
                                i++                                
                                barChartDataMP2.labels.push('Otros');
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].data.push(Math.round(100*((value.Otros/(value.Efectivo+value.Debito+value.Credito+value.Otros)))).toFixed(0));
                                barChartDataMP2.datasets[barChartDataMP2.datasets.length - 1].backgroundColor[i] = colores[4];
                                myBarDesHorizontalMP2.update();
                                i++
                            }
                            /*================================================================================*/ 
                            var l10 = barChartDataMP3.datasets[0].data.length
                            for (var x = 0; x < l10; x++) {
                                barChartDataMP3.labels.splice(-1, 1);
                                barChartDataMP3.datasets.forEach(function (dataset) {
                                    dataset.data.pop();
                                });
                            }
                            myBarDesHorizontalMP3.update();
                            i=0
                            $.each(data.d.ListGraficaMP3, function (index, value) {
                                barChartDataMP3.labels.push(value.Descripcion);
                                barChartDataMP3.datasets[barChartDataMP3.datasets.length-1].data.push(value.Registros);
                                barChartDataMP3.datasets[barChartDataMP3.datasets.length-1].backgroundColor[i] = colores[Math.floor(Math.random()*8)]; 
                                myBarDesHorizontalMP3.update();
                                i++
                            })   
                            /*====================================================*/
                            var l11 = barChartDataMP4.datasets[0].data.length
                            for (var x = 0; x < l11; x++) {
                                barChartDataMP4.labels.splice(-1, 1);
                                barChartDataMP4.datasets.forEach(function (dataset) {
                                    dataset.data.pop();
                                });
                            }
                            myBarDesHorizontalMP4.update();
                            i=0
                            $.each(data.d.ListGraficaMP4, function (index, value) {
                                barChartDataMP4.labels.push(value.Descripcion);
                                barChartDataMP4.datasets[barChartDataMP4.datasets.length-1].data.push(value.Registros);
                                barChartDataMP4.datasets[barChartDataMP4.datasets.length-1].backgroundColor[i] = colores[Math.floor(Math.random()*8)]; 
                                myBarDesHorizontalMP4.update();
                                i++
                            })   
                        })
                        html = ''
                        $.each(data.d.ListDetalle, function (index, value) {
                            html += '<tbody >'
                            html += '<tr >'
                            html += '</td>'
                            //html += '<td >'+ '<input type="button" id="' + value.Id + '" value="Detalle" class=" btnDetalle "/>'
                            html += '<td >'+ '<img src="img/detalles-35px.png" class="btnDetalle" alt="" id="' + value.Id + '" style="width:25px;" />'
                            html += '</td>'
                            html += '<td >' + value.Tipo
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Monto) 
                            html += '</td>'
                            html += '<td >' + formatDollar(value.Descuento) 
                            html += '</td>'
                            html += '<td >' + value.Aquien
                            html += '</td>'
                            html += '<td >' + value.Quien
                            html += '</td>'
                            html += '</tbody>'
                        })
                        $("#tablaDescD tbody").empty();
                        $("#tablaDescD").append(html)
                        console.log('grafica')
                    },
                    beforeSend: function () {
                   },
                    complete: function () {
                     
                   },
                   //
                    error: function (err) {
                        alert(err);
                    }
                });
                
              
            }
            //$("#tablaMP").change(function () {
            //    alert();
            //});
        //count();
            
        });    
        $(document).on('click', '.btnDetalle', function (event) {
            var id = $(this).attr('id')
            $("#modalTicket").modal();
            var datos = { 'id': id  };
            console.log(datos)
            $.ajax({
                url:  'AdministrarCuentas.aspx/DetalleTicketEncabezado',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {
                    var html = ''
                    console.log(data.d)
                    html = 'Orden: ' + data.d.Mesa + '<br>' +
                    'Fecha: '+ data.d.Apertura + '<br>' +
                    'Cliente: '+ data.d.Desc_info + '<br>' +
                    'Autorizó: '+ data.d.Desc_emp
                     
                    $("#encabezado").html(html)
                },
                error: function (err) {
                    alert(err);
                }
            });
            $.ajax({
                url:  'AdministrarCuentas.aspx/DetalleTicketCuerpo',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {

                    var html = ''
                    console.log(data.d)
                    var desc =0 
                    var importe =0
                    html = ''
                    html= '<table style="width:100%">'
                        $.each(data.d, function (index, value) {
                            importe += value.M_importe
                            desc += value.M_desc
                            html += '<tr >'
                            html += '<td  width="10%">' + value.Porciones
                            html += '</td>'
                            html += '<td  width="70%">' + value.Producto
                            html += '<td  width="20%" align="right">' +formatDollar( value.M_importe)
                    })
                    html+='</table>'
                        //$("#tblDetalleTicket tbody").empty();
                    //$("#tblDetalleTicket").append(html)
                    html+='<hr>'
                    html+='<table style="width:100%"><tr><td width="10%" align="right"> </td><td rowspan="2" width="70%">Importe</td><td width="20%" align="right">'+formatDollar(importe)+' </td></tr></table>'
                    html+='<table style="width:100%"><tr><td width="10%" align="right"> </td><td rowspan="2" width="70%">Descuento</td><td width="20%" align="right">'+formatDollar(desc)+' </td></tr></table>'
                    html+='<table style="width:100%"><tr><td width="10%" align="right"> </td><td rowspan="2" width="70%">Total</td><td width="20%" align="right">'+formatDollar(importe-desc)+' </td></tr></table>'
                    $("#cuerpo").html(html)
                },
                error: function (err) {
                    alert(err);
                }
            });
            $.ajax({
                url:  'AdministrarCuentas.aspx/DetalleTicketPago',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {
                    var html = ''
                    console.log(data.d)
                    html = 'Pago<br> ' +
                        '<div style="float:left">'+data.d.Forma_pago + '</div>' +
                            '<div style="float:right">' + formatDollar(data.d.Tc_monto)+'</div><div style="clear:both"></div>' 
                     
                    $("#pago").html(html)
                },
                error: function (err) {
                    alert(err);
                }
            });
        });
        
        function imagenes () {
                console.log('fue');
            var canvas = document.getElementById("canvasMP1");
            console.log(canvas.toDataURL("image/png"))
                var img = document.getElementById("mp1");
                img.src = canvas.toDataURL("image/png");
                                
                var canvas2 = document.getElementById("canvasMP2");
                var img2 = document.getElementById("mp2");
                img2.src = canvas2.toDataURL("image/png");
                                
                var canvas3 = document.getElementById("canvasMP3");
                var img3 = document.getElementById("mp3");
                img3.src = canvas3.toDataURL("image/png");
                
                var canvas4 = document.getElementById("canvasMP4");
                var img4 = document.getElementById("mp4");
                img4.src = canvas4.toDataURL("image/png");
                
                var canvas5 = document.getElementById("canvas");
                var img5 = document.getElementById("gh");
                img5.src = canvas5.toDataURL("image/png");
            }
        function formatDollar(num) {
            var p = num.toFixed(2).split(".");
            return "$" + p[0].split("").reverse().reduce(function(acc, num, i, orig) {
                return  num=="-" ? acc : num + (i && !(i % 3) ? "," : "") + acc;
            }, "") + "." + p[1];
        }
        function formatPorcentaje(num) {
            return (num*100).toFixed(1) + '%'
        }

        function count(){
          var counter = { var: 0 };
          TweenMax.to(counter, 3, {
            var: 400000, 
            onUpdate: function () {
              var number = Math.ceil(counter.var);
              $('.counter').html(number);
              if(number === counter.var){ count.kill(); }
            },
            onComplete: function(){
              count();
            },    
            ease:Circ.easeOut
          });
        }
    </script>
    <style>
        hr{
            border-style:dashed;
        }
        .btnDetalle:hover{
            cursor:pointer;
        }
        .btnDetalle:active{
           -webkit-box-shadow: -1px -1px 13px 0px rgba(0,0,0,0.75);
            -moz-box-shadow: -1px -1px 13px 0px rgba(0,0,0,0.75);
            box-shadow: -1px -1px 13px 0px rgba(0,0,0,0.75);
        }
    </style>
    <%-- <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDwNBXmHBDQ29JWsRH8gwNVkf7mM0-flaI"></script>

        <script type="text/javascript">
        var markers = [
            <asp:Repeater ID="rptMarkers" runat="server">
            <ItemTemplate>
            {
            "title": '<%# Eval("Estado") %>',
            "lat": '<%# Eval("lat") %>',
            "lng": '<%# Eval("long") %>',
            "description": '<%# Eval("Ubicacion") %>'
            }
            </ItemTemplate>
            <SeparatorTemplate>
            ,
            </SeparatorTemplate>
            </asp:Repeater>
            ];
    </script>

   <script type="text/javascript">

    $(document).ready(function () {

        var geocoder;

        var image = {
            url: "ImgPcks/Marcador_Google_selección.png",
            size: new google.maps.Size(44, 44),
			scaledSize: new google.maps.Size(44, 44)
        };

        geocoder = new google.maps.Geocoder();
        var mapOptions = {
            center: new google.maps.LatLng(markers[0].lat, markers[0].lng),
            zoom: 11,
            scrollwheel: false,
            disableDoubleClickZoom: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var infoWindow = new google.maps.InfoWindow();
        var infoWindow2 = new google.maps.InfoWindow();
        var infoWindowDatosTraidos = new google.maps.InfoWindow();

        var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);

        google.maps.event.addListener(map, 'click', function (event) {
            placeMarker(event.latLng);
        });


        function placeMarker(location) {
            if (marker1) { //on vérifie si le marqueur existe
                marker1.setPosition(location); //on change sa position
            } else {
                marker1 = new google.maps.Marker({ //on créé le marqueur
                    position: location,
                    map: map
                });
            }

            getAddress(location);
        }

        function getAddress(latLng) {
        geocoder.geocode({ 'latLng': latLng },
            function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        document.getElementById("address").value = results[0].formatted_address;
                    }
                    else {
                        document.getElementById("address").value = "No results";
                    }
                }
                else {
                    document.getElementById("address").value = status;
                }
            });
        }

        var infoWindowA = new google.maps.InfoWindow();
        for (i = 0; i < markers.length; i++) {
            var data = markers[i]
            var myLatlng = new google.maps.LatLng(data.lat, data.lng);
            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: data.title,
                icon:image
            });
            (function (marker, data) {
                google.maps.event.addListener(marker, "click", function (e) {
                    //infoWindow.setContent(data.description);
                    infoWindowA.setContent("<div style='text­align: justify;'>"+data.title+" <br/>" + data.description + "</div>");
                    infoWindowA.open(map, marker);
                });
            })(marker, data);
        }
    

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {

                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude,
                    icon: image,
                };

                var myLatlng2 = { lat: pos['lat'], lng: pos['lng']};
                var marker1 = new google.maps.Marker({
                position: myLatlng2,
                map: map,
                title: 'Ubicacion actual'
                });

                (function (marker1, data) {
                google.maps.event.addListener(marker1, "click", function (e) {
                    data = "UBICACION: " + "Ubicacion actual" + "<br/>" +
                        "LATITUD: " + pos['lat'] + "<br/>" +
                        "LONGITUD: " + pos['lng'] + "<br/>";
                    infoWindow2.setContent(data);
                    infoWindow2.open(map, marker1);
                });
                })(marker1, data);

                infoWindow.setPosition(pos);
                infoWindow.setContent('Su ubicacion actual');
                getAddress(location);
                infoWindow.open(map);
                map.setCenter(pos);

            }, function () {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
        }
    });

    </script>--%>
    
    <div id="modalTicket" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content" style="font-size:12px!important">
                <div class="modal-header">
                </div>
                <div class="modal-body contornoVerde2 divAdmin" style="margin-left: 5px; margin-right: 5px;">
                    
                    <div id="encabezado"></div>
                    <hr />
                    <div id="cuerpo">
                        <table id="tblDetalleTicket" style="width:100%">
                            <thead>
                           <%-- <tr>
                                <th width="50%">Producto</th>
                                <th width="50%">Producto</th>
                                <th width="10%">P. unit</th>
                                <th width="10%">Desc</th>
                                <th width="15%">Total</th>
                            </tr>--%>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <hr />
                    <div id="pago"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCloseAdmin">OK</button>
                </div>
            </div>

        </div>
    </div>
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish1" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish1" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />

    </div>
    <%--<div id="compartir" class="btn btn-primary">Compartir</div>--%>
    <div style="display:none">
    <img src="" id="mp1" style="height:130px;"/>
    <img src="" id="mp2" style="height:130px;"/>
    <img src="" id="mp3" style="height:130px;"/>
    <img src="" id="mp4" style="height:130px;"/>
    <img src="" id="gh" style="height:40px;"/>
        </div>
    <div class=" divDashboard thisOne" style="padding-top:15px">
        <div style="padding-top: 15px; padding-bottom: 5px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top: 10px"><a href="DetalleVenta.aspx"><img src="img/regresar.png" width="40"/></a> Dashboard</div>
            
            <div style="clear: both"></div>
        <A name="home" id="home"></A>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-sm-3">
                <div class="SeleccionarFecha">
                <div class="form-group has-feedback date" id="datetimepicker2">
                    <span class="ForeColor939393">
                        <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                    </span>
                    <input type="text" class="form-control BordeRadious" id="date1" name="date1" value="" placeholder="DD/MM/YYYY" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" />
                </div>
            </div>
            </div>
           <%-- <div class="col-sm-3">

                <div class="SeleccionarFecha">
                    <div class="form-group has-feedback date" id="datetimepicker1">
                        <span class="ForeColor939393">
                            <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                        </span>
                        <input runat="server" class="form-control BordeRadious" id="date1" name="date1" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
                    </div>

                </div>
            </div>
            <div class="col-sm-3">
                <div class="SeleccionarFecha">
                    <div class="form-group has-feedback date" id="datetimepicker2">
                        <span class="ForeColor939393">
                            <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                        </span>
                        <input runat="server" class="form-control BordeRadious" id="date2" name="date2" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
                    </div>

                </div>
            </div>--%>
            <div class="col-sm-3" style="display:none">
                <div class="SeleccionarFecha">
                    <div class="form-group has-feedback BordeRadious" style="">
                        <span class="ForeColor939393">
                            <img src="img/Home.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                        </span>
                       
                        <asp:DropDownList CssClass="form-control BordeRadious" ID="DropDownList12" DataSourceID="SqlDataSource1" runat="server" DataTextField="nombre" DataValueField="nombre" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px" >
                            <asp:ListItem Text="<%$Resources:multi.language,dash_todas%>"></asp:ListItem>
                        </asp:DropDownList>
                            
                        <asp:SqlDataSource  ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select T1.nombre from mlocal T1  join relacionGrupoSucursal T2 ON T1.id_local = T2.idlocal  join relacionSucursalUsuario t3 on t2.idgrupo = t3.id_local WHERE T3.id_usuario = @IdUsuario"></asp:SqlDataSource>
                        <asp:SqlDataSource  ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select nombre from mlocal where id_local >= 750"></asp:SqlDataSource>
                        
                        </div>

                </div>

            </div>
            <div class="col-sm-3">
                <input type="button" class="btn" value="Consultar" id="btn1" />
            </div>
        </div>
        <div class="clean"></div>
        <%--<div class="row" id="">
            
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div class="row" id="">
                    <div class="col-6" style="">
                        <div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cuadro1%>"/></div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="">
                                    <div class="valor" style="font-size:14px!important" id="txtVentas">-  </div>
                                    <div class="valor" style="font-size:14px!important  " id="txtVentas2">-  </div>
                                    <div class="clean"></div>
                                </div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_ventas.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cuadro2%>"/></div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left;padding-bottom:12px" id="txtPresupuesto">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_presupuesto.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div class="row" id="">
                    <div class="col-6" style="">
                        <div class="divInfo">
                            <div class="titulo2">Tickets</div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="">
                                    <div class="valor" style="" id="txtTickets">-  </div>
                                </div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_tickets.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cuadro4%>"/></div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="txtTicketsProm">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_descuento.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>--%>

        <div class="clean"></div>
        <%--<div class="divGrafica1 ocultar">
            <div class="titulo">Barra de status</div>
            <div class="row droidSans texto" style="padding-left: 15px;">
                <div class="col">
                    <input class="graf" type="checkbox" name="graf1" id="graf1" value="Ventas" checked>
                    Ventas</div>
                <div class="col">
                    <input class="graf" type="checkbox" name="graf2" id="graf2" value="Presupuesto" checked>
                    Presupuesto</div>
                <div class="col">
                    <input class="graf" type="checkbox" name="graf3" id="graf3" value="Tickets">
                    Tickets</div>
            </div>
            <div id="area"></div>
            <div>
                <div class="cuadroVerde cuadroVen" style="float: left; margin-right: 10px; margin-left: 10px"></div>
                <div class="droidSans grisClaro texto cuadroVen" style="float: left; margin-right: 10px">Ventas</div>
                <div class="cuadroGris cuadroPres" style="float: left; margin-right: 10px; margin-left: 10px"></div>
                <div class="droidSans grisClaro texto cuadroPres" style="float: left">Presupuesto</div>
                
                <div class="cuadroVerde cuadroTic" style="float: left; margin-right: 10px; margin-left: 10px"></div>
                <div class="droidSans grisClaro texto cuadroTic" style="float: left; margin-right: 10px">Tickets</div>
            </div>
        </div>--%>
        <div class="clean"></div>
        <%--<div class="">--%>
       <%-- <div class="row ocultar" style="margin-right: 0!important">
            <div class="col">
                <div class="divReportes">
                    <div class="titulo">
                        <asp:Label runat="server" Text="<%$Resources:multi.language,reportes%>"></asp:Label></div>
                    <div style="padding: 10px">
                        <table id="" class="table tablaAdmin" style="font-weight: normal!important">
                            <thead>
                                <tr>
                                    <th scope="col" width="25%">Sucursal</th>
                                    <th scope="col" width="25%">Venta bruta</th>
                                    <th scope="col" width="25%">Venta neta</th>
                                    <th scope="col" width="25%">Tickets</th>
                                </tr>
                            </thead>
                        </table>
                        <div id="divDashContenido" class="divContenidosTablasDash">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col col-lg-3">
                <div class="divPresupuesto">
                    <div class="titulo">Presupuesto</div>
                    <div style="margin: 0 15px 0 15px">
                        <div style="float: left" class="grisClaro texto droidSans">Total</div>
                        <div class="verde texto droidSans" style="float: right" id="txtTotal">0</div>
                        <div class="clean"></div>
                        <hr />
                    </div>
                    <div id="graficaPres">
                        <div id="dona" style="margin-top: -30px;width:95%;text-align:center"></div>
                    </div>
                        <div style="margin-left: 15px; margin-right: 15px; margin-top: -30px;" class="divMarcas">
                            <div class="cuadroVerde" style="float: left; margin-right: 10px; margin-left: 10px"></div>
                            <div class="droidSans grisClaro texto" style="float: left; margin-right: 10px">Ventas</div>
                            <div class="cuadroGris" style="float: left; margin-right: 10px"></div>
                            <div class="droidSans grisClaro texto" style="float: left">Presupuesto</div>
                            <div class="clean"></div>
                            <hr />
                        </div>
                </div>
            </div>
            <div class="col col-lg-3">
                <div class="divCumpleaños">
                        <div id="dvMap" style="height: 100%">
                        </div>
                    <!--<button onclick="getLocation()">Get your Location</button>-->  
                </div>
            </div>
            <div>
            </div>
        </div>--%>
        <%--</div>--%>
        <A name="pagos" id="pagos"></A>
        <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top:10px;border-top:2px solid #ededed;width:100%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodostitulo%>"/>&nbsp;<img  src="img/metodospago.png" height="25"/></div>
        <div class="clean"></div>
        <div class="recuadroMP">
            <div class="row " style="">
                <div class="col ">          
                    <div id="" style="height:24px;border-bottom:2px solid #939393;margin-bottom:10px;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_analisismetodos%>"/></div>
                    </div>
                    <div style="height: 180px; margin-top: -10px">
                        <div class='table-cont' id='table-contP'>
                            <table id="tablaMP" class="table tablaAdmin" style="font-weight: normal!important;">
                                <thead>
                                    <tr>
                                        <th scope="col" width="20%"></th>
                                        <th scope="col" width="15%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodostefectivo%>"/></th>
                                        <th scope="col" width="15%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodostdebito%>"/></th>
                                        <th scope="col" width="15%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodostcredito%>"/></th>
                                        <th scope="col" width="15%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodostotros%>"/></th>
                                        <th scope="col" width="20%">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="row " style="">
                <div class="col" >                    
                    <div id="" style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodossub1%>"/></div>
                    </div>
                    <div id="containerMP1" style="text-align:center">
                        <canvas id="canvasMP1" height="130"style="margin:auto;"></canvas>
                    </div>
                </div>
                <div class="col" >
                    <div id="" style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodossub4%>"/></div>
                    </div>
                    <div id="containerMP2" style="text-align:center;padding-top:15px">
                        <canvas id="canvasMP2" height="130"style="margin:auto;"></canvas>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="row " style="">
                <div class="col ">                    
                    <div id="" style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodossub1%>"/></div>
                    </div>
                    <div id="containerMP3" style="height: 150px;overflow:scroll;margin-top:15px">
                        <canvas id="canvasMP3" height="200" style="margin:auto;"></canvas>
                    </div>
                </div>
                <div class="col">
                    <div id="" style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_metodossub4%>"/></div>
                    </div>
                    <div id="containerMP4" style="height: 150px;overflow:scroll;margin-top:15px ">
                        <canvas id="canvasMP4" height="200" style="margin:auto;"></canvas>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
    </div>
                <A name="vhoras" id="vhoras"> </A>
            <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top:10px;border-top:2px solid #ededed;width:100%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_ventastitulo%>"/>&nbsp;<img  src="img/ventashora.png" height="25"/></div>
        <div class="clean"></div>
        <div class="recuadroVH">            
             <div id="" style="height:24px;border-bottom:2px solid #939393;margin-bottom:10px;;padding-bottom:35px">
                <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_vebtascomportamiento%>"/></div>
                </div>
            <div id="container" class="gvh" style="width: 100%;display:none">
		        <canvas id="canvas" height="40" style="margin:auto;"></canvas>
	        </div>
            <div class="clean"></div>
            <div id="tabVH">
            <ul class="tabs">
                <li><a href="#tab1">Desayunos</a></li>
                <li><a href="#tab2">Comidas</a></li>
                <li><a href="#tab3">Cenas</a></li>
            </ul>

                <div class="tab_container">
                    <div class="tab_content" id="tab1">
                        <div id="" style="width: 100%;">
                            <canvas id="canvasDesayunos" height="80" style="margin: auto;"></canvas>
                        </div>
                    </div>
                    <div class="tab_content" id="tab2">
                        <div id="" style="width: 100%;">
                            <canvas id="canvasComidas" height="80" style="margin: auto;"></canvas>
                        </div>
                    </div>
                    <div class="tab_content" id="tab3">
                        <div id="" style="width: 100%;">
                            <canvas id="canvasCenas" height="80" style="margin: auto;"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clean"></div>
            <div id="" style="height:24px;border-bottom:2px solid #939393;margin-bottom:10px;">
                <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_ventasanalisis%>"/></div>
            </div>
            <div style=" height: 200px;margin-top:-10px">
                <div class='table-cont' id='table-cont'>
                <table id="tablaVH" class="table tablaAdmin " style="font-weight: normal!important;">
                    <thead>
                        <tr>
                            <th scope="col" width="20%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_ventastgrupo%>"/> </th>
                            <th scope="col" width="20%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_ventasttotal%>"/></th>
                            <th scope="col" width="15%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_ventastcomidas%>"/></th>
                            <th scope="col" width="5%">%</th>
                            <th scope="col" width="15%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_ventastcenas%>"/></th>
                            <th scope="col" width="5%">%</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                </div>
            </div>
        </div>
                <A name="cancelaciones" id="cancelaciones"></A>
            <div class="grisFuerte ffGalaxie titulo" style="float: left;padding-top:10px;border-top:2px solid #ededed;width:100%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_canceltitulo%>"/>&nbsp; <img  src="img/cancelaciones.png" height="25"/></div>
        <div class="clean"></div>
        <div class="recuadroC">
            <div class="row " style="">
                <div class="col ">
                    <div id="" style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cancelmotivos%>"/></div>
                    </div>
                    <div class="clean"></div>
                    <div id="containerC1" style="height: 160px; overflow: scroll;padding-top:15px">
                        <canvas id="canvasC1" height="80" width="550" style="margin:auto;"></canvas>
                    </div>
                </div>
                <div class="col ">
                    <div id="containerC2" style="">
                        <div style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;padding-bottom:35px">
                            <div style=""><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cancelstatus%>"/></div>
                        </div>
                        <canvas id="canvasStatus" height="60" style="margin:auto;"></canvas>

                        <div style="height: 25px; border-bottom: 2px solid #939393; margin-bottom: 10px;padding-bottom:35px">
                            <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_canceltipos%>"/></div>
                        </div>
                        <canvas id="canvasTipos" height="60" style="margin:auto;"></canvas>
                    </div>
                </div>
            </div>
            <div class="col ">
                <div id="" style="height: 24px; border-bottom: 2px solid #939393; margin-bottom: 10px;margin-left:-15px;padding-bottom:35px">
                    <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cancelanalisis%>"/></div>
                </div>
                <div style="height: 180px; margin-top: -10px">
                    <div class='table-cont' id='table-contC'>
                        <table id="tablaC" class="table tablaAdmin" style="font-weight: normal!important">
                            <thead>
                                <tr>
                                    <th scope="col" width="35%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_canceltgrupo%>"/> </th>
                                    <th scope="col" width="35%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_canceltmonto%>"/></th>
                                    <%--<th scope="col" width="20%">Venta real</th>--%>
                                    <%--<th scope="col" width="10%">% Monto</th>--%>
                                    <th scope="col" width="30%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_cancelporciones%>"/></th>
                                    <%--<th scope="col" width="10%">Porciones reales</th>--%>
                                    <%--<th scope="col" width="10%">% Porciones</th>--%>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
            <A name="descuentos" id="descuentos"></A>
            <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top:10px;border-top:2px solid #ededed;width:100%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostitulo%>"/> <img  src="img/descuentos.png" height="25"/></div>
        <div class="clean"></div>
        <div class="recuadroDesc">
            <div class="row " style="">
                <div class="col ">
                    <div id="" style="height: 24px; border-bottom: 2px solid #939393; margin-bottom: 10px;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostipo%>"/></div>
                    </div>
                    <div id="containerDesc1" style="height: 160px; overflow: scroll;padding-top:15px">
                        <canvas id="canvasDesc1" height="130" width="550" style="margin:auto;"></canvas>
                    </div>
                </div>

                <div class="col ">
                    <div id="" style="height: 24px; border-bottom: 2px solid #939393; margin-bottom: 10px;;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentosconcepto%>"/></div>
                    </div>
                    <div id="containerDesc2" style="height: 150px; overflow: scroll;padding-top:15px">
                        <canvas id="canvasDesc2" height="150" width="550" style="margin:auto;padding: 5px;"></canvas>
                    </div>
                </div>

            </div>

            <div class="row " style="">
                <div class="col ">
                    <div id="" style="height: 24px; border-bottom: 2px solid #939393; margin-bottom: 10px;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="<%$Resources:multi.language,dash_decuentosanalisis%>"/></div>
                    </div>
                </div>
            </div>
            <div class="row " style="">
                <div class="col ">
                    <div style="height: 180px; margin-top: -10px">
                        <div class='table-cont' id='table-contD'>
                            <table id="tablaDesc" class="table tablaAdmin" style="font-weight: normal!important">
                                <thead>
                                    <tr>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostunidad%>"/> </th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostoriginal%>"/></th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostmonto%>"/></th>
                                        <th scope="col" width="10%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostdescuento%>"/></th>
                                        <th scope="col" width="10%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostneta%>"/></th>
                                        <th scope="col" width="10%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostporcentaje%>"/></th>
                                        <th scope="col" width="10%"><asp:Label runat="server" Text="<%$Resources:multi.language,dash_descuentostporciones%>"/></th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row " style="">
                <div class="col ">
                    <div id="" style="height: 24px; border-bottom: 2px solid #939393; margin-bottom: 10px;padding-bottom:35px">
                        <div><asp:Label runat="server" Text="Detalles"/></div>
                    </div>
                </div>
            </div>
            <div class="row " style="">
                <div class="col ">
                    <div style="height: 180px; margin-top: -10px">
                        <div class='table-cont' id='table-contDD'>
                            <table id="tablaDescD" class="table tablaAdmin" style="font-weight: normal!important">
                                <thead>
                                    <tr>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text=""/></th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="Tipo"/> </th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="Monto"/></th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="Desc"/></th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="Cliente"/> </th>
                                        <th scope="col" width="20%"><asp:Label runat="server" Text="Aut."/></th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <div id="menuFlotante">
        <ul>
	        <li style="padding:6px"><a href="#pagos" data-ancla="pagos" class="ancla" style="text-align:center"><img  src="img/metodospago_2.png" height="30"/></a></li>
	        <li style="padding:6px"><a href="#vhoras" data-ancla="vhoras" class="ancla" style="text-align:center"> <img  src="img/ventashora_2.png" height="30"/></a></li>
	        <li style="padding:6px"><div id="containerIndex" style="">
                                        <a href="#home" data-ancla="home" class="ancla" style="text-align:center" id="iconoIndex"> <img  src="img/home_2.png" height="55"/></a>
	                                </div></li>
	        <li style="padding:6px"><a href="#cancelaciones" data-ancla="cancelaciones" class="ancla" style="text-align:center"><img  src="img/cancelaciones_2.png" height="30"/></a></li>
	        <li style="padding:6px"><a href="#descuentos" data-ancla="descuentos" class="ancla" style="text-align:center"><img  src="img/descuentos_2.png" height="30"/></a></li>
        </ul>
    </div>

    </div>
</asp:Content>



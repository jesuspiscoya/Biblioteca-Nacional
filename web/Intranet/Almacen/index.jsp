<%@page import="servicio.LibroServicioImp"%>
<%@page import="servicio.LibroServicio"%>
<%@page import="servicio.UbigeoServicioImp"%>
<%@page import="servicio.TipoServicioImp"%>
<%@page import="servicio.UbigeoServicio"%>
<%@page import="servicio.TipoServicio"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>

<%
    LibroServicio libSer = new LibroServicioImp();
    List lisCat = libSer.listarCategoria();

    Gson gsonObj = new Gson();
    Map<Object, Object> map = null;
    int totalVisitors = 883000;
    List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();

    map = new HashMap<Object, Object>();
    map.put("y", 519960);
    map.put("name", "New Visitors");
    map.put("color", "#E7823A");
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("y", 363040);
    map.put("name", "Returning Visitors");
    map.put("color", "#546BC1");
    list.add(map);

    String newVsReturningVisitorsDataPoints = gsonObj.toJson(list);

    list = new ArrayList<Map<Object, Object>>();
    map = new HashMap<Object, Object>();
    map.put("x", 1420050600000L);
    map.put("y", 33000);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1422729000000L);
    map.put("y", 35960);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1425148200000L);
    map.put("y", 42160);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1427826600000L);
    map.put("y", 42240);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1430418600000L);
    map.put("y", 43200);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1433097000000L);
    map.put("y", 40600);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1435689000000L);
    map.put("y", 42560);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1438367400000L);
    map.put("y", 44280);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1441045800000L);
    map.put("y", 44800);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1443637800000L);
    map.put("y", 48720);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1446316200000L);
    map.put("y", 50840);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1448908200000L);
    map.put("y", 51600);
    list.add(map);

    String newVisitorsDataPoints = gsonObj.toJson(list);

    list = new ArrayList<Map<Object, Object>>();
    map = new HashMap<Object, Object>();
    map.put("x", 1420050600000L);
    map.put("y", 22000);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1422729000000L);
    map.put("y", 26040);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1425148200000L);
    map.put("y", 25840);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1427826600000L);
    map.put("y", 23760);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1430418600000L);
    map.put("y", 28800);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1433097000000L);
    map.put("y", 29400);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1435689000000L);
    map.put("y", 33440);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1438367400000L);
    map.put("y", 37720);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1441045800000L);
    map.put("y", 35200);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1443637800000L);
    map.put("y", 35280);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1446316200000L);
    map.put("y", 31160);
    list.add(map);
    map = new HashMap<Object, Object>();
    map.put("x", 1448908200000L);
    map.put("y", 34400);
    list.add(map);
    Object[] obj = (Object[]) session.getAttribute("filaBus");

    String returningVisitorsDataPoints = gsonObj.toJson(list);
    Object[] fila = {"", "", "", "", "", "", "", "", "", "", "", ""};
    if (obj != null) {
        fila = obj;
    }
    
    
List listaLib = libSer.listar();

%>
<%! int cantidad; %>
<% cantidad=listaLib.size()-1; %>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../../js/ubigeo.js"></script>
        <script src="../../js/ubigeo2.js"></script>
        <script type="text/javascript">
            window.onload = function () {

                var totalVisitors = <%out.print(totalVisitors);%>;
                var visitorsData = {
                    "New vs Returning Visitors": [{
                            click: visitorsChartDrilldownHandler,
                            cursor: "pointer",
                            explodeOnClick: false,
                            innerRadius: "75%",
                            legendMarkerType: "square",
                            name: "New vs Returning Visitors",
                            radius: "100%",
                            showInLegend: true,
                            startAngle: 90,
                            type: "doughnut",
                            dataPoints: <%out.print(newVsReturningVisitorsDataPoints);%>
                        }],
                    "New Visitors": [{
                            color: "#E7823A",
                            name: "New Visitors",
                            type: "column",
                            xValueType: "dateTime",
                            dataPoints: <%out.print(newVisitorsDataPoints);%>
                        }],
                    "Returning Visitors": [{
                            color: "#546BC1",
                            name: "Returning Visitors",
                            type: "column",
                            xValueType: "dateTime",
                            dataPoints: <%out.print(returningVisitorsDataPoints);%>
                        }]
                };

                var newVSReturningVisitorsOptions = {
                    animationEnabled: true,
                    theme: "light2",
                    title: {
                        text: "New VS Returning Visitors"
                    },
                    subtitles: [{
                            text: "Click on Any Segment to Drilldown",
                            backgroundColor: "#2eacd1",
                            fontSize: 16,
                            fontColor: "white",
                            padding: 5
                        }],
                    legend: {
                        fontFamily: "calibri",
                        fontSize: 14,
                        itemTextFormatter: function (e) {
                            return e.dataPoint.name + ": " + Math.round(e.dataPoint.y / totalVisitors * 100) + "%";
                        }
                    },
                    data: []
                };

                var visitorsDrilldownedChartOptions = {
                    animationEnabled: true,
                    theme: "light2",
                    axisX: {
                        labelFontColor: "#717171",
                        lineColor: "#a2a2a2",
                        tickColor: "#a2a2a2"
                    },
                    axisY: {
                        gridThickness: 0,
                        includeZero: false,
                        labelFontColor: "#717171",
                        lineColor: "#a2a2a2",
                        tickColor: "#a2a2a2",
                        lineThickness: 1
                    },
                    data: []
                };

                var chart = new CanvasJS.Chart("chartContainer", newVSReturningVisitorsOptions);
                chart.options.data = visitorsData["New vs Returning Visitors"];
                chart.render();

                function visitorsChartDrilldownHandler(e) {
                    chart = new CanvasJS.Chart("chartContainer", visitorsDrilldownedChartOptions);
                    chart.options.data = visitorsData[e.dataPoint.name];
                    chart.options.title = {text: e.dataPoint.name}
                    chart.render();
                    $("#backButton").toggleClass("invisible");
                }

                $("#backButton").click(function () {
                    $(this).toggleClass("invisible");
                    chart = new CanvasJS.Chart("chartContainer", newVSReturningVisitorsOptions);
                    chart.options.data = visitorsData["New vs Returning Visitors"];
                    chart.render();
                });

            }
        </script>
        <style>
            #backButton {
                border-radius: 4px;
                padding: 8px;
                border: none;
                font-size: 16px;
                background-color: #2eacd1;
                color: white;
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
            }
            .invisible {
                display: none;
            }
        </style>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../css/style.css">
        <script src="https://kit.fontawesome.com/50872a9b90.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
        <title>Biblioteca</title>
    </head>
    <body>
        <main class="container-fluid p-0">
            <jsp:include page="../Admin/navAdmin.jsp" />

            <% Object[] inicio = (Object[]) session.getAttribute("filaInicio");%>
            <div class="d-flex" style="height: 94vh">

                <div class="col-8 m-auto ">
                    <div class="row">
                        <div class="col-12 my-3 shadow d-flex bg-secondary justify-content-center">
                            <ul class="mb-lg-0">
                                <div class="p-3 bg-secondary bg-gradient">
                                    <h1 class="text-light h4 text-uppercase"><i class="fas fa-user-tie"></i> Cargo: <%= inicio[2]%></h1>
                                </div>
                            </ul>
                        </div>
                        <div class="col-12 shadow p-3 bg-body rounded ">
                            <div id="chartContainer" style="height: 370px; width: 100%;"></div>
                            <button class="btn invisible" id="backButton">&lt; Back</button>
                        </div>
                        <div class="col-12 shadow p-3 bg-body rounded my-5 d-flex justify-content-center">
                            <div class="card" >
                                <div class="card-body">
                                    <a href="Libros.jsp" class="text-decoration-none">
                                        <div class="alert alert-secondary fw-bold text-center h4" role="alert">
                                            <%=cantidad%> libros
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <!-- Button trigger modal -->
                                    <button type="button" class=" alert alert-secondary fw-bold text-center h4" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                        Agregar Libro
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <div class="modal-content">
                                                <form action="../../LibroControl" method="post">


                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Registrar Libro</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>

                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <span class="input-group-text" id="inputGroup-sizing-lg">Nombre</span>
                                                                <input type="text" required class="form-control" name="Nombre" aria-label="Sizing example input" aria-describedby="inputGroup-sizing">
                                                            </div>
                                                            <div class="col-6">
                                                                <span class="input-group-text" id="inputGroup-sizing-lg">Categoría</span>
                                                                <select class="form-select form-control" aria-label="Default select example" name="Categoria" required>
                                                                    <option selected>Seleccione</option>
                                                                    <% for (int i = 1; i < lisCat.size(); i++) { %>
                                                                    <% Object[] cat = (Object[]) lisCat.get(i);%>
                                                                    <option value="<%= cat[0]%>"><%= cat[1]%></option>
                                                                    <% }%>
                                                                </select>
                                                            </div>
                                                            <div class="col-6 my-2">
                                                                <span class="input-group-text" id="inputGroup-sizing-lg">Stock</span>
                                                                <input type="text" required class="form-control" name="Stock" aria-label="Sizing example input" aria-describedby="inputGroup-sizing" maxlength="3" onkeyup="this.value = Numeros(this.value)">
                                                            </div>
                                                            <div class="col-6 my-2">
                                                                <span class="input-group-text" id="inputGroup-sizing-lg">Precio</span>
                                                                <div class="input-group">
                                                                    <span class="input-group-text">S/ </span>
                                                                    <input type="text" required class="form-control" name="Precio" aria-label="Sizing example input" aria-describedby="inputGroup-sizing" maxlength="6" onkeyup="this.value = Precios(this.value)">
                                                                </div>
                                                            </div>
                                                            <div class="col-12 my-2">
                                                                <span class="input-group-text" id="inputGroup-sizing-lg">Descripcion</span>
                                                                <textarea required class="form-control" name="Descripcion" id="floatingTextarea2" style="height: 125px" aria-label="Sizing example input" aria-describedby="inputGroup-sizing"></textarea>
                                                            </div>
                                                            <div class="col-12 my-2">
                                                    <span class="input-group-text" id="inputGroup-sizing-lg">Portada</span>
                                                    <input type="file" accept="image/*" required class="form-control" name="Portada" aria-label="Sizing example input" aria-describedby="inputGroup-sizing">
                                                </div>

                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="cargo" value="<%= inicio[2]%>">

                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                        <input type="submit" class="btn  btn-primary" name="acc" value="Registrar">

                                                    </div>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
        </main>
        <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    </body>
</html>                                 
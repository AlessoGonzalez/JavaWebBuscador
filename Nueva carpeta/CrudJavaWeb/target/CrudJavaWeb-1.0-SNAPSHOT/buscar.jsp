<%@page import="CrudJavaWeb.api"%>
<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>

        <form method="POST" autocomplete="off">
            <div class="mb-3">
                <label for="cedula" class="form-label">Cedula requerida</label>
                <input type="text" class="form-control" id="cedula" name="cedula">
            </div>
            <button type="submit" class="btn btn-primary">Buscar</button>
        </form>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">CEDULA</th>
                    <th scope="col">NOMBRE</th>
                    <th scope="col">APELLIDO</th>
                    <th scope="col">DIRECCION</th>
                    <th scope="col">TELEFONO</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
            </thead>

            <tbody>  

                <%
                    if (!(request.getMethod().equals("POST"))) {
                        return;
                    }
                    String id = "";
                    try {
                        id = request.getParameter("cedula");
                        //cliente
                        HttpClient cliente = HttpClient.newHttpClient();
                        //solicitud
                        HttpRequest solicitud = HttpRequest.newBuilder()
                                .uri(URI.create(api.getApi() + "?cedula=" + id))
                                .GET()
                                .build();
                        //respuesta
                        HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());

                        JSONArray jsonArray = new JSONArray(respuesta.body());
                        if (jsonArray.isEmpty()) {
                            out.print("<br>");
                            out.print("<div class='alert alert-danger'" + "role='alert'>No encontrado</div>");
                            return;
                        } else {
                            out.print("<br>");
                            out.print("<div class='alert alert-success'" + "role='alert'>Buscados con exito</div>");
                        }
                        for (int i = 0; i < jsonArray.length(); i++) {
                            String cedula = jsonArray.getJSONObject(i).getString("cedula").toString();
                            String nombre = jsonArray.getJSONObject(i).getString("nombre").toString();
                            String apellido = jsonArray.getJSONObject(i).getString("apellido").toString();
                            String direccion = jsonArray.getJSONObject(i).getString("direccion").toString();
                            String telefono = jsonArray.getJSONObject(i).getString("telefono").toString();
                %>
                <tr>
                    <td><%= cedula%></td>
                    <td><%= nombre%></td>
                    <td><%= apellido%></td>
                    <td><%= direccion%></td>
                    <td><%= telefono%></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.print("<br>");
                        out.print("<div class='alert alert-success'" + "role='alert'>ERROR AL BUSCAR</div>");
                    }
                %>

            </tbody>

        </table>
    </body>

</html>